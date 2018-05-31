import Filters from "./Filters";

export default class App {

    constructor() { 
        this.init();
    }

    init() {
        console.log('App inited');

        if($('.product-filters').length > 0) {
            new Filters();
        }
    }

}
