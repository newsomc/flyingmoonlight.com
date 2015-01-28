$( document ).ready(function() {
  
  var randomPhoto = function() {
    var random = Math.floor(Math.random() * $('.photo-row').length);
    $('.photo-row').hide().eq(random).show();
  };

  console.log(window.location.pathname);
  
  var init = function() {
    randomPhoto();
  };

  init();

});
