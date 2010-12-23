
/* with cred to http://fissl.com/zeugs/js_explosion/ */
/* also cf. http://www.zachstronaut.com/posts/2009/08/07/jquery-animate-css-rotate-scale.html */

function explosion() {
 // var explosion = $('#logo');
 /*
 $('.explosion').append('<div class="inferno"></div>');
 $('.inferno').css({height:200, width: 200, backgroundImage: 'url(explosion_inferno.png)'});
 $('.inferno').scale(.1);
 $('.inferno').animate({scale: '5', opacity: 0}, 5000);
 */
 $('#logo').empty();
 $('#logo').append('<div class="egg burst"></div>');
 $('.burst').css({height:200, width: 200, backgroundImage: 'url(/images/explosion_burst.png)'});
 $('.burst').scale(.1);
 $('.burst').animate({scale: '1', opacity: 50}, 100, function() {
   $('#logo').append('<div class="egg inferno"></div>');
   $('.inferno').css({height:200, width: 200, backgroundImage: 'url(/images/explosion_inferno.png)', opacity: 0});
   $('.inferno').scale(.5);
   $('.inferno').animate({scale: .8, opacity: 1}, 500, function() {
     $(this).animate({scale: .6, opacity: 0}, 4000);
	 $(this).append('<div class="egg dust"></div>');
	 $('.dust').css({height:200, width: 200, backgroundImage: 'url(/images/explosion_dust.png)', opacity:0});
     $('.dust').scale(1);
     $('.dust').animate({scale: .5, opacity: 100}, 8000);
   });
   $('.burst').animate({opacity: 0});
   $('#logo').append('<div class="egg soil"></div>');
   $('.soil').css({height:200, width: 200, backgroundImage: 'url(/images/explosion_soil.png)'});
   $('.soil').scale(.5);
   $('.soil').animate({scale: 1.7, opacity: 0}, 5000);
 });

}




