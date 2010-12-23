// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// When click a vote button
// Append the current candidate to the val

Array.prototype.last = function() {return this[this.length-1];}

var	buttonHandler = function(e){
  e.preventDefault();
	// get this candidate's name
	var candidate = $(e.target).attr("data-tag");
	// get name array (from html? from server?)
	var candidates = ["@DennisHerrera","@TomAmmiano","@BevanDufty","@MarkLeno","@ArtAgnos","@WillieBrown","MattGonzalez","EdHarrington","@DavidChiu","@RossMirkarimi","@MikeHennessey","@DavidCampos","@AaronPeskin"];

	// get the tweet.
	var tweet = $("#tbox iframe").contents().find("textarea").val();

	// check for matches. if found, replace them with this name
	var matched = 0;
	_.each(candidates,function(c){
		if (tweet.match(new RegExp(c))){
			// alert(tweet);
			$("#tbox iframe").contents().find("textarea").val(tweet.replace(new RegExp(c),candidate));			
			matched = 1;
		}
	});	
	if(matched == 0){
		// append it to the textarea contents
		// $("#tbox iframe").contents().find("textarea").val(tweet + " " + candidate);
		// replace the contents with a vote
		$("#tbox iframe").contents().find("textarea").val("@sfbos: I'd #vote " + candidate + " #sfmayor. How 'bout u? ow.ly/3tvum");		
	}
};

$(document).ready(function(){
	$(".vote-button").live("click", buttonHandler);
	$(".small-vote-button").live("click", buttonHandler);
	$("#tbox").stickyScroll({ mode: 'manual' });
});