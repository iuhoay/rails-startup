//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap


$(document).ready(function() {
  $('[data-toggle=offcanvas]').click(function() {
    $('.row-offcanvas').toggleClass('active');
  });
});
