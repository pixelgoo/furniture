import Filters from "./Filters";

export default class App {

    constructor() { 
        this.init();
    }

    init() {
        console.log('App inited');
        new Filters();
    }

}
