function chosen_init() {
  $(".chosen-select").chosen().change();
}

$(document).on('turbolinks:load', function(){chosen_init()});
