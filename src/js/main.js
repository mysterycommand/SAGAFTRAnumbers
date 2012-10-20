
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
    return log('It worked!');
  });

}).call(this);
