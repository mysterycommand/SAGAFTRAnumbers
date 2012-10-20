(function() {
  var define, log, root;

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery'], function($) {
    var Output;
    Output = (function() {

      function Output(el) {
        this.el = el;
        this.$el = $(this.el);
      }

      Output.prototype.clear = function() {};

      return Output;

    })();
    return Output;
  });

}).call(this);
