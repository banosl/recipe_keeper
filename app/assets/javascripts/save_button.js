  $(document).ready(function() {
    $('input[type=radio]').change(function() {
      if ($('input[type=radio]:checked').length > 0) {
        $('#save_button').prop('disabled', false);
        $(console).log("disabled");
      } else {
        $('#save_button').prop('disabled', true);
        $(console).log("enabled");
      }
    });
  });