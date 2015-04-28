$(document).ready(function() {
  // Disable autoDiscover
  Dropzone.autoDiscover = false;

  // grap our upload form by its id
  $("#email_form").dropzone({
    uploadMultiple: true,
    paramName: "email[files]",
    maxFilesize: 4,
    addRemoveLinks: true,
    autoProcessQueue: false,
    parallelUploads: 50,
    maxFiles: 10,
    previewsContainer: "#dropzone-preview",

    init: function() {
      var myDropzone = this;
      var submitForm = document.querySelector('input[type="submit"]');

      submitForm.addEventListener('click', function(e) {
        if(myDropzone.getQueuedFiles().length > 0) {
          e.preventDefault();
          e.stopPropagation();

          tinyMCE.get('email_body').save();
          myDropzone.processQueue();
        };
      });

      this.on("queuecomplete", function() {
        myDropzone.removeAllFiles();
      });
    }
  });
});