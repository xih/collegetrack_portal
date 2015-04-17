// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var EmailFilter = {
    setup: function() {
        $('#email_form').on('click', '#change_filter', EmailFilter.slideOpen);
        $('#filters').on('click', '.x', EmailFilter.remove);
    },
    slideOpen: function() {
        $('#accordian').animate({width: 'toggle'});
        return false;
    },
    remove: function() {
        var filterText = $(this).prev().text();
        $(this).parent().remove();
        $(".selected").each(function() {
            if ($(this).text() == filterText) {
                $(this).toggleClass('selected');
                return false;
            }
        });
        Filter.pull_emails();
    }
};

var editBox;
var allowedRepeat = false;
var RecipientField = {
    setup: function() {
        $('#recipient_header').on('dblclick', '.filter_box, .edit_box', RecipientField.edit);
        $('#recipient_header').on('keypress', '.recipient_text', RecipientField.checkEnter);
        $('#recipient_header').on('keydown', '.recipient_text', RecipientField.checkBackspace);
        $('#recipient_header').on('keyup', '.recipient_text', RecipientField.checkSpace);
        $('#recipient_header').on('keypress', '.recipient_text', RecipientField.autoGrow);
        $('#recipient_header').on('paste', '.recipient_text', RecipientField.paste);
        $('#recipient_header').on('blur', '.recipient_text', RecipientField.restore);
        $('#recipient_header').on('selectstart', '.filter_box, .edit_box', RecipientField.disableSelect);
        $('#recipient_header').on('click', '.x', RecipientField.remove);
        $('#recipient_header').on('keypress', '#email_subject', RecipientField.disableEnter);
        $('#recipient_header').on('click', '.recipient_right', RecipientField.selectTextArea);
    },
    disableSelect: function() {
        return false;
    },
    disableEnter: function() {
        var key = (event.keyCode ? event.keyCode : event.which);
        if (key === 13) {
            return false;
        }
    },
    edit: function() {
        $(this).parent().find('.recipient_text').detach();
        var boxWidth = $(this).outerWidth();
        $(this).replaceWith('<textarea class="recipient_text" rows="1" style="width: ' + boxWidth + 'px;">' + $(this).text() + '</textarea>');
        $(event.target).parent().find('.recipient_text').select();
        return false;
    },
    restore: function() {
        var input = $(this).val().trim();
        var parent = $(this).parent();
        if (input === '') {
            $(this).remove();
        } else {
            var emails = input.split(/[ ,]+/);
            var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            var prev = ($(this).prev().length === 0) ? $(this) : $(this).prev();
            for (email of emails) {
                if (filter.test(email)) {
                    $(prev).after("<div class='edit_box'><span class='ui_fil'><div class ='left_fil'>" + email + "</div><div class='x'></div></span><input name='message[bcc][]' type='hidden' value='" + email + "'></div>");
                } else {
                    var restEmails = emails.slice(emails.indexOf(email));
                    var restEmails = restEmails.join(" ");
                    $(prev).after('<textarea class="recipient_text" rows="1">' + restEmails + '</textarea>');
                    break;
                }
                prev = $(prev).next();
            }
            $(this).remove();
        }
        if ($(this).find('.recipient_text').length < 0) {
            $(parent).append('<textarea class="recipient_text" rows="1"></textarea>');
        }
        $(RecipientField.resizeField);
        var endOfText = $(parent).find('.recipient_text').val();
        $(parent).find('.recipient_text').focus().val("").val(endOfText);
    },
    paste: function() {
        var input = $(this);
        setTimeout(function () {
            input.blur();
        }, 100);
    },
    remove: function() {
        $(this).parent().parent().remove();
        $(RecipientField.resizeField);
    },
    resizeField: function() {
        $('.recipient_right').each(function() {
            var rowWidth = 0;
            var divWidth = $(this).width();
            $(this).children('div').each(function() {
                cellWidth = $(this).outerWidth();
                if (rowWidth + cellWidth > divWidth) {
                    rowWidth = 0; 
                }
                rowWidth += $(this).outerWidth();
            });
            var resizeWidth = divWidth - rowWidth - 20;
            if (resizeWidth < 40) {
                resizeWidth = divWidth;
            }
            $(this).find('.recipient_text').outerWidth(resizeWidth);
        });
    },
    autoGrow: function() {
        allowedRepeat = false;
        var elem = $(this)
        setTimeout(function () {
            var width = RecipientField.getTextWidth(elem);
            var divWidth = $('.recipient_right').width();
            if (width + 100 >= divWidth) {
                width = divWidth - 20;
            }
            $(elem).width(width + 40);
        }, 100);
    },
    getTextWidth: function(elem) {
        var html_calc = $('<span>' + $(elem).val() + '</span>');
        html_calc.css('font-size',$(elem).css('font-size')).hide();
        html_calc.prependTo('body');
        var width = html_calc.outerWidth();
        html_calc.remove();
        return width;
    },
    checkEnter: function(e) {
        var key = (e.keyCode ? e.keyCode : e.which);
        if (key === 13) {
            var parent = $(this).parent();
            $(this).blur();
            $(parent).find('.recipient_text').select();
            return false;
        }
    },
    checkBackspace: function(e) {
        var key = (e.keyCode ? e.keyCode : e.which);
        if (!allowedRepeat) return;
        if ($(this).val() === '' && key === 8) {
            $(this).prev().remove();
            allowedRepeat = false;
        }
    },
    checkSpace: function(e) {
        var key = (e.keyCode ? e.keyCode : e.which);
        var email = $(this).val().trim();
        var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        if (key === 8 && $(this).val() === '') {
            allowedRepeat = true;
        } else if (key === 32 && filter.test(email)) {
            var parent = $(this).parent();
            $(this).blur();
            $(parent).find('.recipient_text').select();
            return false;
        }
    },
    selectTextArea: function() {
        if(event.target == this) {
            $(this).find('.recipient_text').focus();
        }
    }
};

var EmailSend = {
    setup: function() {
        $('input[name="send_msg"').on('click', EmailSend.parse);
    },
    parse: function() {
        var data = '<%=j params[:message] %>';
        console.log(data);
    }
}


$(EmailFilter.setup);
$(RecipientField.setup);
$(EmailSend.setup);

// Expanding textarea still weird.
// Parse pasted text delimiters = space and comma
// shrink away when clicking away from div
// clicking once outlines