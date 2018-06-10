import Filters from "./Filters";
import Settings from "./Settings"

export default class App {

  constructor() { 
    this.init();
  }

  init() {
    console.log('App inited');

    new Settings();

    if($('.product-filters').length > 0) {
      new Filters();
    }
  }

}
