jQuery(document).ready(function($){

  var slideWidth = 598;

  $('.slider').prepend('<a id="slider-left" class="slider-nav" href="#"><</a>');
  $('.slider').prepend('<a id="slider-right" class="slider-nav" href="#">></a>');
  $('#slider-left').hide();

  function isAtBeginning(){
    var retVal = false;
    if (parseInt($('.slider').css('margin-left'), 10) == 0){
      retVal = true;
    };
    return retVal;
  }

  function isAtEnd(){
    var retVal = false;
    var marg = parseInt($('.slider').css('margin-left'), 10);
    if ( -marg == slideWidth * ($('.post-preview').length -1 )){
      retVal = true;
    };
    return retVal;
  }

  $('#slider-left').click(function(){
    var sliderMargin = parseInt($('.slider').css('margin-left'), 10);
    var newMargin = (sliderMargin + slideWidth) + 'px';
    if (isAtBeginning()){
      $('#slider-left').hide();
    }else{
      $('#slider-right').show();
      $('.slider').css('margin-left', newMargin);
    };
  });

  $('#slider-right').click(function(){
    var sliderMargin = parseInt($('.slider').css('margin-left'), 10);
    var newMargin = (sliderMargin - slideWidth) + 'px';
    if (isAtEnd()){
      $('#slider-right').hide();
    }else{
      $('#slider-left').show();
      $('.slider').css('margin-left', newMargin);
    };
  });
});