import Preloader from "./Preloader";
import PerfectScrollbar from '../javascript/vendor/perfect-scrollbar.common';
import '../stylesheets/vendor/perfect-scrollbar.css';

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
      $("#loading").removeClass('animated fadeOut').addClass('animated fadeIn').show();
    });

    $(document).on('ajax:success', () => {
      console.log('AJAX completed');
      this.setProductsList();
    });

    this.setProductsList();
    new PerfectScrollbar('.product-filters');
    new PerfectScrollbar('#products');
  }

  setProductsList() {
    setTimeout(function() {
      let preloader = new Preloader();
      preloader.init();
    })
  }
}
