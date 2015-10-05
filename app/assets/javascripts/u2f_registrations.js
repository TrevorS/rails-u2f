var ready = function() {
  var form = $('#u2f-reg-form');

  if (form.length > 0) {

    var registrationRequests = $('#registrationRequests').data('requests');
    var signRequests         = $('#signRequests').data('requests');

    console.log('registrationRequests', registrationRequests);
    console.log('signRequests', signRequests);

    u2f.register(registrationRequests, signRequests, function(registerResponse) {

      if (registerResponse.errorCode) {
        var errorMessage = window.U2F_ERROR_CODES[registerResponse.errorCode];
        console.log('errorMessage', errorMessage);
        return;
      }

      response = $('#u2f-reg-form-response');

      console.log('registerResponse', registerResponse);

      response.val(JSON.stringify(registerResponse));

      form.submit();
    }, 15);
  }
};

$(document).ready(ready);
$(document).on('page:load', ready);
