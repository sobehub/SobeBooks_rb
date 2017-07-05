// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require modernizr.custom.js
//= require classie.js
//= require elastic_grid.min.js
//= require bootstrap-sprockets
//= require bootstrap
//= require bootstrap-multiselect
//= require_tree .
//= require bootstrap-multiselect
//= require script




// Sticky Tabs - like Gmail (Primary, Update, Social)

// function sticky_relocate() {
//     var window_top = $(window).scrollTop();
//     var div_top = $('#sticky-anchor').offset().top;
//     if (window_top > div_top) {
//               $('#sticky').addClass('tab-margin');

//         $('#sticky').addClass('stick');
//         $('#sticky').css('margin-top',"50px");
//         $('#sticky').css('width',$("#tab-content").width());

//     } else {
//         $('#sticky').removeClass('stick');
//         $('#sticky').css('margin-top',"0px");
//         $('#sticky').css('width',$("#tab-content").width());
//     }
// }

// $(function () {
//     $(window).scroll(sticky_relocate);
//     sticky_relocate();
// });