export default class Profile {

  constructor() { 
    this.init();
  }

  init() {
    console.log('Settings inited');

    this.initDirectUpload();
    this.initSettingsCheckboxes();
  }

  initDirectUpload() {
    $('.directUpload').find("input:file").each(function (i, elem) {
      let fileInput = $(elem);
      let form = $(fileInput.parents('form:first'));
      let submitButton = form.find('input[type="submit"]');
      let progressBar = $("<div class='directUpload__bar'></div>");
      let barContainer = $("<div class='directUpload__progress'></div>").append(progressBar);
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
          fileInput.hide();
          submitButton.prop('disabled', true);
          console.log('Uploading started...');
          progressBar.
            css('background', '#37bf37').
            css('display', 'block').
            css('width', '0%')
        },
        done: function (e, data) {
          submitButton.prop('disabled', false);
          progressBar.text("Файл успешно загружен");
          console.log('Uploaded!');
        },
        fail: function (e, data) {
          submitButton.prop('disabled', false);
          console.log('Upload failed.');

          progressBar.
            css("background", "rgb(237, 77, 77) ").
            text("Загрузка не удалась. Перезагрузите страницу и попробуйте снова.");
        }
      });
    });
  }

  initSettingsCheckboxes() {
    $(document).on('click', '.form-check_all-regions', function() {
      if($(this).find('.form-check-input_all-regions').prop('checked')) {
        $('.form-check-input_region').prop('checked', true);
      } else {
        $('.form-check-input_region').prop('checked', false);
      }
    })
  }

}
