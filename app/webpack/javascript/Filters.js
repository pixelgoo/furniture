import Preloader from "./Preloader";

export default class Filters {

  constructor() {
    console.log('Filters inited');
    this.init();
  }

  init() {
    $(document).on('click', '.product-filters__title', function() {
      $(this).siblings('.product-filters__list').toggleClass('opened');
    })

    $(document).on('ajax:send', () => {
      console.log('AJAX started');
      $('.product').css('animation-duration', '0.2s').addClass('animated zoomOut');
      setTimeout(() => { $('.product').remove() }, 200);
      $("#loading").removeClass('animated fadeOutUp').addClass('animated fadeInDown').show();
    });

    $(document).on('ajax:success', () => {
      console.log('AJAX completed');
      this.setProductsList();
    });

    this.setProductsList();
  }

  setProductsList() {
    this.makeSticky($('.product-filters'));
    
    setTimeout(function() {
      let preloader = new Preloader();
      preloader.init();
    })
  }

  makeSticky(sticky) {
    let pos = sticky.offset().top, win = $(window);
    win.on("scroll", function () {
      win.scrollTop() >= pos ? sticky.addClass("fixed") : sticky.removeClass("fixed");
    });		
  }
}
