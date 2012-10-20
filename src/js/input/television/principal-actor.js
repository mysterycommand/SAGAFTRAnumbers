(function() {
  var define, log, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery'], function($) {
    var PrincipalActor;
    PrincipalActor = (function() {

      function PrincipalActor(index) {
        this.index = index;
        this.onInputActors = __bind(this.onInputActors, this);
        this.html = "<fieldset>\n  I'll need\n  <input type=\"number\" name=\"num-actors\" id=\"num-actors\" value=\"0\" min=\"0\" max=\"2\">\n  <a href=\"#principal-actor\">principal actor</a>(s).\n</fieldset>";
        this.$el = $(this.html);
        this.el = this.$el[0];
        this.$el.on('input', '#num-actors', this.onInputActors);
      }

      PrincipalActor.prototype.onInputActors = function(event) {};

      return PrincipalActor;

    })();
    return PrincipalActor;
  });

}).call(this);
