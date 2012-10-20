(function() {
  var define, log, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery', 'input/actor-wardrobe', 'input/extra-wardrobe'], function($, ActorWardrobe, ExtraWardrobe) {
    var PrincipalActorGeneralExtra;
    PrincipalActorGeneralExtra = (function() {

      function PrincipalActorGeneralExtra(index) {
        this.index = index;
        this.onInputExtras = __bind(this.onInputExtras, this);
        this.onInputActors = __bind(this.onInputActors, this);
        this.html = "<div>\n  On day " + (this.index + 1) + ", I'll need\n  <input type=\"number\" name=\"day-" + this.index + "-num-actors\" id=\"day-" + this.index + "-num-actors\" value=\"0\" min=\"0\" max=\"10\">\n  <a href=\"#principal-actor\">principal actor</a>(s) and\n  <input type=\"number\" name=\"day-" + this.index + "-num-extras\" id=\"day-" + this.index + "-num-extras\" value=\"0\" min=\"0\" max=\"10\">\n  <a href=\"#general-extra\">general extra</a>(s).\n  <ul class=\"actors\"></ul>\n  <ul class=\"extras\"></ul>\n</div>";
        this.$el = $(this.html);
        this.el = this.$el[0];
        this.actors = [];
        this.extras = [];
        this.$el.on('input', "#day-" + this.index + "-num-actors", this.onInputActors);
        this.$el.on('input', "#day-" + this.index + "-num-extras", this.onInputExtras);
      }

      PrincipalActorGeneralExtra.prototype.onInputActors = function(event) {
        var actor, numActors, _results, _results2;
        numActors = parseInt(event.target.value, 10);
        if (numActors === this.actors.length) return;
        if (numActors > this.actors.length) {
          _results = [];
          while (this.actors.length < numActors) {
            actor = new ActorWardrobe(this.actors.length);
            this.actors.push(actor);
            _results.push(this.$el.find('.actors').append(actor.$el));
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

      PrincipalActorGeneralExtra.prototype.onInputExtras = function(event) {
        var extra, numExtras, _results, _results2;
        numExtras = parseInt(event.target.value, 10);
        if (numExtras === this.extras.length) return;
        if (numExtras > this.extras.length) {
          _results = [];
          while (this.extras.length < numExtras) {
            extra = new ExtraWardrobe(this.extras.length);
            this.extras.push(extra);
            _results.push(this.$el.find('.extras').append(extra.$el));
          }
          return _results;
        } else {
          _results2 = [];
          while (this.extras.length > numExtras) {
            _results2.push(this.extras.pop().$el.remove());
          }
          return _results2;
        }
      };

      return PrincipalActorGeneralExtra;

    })();
    return PrincipalActorGeneralExtra;
  });

}).call(this);
