import Filters from "./Filters";
import Profile from "./Profile"

export default class App {

  constructor() { 
    this.init();
  }

  init() {
    console.log('App inited');

    new Profile();

    if($('.product-filters').length > 0) {
      new Filters();
    }

    this.initializeTooltips();
  }

  initializeTooltips() {
    $('[data-toggle="tooltip"]').tooltip();
  }

}
