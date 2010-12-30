// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// When click a vote button
// Append the current candidate to the val

function showPrompt(message) {
  $("#bubble .prompt-text").text(message);
  
  $('#prompt').animate({bottom: 0}, function () {
    setTimeout(function() {
      $('#prompt').animate({bottom: -182});
    }, 3000);
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

  var tweet_box = $("#tbox iframe").contents().find("textarea");
  var current_index = current_selection.indexOf(candidate);
  if (current_index == -1) {
    markSelected(candidate);
    current_selection.push(candidate);
  } else {
    unmarkSelected(candidate);
    current_selection.delete(current_index);
  }

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
  tweet_box.val("I'd #vote " + message + " #sfmayor. How about you? http://sfmayorvote.com @sfbos");

  if (current_selection.length == 1 && !approvalPromptShown) {
    showPrompt("Yep, select as many as you approve of, then tweet to vote.");
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
});
