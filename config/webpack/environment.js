const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')

// Add webp to FileLoader
const FileLoader = environment.loaders.get('file')
FileLoader.test = /\.(jpg|jpeg|png|gif|webp|tiff|ico|svg|eot|otf|ttf|woff|woff2)$/i

// Add Vue.js
environment.loaders.append('vue', vue)

if (!module.hot) {
    environment.loaders.get('sass').use.find(item => item.loader === 'sass-loader').options.sourceMapContents = false;
}

module.exports = environment
