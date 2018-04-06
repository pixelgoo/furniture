/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// Add css and image modules to Webpack

'use strict';

function requireAll(r) { r.keys().forEach(r) }
requireAll(require.context('../images/', true, /\.(gif|jpg|jpeg|png|svg|webp)$/i))
requireAll(require.context('../stylesheets/', true, /\.(css|scss|sass)$/i))

// Add jQuery
import $ from 'jquery'
global.$ = $
global.jQuery = $

// Add Bootstrap
import 'bootstrap';

// Add JS Uglifier
import Rails from 'rails-ujs'
Rails.start()

// Add Turbolinks
import Turbolinks from 'turbolinks'
Turbolinks.start()

// Add application modules
import App from '../javascript/app'

$(document).ready(function() {
    let woodmister = new App()
    woodmister.init()
})

