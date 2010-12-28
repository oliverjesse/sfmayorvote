// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// When click a vote button
// Append the current candidate to the val

function markVoted(choice) {
  var button = $('.vote-button[data-tag=' + choice + ']');
  button.addClass('vote-confirmed');
  if (!button.is('.small-button')) {
    button.text("voted for " + choice);
  }
}

var buttonHandler = function(e){
  e.preventDefault();
  // get this candidate's name
  var candidate = $(e.target).data("tag");
  if (candidate == undefined) {
    candidate = $(e.target).parent().data('tag')
  }

  var tweet_box = $("#tbox iframe").contents().find("textarea");

  tweet_box.focus(); // so the character count updates, and to draw the user's attention
  // replace the contents with a vote
  tweet_box.val("I'd #vote " + candidate + " #sfmayor. How 'bout u? http://sfmayorvote.com @sfbos");
  currentSelection = candidate;
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
