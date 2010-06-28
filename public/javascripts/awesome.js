jQuery(document).ready(function($){

  var slideWidth = 600;

  $('.slider').prepend('<a id="slider-left" class="slider-nav" href="#"><</a>');
  $('.slider').prepend('<a id="slider-right" class="slider-nav" href="#">></a>');
  $('#slider-left').hide();

  function isAtBeginning(){
    return (parseInt($('.slider').css('margin-left'), 10) == 0);
  }

  function isAtEnd(){
    var marg = parseInt($('.slider').css('margin-left'), 10);
    return ( -marg == slideWidth * ($('.post-preview').length -1 ));
  }

  function mover(d) {
    return function(event) {
      event.preventDefault;
      var sliderMargin = parseInt($('.slider').css('margin-left'), 10);
      var newMargin = (sliderMargin + d) + 'px';

      $('.slider').css('margin-left', newMargin);
      if (isAtBeginning()){
        $('#slider-left').hide();
        $('#slider-right').show();
      }
      if (isAtEnd()){
        $('#slider-left').show();
        $('#slider-right').hide();
      }
    }
  }

  $('#slider-left').click(mover(slideWidth));
  $('#slider-right').click(mover(-slideWidth));
});