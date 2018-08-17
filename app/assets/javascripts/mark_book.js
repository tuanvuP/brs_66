$(document).ready(function(){
  $('#status_form').submit(function(e){
    e.preventDefault();
    var url = $(this).attr('action');
    var method = $(this).attr('method');
    var data = $(this).serializeArray();
    $.ajax({
      url: url,
      method: method,
      data: data,
      dataType: 'json',
      success: function(){
        if ($('#status').attr('value') == 'reading') {
          $('#status').val('read');
          $('#button_status').val('Read');
          $('#button_status').removeClass('btn-primary');
          $('#button_status').addClass('btn-success');
        } else if ($('#status').attr('value') == 'read') {
          $('#status').val('unread');
          $('#button_status').val('Unread');
          $('#button_status').removeClass('btn-success');
          $('#button_status').addClass('btn-default');
        } else if ($('#status').attr('value') == 'unread') {
          $('#status').val('reading');
          $('#button_status').val('Reading');
          $('#button_status').removeClass('btn-default');
          $('#button_status').addClass('btn-primary');
        }
      }
    });
  });
});
