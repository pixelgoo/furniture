/* eslint no-console:0 */

'use strict';

// Add css and image modules to Webpack
function requireAll(r) { r.keys().forEach(r) }
requireAll(require.context('../images/', true, /\.(gif|jpg|jpeg|png|svg|webp)$/i))
requireAll(require.context('../stylesheets/', true, /\.(css|scss|sass)$/i))

// Add jQuery
import $ from 'jquery'
global.$ = $
global.jQuery = $

// Add Bootstrap
import 'bootstrap';

// Add Unobstructive JS
import Rails from 'rails-ujs'
Rails.start()

// Add Turbolinks
import Turbolinks from 'turbolinks'
Turbolinks.start()

// Add File Upload
import jqueryUI from '../javascript/vendor/jquery.ui.widget'
import jqueryUpload from '../javascript/vendor/z.jquery.fileupload'
jqueryUI();
jqueryUpload();

// Add application modules
import App from '../javascript/App.js'

window.addEventListener("DOMContentLoaded", function () {
    let app = new App()

    $(document).on('turbolinks:load', function() {
      app.initializePage();
    });
});
