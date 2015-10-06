var ready = function() {
  var form = $('#u2f-auth-form');

  if (form.length > 0) {

    var signRequests = $('#signRequests').data('requests');

    u2f.sign(signRequests, function(signResponse) {

      if (signResponse.errorCode) {
        var errorMessage = window.U2F_ERROR_CODES[signResponse.errorCode];
        console.error('errorMessage', errorMessage);
        return;
      }

      var response = $('#u2f-auth-form-response');

      response.val(JSON.stringify(signResponse));

      form.submit();
    }, 15);
  }
};

$(document).ready(ready);
$(document).on('page:load', ready);
