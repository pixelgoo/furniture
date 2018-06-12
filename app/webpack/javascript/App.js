import Preloader from './Preloader'
import Filters from "./Filters";
import Profile from "./Profile"

export default class App {

  constructor() { 
    this.init();
  }

  init() {
    console.log('App inited');

    this.initializePage();
    this.initializeTooltips();
  }

  initializePage() {
    if($('.preload').length > 0 && $('.product-filters').length == 0) {
      let preloader = new Preloader();
      preloader.init();
    }

    if($('.product-filters').length > 0) {
      new Filters();
    }
  }

  initializeTooltips() {
    $('[data-toggle="tooltip"]').tooltip();
  }

}
