$(document).ready(function(){
  $('#notes').hide();
  $('#show_info').toggle(
    function() {
      $('#content').hide('slow');
      $('#notes').show();
      if ($('#notes') && $('#notes').data('class').length > 0) {
        $('body').addClass($('#notes').data('class'));
      }
    }, function() {
      $('#notes').hide();
      $('#content').show('fast');
      if ($('#notes') && $('#notes').data('class').length > 0) {
        $('body').removeClass($('#notes').data('class'));
      }
  });
  jQuery(document).bind('keypress', 'i', function(evt) {
    if($('#notes').length > 0) {
      $('#show_info').click();   
    }
  });
  if ($('#notes').length == 0) {
    $('#show_info').hide();
  }
});