export default class Filters {

  constructor() {
    console.log('Filters inited');
    this.init();
  }

  init() {
    this.makeSticky($('.product-filters'));

    $(document).on('click', '.product-filters__title', function() {
      $(this).siblings('.product-filters__list').toggleClass('opened');
    })
  }

  makeSticky(sticky) {
    let pos = sticky.offset().top, win = $(window);
    win.on("scroll", function () {
      win.scrollTop() >= pos ? sticky.addClass("fixed") : sticky.removeClass("fixed");
    });		
  }
}
