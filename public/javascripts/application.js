// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// When click a vote button
// Append the current candidate to the val

function showPrompt(message) {
  $("#bubble .prompt-text").text(message);
  
  $('#prompt').animate({bottom: 0}, function () {
    setTimeout(function() {
      $('#prompt').animate({bottom: -182});
    }, 6000);
  });
}

function unmarkSelected(choice) {
  var button = $('.vote-button[data-tag=' + choice + ']');
  button.removeClass('vote-confirmed');
}

function markSelected(choice) {
  var button = $('.vote-button[data-tag=' + choice + ']');
  button.addClass('vote-confirmed');
  return button;
}

function markVoted(choice) {
  var button = markSelected(choice);
  if (!button.is('.small-button')) {
    button.text("voted for " + choice);
  }
}

var approvalPromptShown = false;

var buttonHandler = function(e){
  e.preventDefault();
  // get this candidate's name
  var candidate = $(e.target).data("tag");
  if (candidate == undefined) {
    candidate = $(e.target).parent().data('tag')
  }

  var current_index = current_selection.indexOf(candidate);
  if (current_index == -1) {
    markSelected(candidate);
    current_selection.push(candidate);
  } else {
    unmarkSelected(candidate);
    current_selection.splice(current_index, 1);
  }

  var tweet_box = $("#tbox iframe").contents().find("textarea");
  tweet_box.focus(); // so the character count updates, and to draw the user's attention
  // replace the contents with a vote
  var message;
  if (current_selection.length > 1) {
    var last = current_selection.pop();
    message = current_selection.join(', ') + " or " + last;
    current_selection.push(last);
  } else {
    message = current_selection[0];
  }
  message = "I'd #vote " + message + " #sfmayor.";
  if (message.length <= 95) {
    message += " How about you? http://sfmayorvote.com @sfbos";
  } else if (message.length <= 110) {
    message += " http://sfmayorvote.com @sfbos";
  } else if (message.length <= 117) {
    message += " http://sfmayorvote.com";
  }
  if (current_selection.length == 0) {
    message = "How would you #vote for interim #sfmayor? http://sfmayorvote.com";
  }
  tweet_box.val(message);

  if (current_selection.length == 1 && !approvalPromptShown) {
    showPrompt("Yep, select as many as you like then tweet to vote.");
    approvalPromptShown = true
  }
};

// Redirect iPhone/iPod visitors
function isiPhone(){
    return (
        (navigator.platform.indexOf("iPhone") != -1) ||
        (navigator.platform.indexOf("iPod") != -1)
    );
}

$(document).ready(function(){
  $(".vote-button").live("click", buttonHandler);
  if(!isiPhone()){
    $("#tbox").stickyScroll({ mode: 'manual' });
  }

  $('a.fancyboxy').fancybox();
});
