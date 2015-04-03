function validateUserForm() {

  jQuery.validator.addMethod("max_size", function(value, element) {
    if (value.length < 255)
      return true;
    else
      return false;
  });

  $('#form_user').validate({
    debug: true,
    rules: {
      "user[name]": {
        required: true,
        max_size: true
      },
      "user[email]": {
        required: true,
        max_size: true
      },
       "user[password]": {
        required: true,
        max_size: true
      }
    },
    errorElement: "span",
    errorClass: "help-block",

    messages: {

      "user[name]": {
        required: "Name can't be blank",
        max_size: "It exceeds 255 characters."
      },
       "user[email]": {
        required: "Email can't be blank",
        max_size: "It exceeds 255 characters."
      },
       "user[password]": {
        required: "Password can't be blank"
      }
    },

    highlight: function(element) {
      $(element).parent().parent().addClass("has-error");
    },
    unhighlight: function(element) {
      $(element).parent().parent().removeClass("has-error");
    },
    invalidHandler: function(event, validator) {
        // 'this' refers to the form
        var errors = validator.numberOfInvalids();
        if (errors) {

          // Populating error message
          var errorMessage = errors == 1
          ? 'You missed 1 field. It has been highlighted'
          : 'You missed ' + errors + ' fields. They have been highlighted';

          // Removing the form error if it already exists
          $("#div_user_js_validation_error").remove();

          errorHtml = "<div id='div_user_js_validation_error' class=\"alert alert-danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorMessage +"</div>"
          $("#div_modal_generic div.modal-body-main").prepend(errorHtml);

          // Show error labels
          $("div.error").show();

        } else {
          // Hide error labels
          $("div.error").hide();
          // Removing the error message
          $("#div_user_js_validation_error").remove();
        }
      },
      submitHandler: function(form) {

       form.submit();
     }

   });

}