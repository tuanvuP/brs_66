$(document).ready(function(){
  $('#chose-unchecked').click(function(){
    $('.unchecked-list').show();
    $('.checked-list').hide()
  });
  $('#chose-checked').click(function(){
    $('.checked-list').show();
    $('.unchecked-list').hide()
  });
});
