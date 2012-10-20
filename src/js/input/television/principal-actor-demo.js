(function() {
  var define, log, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery', 'input/principal-actor-character'], function($, PrincipalActorCharacter) {
    var PrincipalActorDemo;
    PrincipalActorDemo = (function() {

      function PrincipalActorDemo(index) {
        this.index = index;
        this.onInputActors = __bind(this.onInputActors, this);
        this.html = "<fieldset>\n  I'll need\n  <input type=\"number\" name=\"num-actors\" id=\"num-actors\" value=\"0\" min=\"0\" max=\"10\">\n  <a href=\"#principal-actor\">principal actor</a>(s).\n</fieldset>";
        this.$el = $(this.html);
        this.el = this.$el[0];
        this.actors = [];
        this.$el.on('input', '#num-actors', this.onInputActors);
      }

      PrincipalActorDemo.prototype.onInputActors = function(event) {
        var actor, numActors, _results, _results2;
        numActors = parseInt(event.target.value, 10);
        if (numActors === this.actors.length) return;
        if (numActors > this.actors.length) {
          _results = [];
          while (this.actors.length < numActors) {
            actor = new PrincipalActorCharacter(this.actors.length);
            this.actors.push(actor);
            _results.push(this.$el.appendPolyfill(actor.$el));
          }
          return _results;
        } else {
          _results2 = [];
          while (this.actors.length > numActors) {
            _results2.push(this.actors.pop().$el.remove());
          }
          return _results2;
        }
      };

      return PrincipalActorDemo;

    })();
    return PrincipalActorDemo;
  });

}).call(this);
