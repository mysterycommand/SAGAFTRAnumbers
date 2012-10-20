(function() {
  var define, log, root;

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery', 'input/input', 'output/output'], function($, Input, Output) {
    var App;
    App = (function() {

      function App(el) {
        this.el = el;
        this.$el = $(this.el);
        this.input = new Input(this.$el.find('#input')[0]);
        this.output = new Output(this.$el.find('#output')[0]);
        this.input.$el.on('change', this.output.onChange);
      }

      App.prototype.start = function() {};

      App.prototype.restart = function() {
        this.input.clear();
        return this.output.clear();
      };

      return App;

    })();
    return App;
  });

}).call(this);
