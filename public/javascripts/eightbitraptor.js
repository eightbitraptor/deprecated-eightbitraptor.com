jQuery.noConflict();

var Eightbitraptor = {
  init: function($){
    console.log($('div.latest-tweet'));
    $('div.latest-tweet')
      .hide()
      .delay(1000)
      .fadeIn("slow");
  }
};
