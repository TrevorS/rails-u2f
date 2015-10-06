var ready = function() {
  var form = $('#u2f-reg-form');

  if (form.length > 0) {

    var registrationRequests = $('#registrationRequests').data('requests');
    var signRequests         = $('#signRequests').data('requests');

    u2f.register(registrationRequests, signRequests, function(registerResponse) {

      if (registerResponse.errorCode) {
        var errorMessage = window.U2F_ERROR_CODES[registerResponse.errorCode];
        console.error('errorMessage', errorMessage);
        return;
      }

      response = $('#u2f-reg-form-response');

      response.val(JSON.stringify(registerResponse));

      form.submit();
    }, 15);
  }
};

$(document).ready(ready);
$(document).on('page:load', ready);
