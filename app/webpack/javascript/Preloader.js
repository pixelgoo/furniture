export default class Preloader {

  constructor() {
    this.images = $('.preload');
    this.imgCounter = $('.preload').length;
    this.loaded = 0;
    this.loadingPercent = '0%';
  }

  init() {
    console.log('Preloading ' + this.imgCounter + ' images...');

    if(this.imgCounter == 0) {
      console.log('No images, done.');
      $("#loading").removeClass('animated fadeInDown').addClass('animated fadeOutUp').delay(200).hide(0);
      return;
    }

    let checkLoading = setInterval(function () {
      console.log(this.loaded);
      if (this.loaded === this.imgCounter) {
        $("#loading").removeClass('animated fadeInDown').addClass('animated fadeOutUp').delay(200).hide(0);
        clearInterval(checkLoading);
      }
    }, 100);

    this.preloadImage();
  }

  setLoadingPercent() {
    this.loadingPercent = parseInt(this.loaded * 100 / this.imgCounter) + '%';
  }

  imageLoadedCallback(status) {
    console.log('Image loaded: ' + status);
    this.setLoadingPercent(++this.loaded);
    console.log(this.loadingPercent);

    if (this.loaded === this.imgCounter) {
      console.log('Preload over');
    } else {
      this.preloadImage();
    }
  }

  preloadImage() {

    let el = $(this.images[this.loaded]);
    let url;

    if (typeof el.attr('data-preload-img') !== 'undefined') {
      url = el.attr('data-preload-img');
    } else {
      this.imageLoadedCallback('error');
    }

    let self = this;
    this.testImage(url).then(

      function fulfilled(img) {
        self.imageLoadedCallback('OK');
        el.append(img);
      },

      function rejected() {
        self.imageLoadedCallback('error');
        el.parents('.product').hide();
      }

    ); 
  }

  testImage(url) {
    let imgElement = new Image();

    const imgPromise = new Promise(function imgPromise(resolve, reject) {
      const imgElement = new Image();

      imgElement.addEventListener('load', function imgOnLoad() {
        resolve(this);
      });

      imgElement.addEventListener('error', function imgOnError() {
        reject();
      })

      imgElement.src = url;
    });

    return imgPromise;
  }
}
