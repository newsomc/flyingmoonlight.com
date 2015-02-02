$( document ).ready(function() {

  var releaseFormatModal = function(string) {
    var title = string.charAt(0).toUpperCase() + string.slice(1);
    return " - " + title;
  };
  
  var randomPhoto = function() {
    var random = Math.floor(Math.random() * $('.photo-row').length);
    $('.photo-row').hide().eq(random).show();
  };
  
  var init = function() {
    randomPhoto();
  };
  
  init();
  
  $('.sidebar-selectpicker').selectpicker().change(function () {
    var $format = $(this).val(),
        $price = $(this).find(':selected').data('price');
    $('.release-title-format').append(releaseFormatModal($format));
    $('.release-price').html($price);
    $('#release-modal').modal('show');
  });

  $('.modal-selectpicker').selectpicker().change(function () {
    var $format = $(this).val(),
        $price = $(this).find(':selected').data('price');
    $('.release-title-format').html(releaseFormatModal($format));
    $('.release-price').html($price);
  });
  
});
