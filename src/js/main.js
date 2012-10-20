
/*
  Author: Matt Hayes
*/

(function() {
  var log, require, root;

  root = this;

  log = root.log;

  require = root.require;

  require.config({
    paths: {
      'jquery': '//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min'
    }
  });

  require(['jquery'], function($) {
    var onClickLogo, onClickStart;
    onClickStart = function(event) {
      event.preventDefault();
      $('.hud .start, .calculator .both').fadeOut(400);
      $('.hud .estimate, .hud h5, nav li').fadeIn(400);
      $('footer h3, footer h4, footer address').show(400, function() {
        return $('.page').removeClass('home');
      });
    };
    onClickLogo = function(event) {
      event.preventDefault();
      $('.page').addClass('home');
      $('.hud .start, .calculator .both').fadeIn(400);
      $('.hud .estimate, .hud h5, nav li').fadeOut(400);
      $('footer h3, footer h4, footer address').hide(400);
    };
    $(document).on('click', '.start a', onClickStart).on('click', 'h1 a', onClickLogo);
  });

}).call(this);
