// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var Filter = {
    setup: function() {
        $('#accordian').on('click', 'h3', Filter.slide);
        $('#accordian').on('click', 'a', Filter.highlight);
        $('#save_filter').on('click', Filter.save);
        $('#check').on('click', Filter.check);
    },
    slide: function() {
    	if ($(this).next().is(":visible")) {
    		$(this).next().slideUp();
    	} else {
    		$(this).next().slideDown();
    	}
    },
    check: function() {
    	console.log($('#title input').val());
    },
    highlight: function() {
        $(this).toggleClass('selected');
        return false;
    },
    save: function() {
        var filters = "";
        $('#accordian ul').find(".selected").each(function() {
        	filters = filters.concat($(this).text().concat(", "));
        });
        var name = $('#add_group_name input');
        if(name.length) {
        	name = name.val()
        } else {
        	name = $('#add_group_name a').text()
        }
        var id = $('#name meta');
        if(id.length) {
            id = id.attr('content');
        } else {
            id = null;
        }
        var extra_emails = $('#additional input');
        if(extra_emails.length) {
            extra_emails = extra_emails.val()
        } else {
            extra_emails = $('#additional a').text()
        }
        var data = {
        	'filters': filters,
        	'name': name,
            'extra_emails': extra_emails,
            'id': id,
        }
        $.ajax({
      		url: "/groups/create",
      		type: 'POST',
      		data: data,
      		success: function(){
        		window.location.href = "/groups/index";
      		},
      		error:function(err){
       			console.log(err);
      		}
    	});
    },
};
$(Filter.setup);