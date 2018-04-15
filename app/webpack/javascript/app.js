export default class App {

    constructor() { }

    formSubmitListener(form){
        document.getElementById(form.getAttribute('id') + 'Submit').addEventListener("click", () => { form.submit(); });
    }

    init() {

        for(var form of document.forms) {
            this.formSubmitListener(form)
        }

    }
}
