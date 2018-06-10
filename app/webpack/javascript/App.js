import Filters from "./Filters";
import Settings from "./Settings"

export default class App {

  constructor() { 
    this.init();
  }

  init() {
    console.log('App inited');

    if($('.product-filters').length > 0) {
      new Filters();
    }

    if ($('.p-settings').length > 0) {
      new Settings();
    }
  }

}
