const { environment } = require('@rails/webpacker')

const FileLoader = environment.loaders.get('file')

console.log(FileLoader)
FileLoader.test = /\.(jpg|jpeg|png|gif|webp|tiff|ico|svg|eot|otf|ttf|woff|woff2)$/i

module.exports = environment
