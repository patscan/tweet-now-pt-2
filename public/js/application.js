$(document).ready(function() {
  $('#tweet').submit(function(e) {
    e.preventDefault();
    $("#success_message").remove($(this).text());
    var status = $('input[name="tweet"]').val();
    var tweet = $(this).serialize();
    $.ajax({
      type: "post",
      url: "/tweet",
      data: tweet
    }).done( function() {
      $("#success_message").append(status);
      $("#success_message").show();
      $('input[name="tweet"]').val("");
      $("#success_message").hide(2000);
      seTimeout($('("#success_message").remove($(this).text()'), 1000);

      // setTimeout('timeout_trigger()', 3000);
      // $("#success_message").remove($(this).text());

    }).fail( function() {
      $("#success_message").append("There was an error sending your tweet!");
      $("#success_message").show();
      $('input[name="tweet"]').val("");
    }); 
  });
});

