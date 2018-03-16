export default class App {

    constructor() {
        
    }

    init() {
        console.log('App inited')

        let $flash = $('.alert');

        if($flash.length > 0) {
            setTimeout(function() {
                $flash.slideUp()
            }, 2500)
        }
    }
}
 