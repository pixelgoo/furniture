export default class App {

    constructor() { }

    formSubmitListener(form){
        console.log('Ready to submit form ' + form.getAttribute('id') + ' on button ' + form.getAttribute('id') +  'Submit')
        document.getElementById(form.getAttribute('id') + 'Submit').addEventListener("click", () => { form.submit(); });
    }

    init() {

        for(var form of document.forms) {
            this.formSubmitListener(form)
        }

    }
}
