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
          $('#button_status').val(I18n.t("mark_books.mark_book.read"))
                             .css('color', 'btn-success');
        } else if ($('#status').attr('value') == 'read') {
          $('#status').val('unread');
          $('#button_status').val(I18n.t("mark_books.mark_book.unread"))
                             .css('color', 'btn-default');
        } else if ($('#status').attr('value') == 'unread') {
          $('#status').val('reading');
          $('#button_status').val(I18n.t("mark_books.mark_book.reading"))
                             .css('color', 'btn-primary');
        }
      }
    });
  });
});
