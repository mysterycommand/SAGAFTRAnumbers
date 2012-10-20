
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
      'jquery': 'libs/jquery-1.7.1',
      'underscore': 'libs/underscore-1.3.2',
      'colorbox': 'plugins/jquery.colorbox-1.3.19',
      'webshim': 'plugins/webshim-1.8.9/polyfiller',
      'chosen': 'plugins/chosen.jquery-0.9.8',
      'order': 'plugins/order-1.0.5'
    }
  });

  require(['order!jquery', 'order!app', 'order!colorbox', 'order!webshim', 'order!chosen'], function(jQuery, App) {
    var $;
    $ = jQuery;
    $.webshims.polyfill();
    $(function() {
      var $app, $document, $window, app, onClickLogo, onClickStart, onClickStartOver, onResize;
      $window = $(window);
      $document = $(document);
      $app = $('#app');
      app = new App($app[0]);
      $('.chzn-select').not('.chzn-done').chosen({
        allow_single_deselect: true,
        disable_search_threshold: 20
      });
      onClickStartOver = function(event) {
        event.preventDefault();
        app.restart();
      };
      onClickStart = function(event) {
        event.preventDefault();
        $('.hud .start, .calculator .both').fadeOut(400);
        $('.hud .estimate, .hud h5, nav li').fadeIn(400);
        $('footer h3, footer h4, footer address').show(400, function() {
          if (!$('.page').hasClass('home')) return null;
          $('.page').removeClass('home');
          return app.start();
        });
      };
      onClickLogo = function(event) {
        event.preventDefault();
        $('.page').addClass('home');
        $('.hud .start, .calculator .both').fadeIn(400);
        $('.hud .estimate, .hud h5, nav li').fadeOut(400);
        $('footer h3, footer h4, footer address').hide(400);
      };
      $document.find('.definitions a').colorbox({
        inline: true,
        opacity: 0.5,
        top: $app.offset().top,
        width: $app.width()
      }).end().on('click', '.start-over a', onClickStartOver).on('click', '.start a', onClickStart).on('click', 'h1 a', onClickLogo);
      onResize = function(event) {
        $.colorbox.resize({
          width: $app.width()
        });
      };
      $window.on('resize', onResize);
    });
  });

}).call(this);
