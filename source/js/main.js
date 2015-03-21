$( document ).ready(function() {

  var releaseFormatModal = function(string) {
    var title = string.charAt(0).toUpperCase() + string.slice(1);
    return " - " + title;
  };
  
  var randomPhoto = function() {
    var random = Math.floor(Math.random() * $('.photo-row').length);
    $('.photo-row').hide().eq(random).show();
  };

  //randomPhoto();
  
  $('.buy').click(function () {
    $('#release-modal').modal('show');
    $('.release-title-format').html(
      $(".modal-selectpicker option:first").data('description')
    );
  });

  $('.modal-selectpicker').selectpicker().change(function () {
    var $format = $(this).val(),
        $price = $(this).find(':selected').data('price'),
        $description = $(this).find(':selected').data('description');

    $('.release-title-format').html($description);
    $('.release-price').html($price);

    $('input[name=item_name]').val($description);
    $('input[name=amount]').val($price);
  });
  
});
