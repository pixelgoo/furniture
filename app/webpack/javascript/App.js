import Filters from "./Filters";
import FileUpload from "./FileUpload";

export default class App {

    constructor() { 
        this.init();
    }

    init() {
        console.log('App inited');

        if($('.product-filters').length > 0) {
            new Filters();
        }

        if ($('.directUpload').length > 0) {
            new FileUpload();
        }
    }

}
