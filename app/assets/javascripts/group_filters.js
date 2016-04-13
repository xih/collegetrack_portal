var previously_selected = null;

function grab_group_and_save(filters) {
    $(this).toggleClass('selected');
    if (previously_selected) {
        previously_selected.toggleClass('selected');
        previously_selected = $(this);
    }
    console.log($(this));
    console.log(filters);
    var selections = filters.split(", ");
    console.log(selections);
    for (var i = 0; i < selections.length; i++) {
        var s = selections[i];
        var query = '#accordian a:contains("' + String(s) +'")';
        console.log(query);
        $(query).toggleClass('selected');
    }
    console.log(previously_selected);
    Filter.save();
}

