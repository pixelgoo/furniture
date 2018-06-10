export default class Settings {

  constructor() { 
    this.init();
  }

  init() {
    console.log('Settings inited');

    this.initDirectUpload();
    this.initRegionsCheckboxes();
  }

  initDirectUpload() {
    $('.directUpload').find("input:file").each(function (i, elem) {
      var fileInput = $(elem);
      var form = $(fileInput.parents('form:first'));
      var submitButton = form.find('input[type="submit"]');
      var progressBar = $("<div class='directUpload__bar'></div>");
      var barContainer = $("<div class='directUpload__progress'></div>").append(progressBar);
      fileInput.after(barContainer);
      fileInput.fileupload({
        fileInput: fileInput,
        url: form.data('url'),
        type: 'POST',
        autoUpload: true,
        formData: form.data('form-data'),
        paramName: 'file',
        dataType: 'XML',
        replaceFileInput: false,
        progressall: function (e, data) {
          var progress = parseInt(data.loaded / data.total * 100, 10);
          progressBar.css('width', progress + '%')
        },
        start: function (e) {
          submitButton.prop('disabled', true);
          console.log('Uploading started...');
          progressBar.
            css('background', 'green').
            css('display', 'block').
            css('width', '0%').
            text("Loading...");
        },
        done: function (e, data) {
          submitButton.prop('disabled', false);
          progressBar.text("Файл успешно загружен");
          console.log('Uploaded!');

          var key = $(data.jqXHR.responseXML).find("Key").text();
          var url = '//' + form.data('host') + '/' + key;

          var input = $("<input />", { type: 'hidden', name: fileInput.attr('documents_confirmed'), value: url })
          form.append(input);
        },
        fail: function (e, data) {
          submitButton.prop('disabled', false);
          console.log('Upload failed.');

          progressBar.
            css("background", "red").
            text("Загрузка не удалась. Перезагрузите страницу и попробуйте снова.");
        }
      });
    });
  }

  initRegionsCheckboxes() {
    $(document).on('click', '.form-check_all-regions', function() {
      if($(this).find('.form-check-input_all-regions').prop('checked')) {
        $('.form-check-input_region').prop('checked', true);
      } else {
        $('.form-check-input_region').prop('checked', false);
      }
    })
  }

}
