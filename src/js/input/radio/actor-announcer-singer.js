(function() {
  var define, log, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery', 'input/actor-announcer-character'], function($, ActorAnnouncerCharacter) {
    var ActorAnnouncerSinger;
    ActorAnnouncerSinger = (function() {

      function ActorAnnouncerSinger() {
        this.onInputSingers = __bind(this.onInputSingers, this);
        this.onInputActors = __bind(this.onInputActors, this);        this.html = "<fieldset>\n  I'll need\n  <input type=\"number\" name=\"num-actors\" id=\"num-actors\" value=\"0\" min=\"0\" max=\"10\">\n  <a href=\"#actor-announcer\">actor/announcer</a>(s) and\n  <input type=\"number\" name=\"num-singers\" id=\"num-singers\" value=\"0\" min=\"0\" max=\"2\">\n  <a href=\"#singer\">singer</a>(s).\n  <span style=\"display: none;\" id=\"more-singers\">\n    Looking for more singers?\n    <a href=\"mailto:togren@sagaftra.org?subject=SAG-AFTRAnumbers%20Question\">Contact Tim at SAG-AFTRA</a>!\n  </span>\n</fieldset>";
        this.$el = $(this.html);
        this.el = this.$el[0];
        this.actors = [];
        this.$el.on('input', '#num-actors', this.onInputActors);
        this.$el.on('input', '#num-singers', this.onInputSingers);
      }

      ActorAnnouncerSinger.prototype.onInputActors = function(event) {
        var actor, numActors, _results, _results2;
        numActors = parseInt(event.target.value, 10);
        if (numActors === this.actors.length) return;
        if (numActors > this.actors.length) {
          _results = [];
          while (this.actors.length < numActors) {
            actor = new ActorAnnouncerCharacter(this.actors.length);
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

      ActorAnnouncerSinger.prototype.onInputSingers = function(event) {
        if (event.target.value === $(event.target).attr('max')) {
          return this.$el.find('#more-singers').filter(":hidden").show();
        } else {
          return this.$el.find('#more-singers').filter(":visible").hide();
        }
      };

      return ActorAnnouncerSinger;

    })();
    return ActorAnnouncerSinger;
  });

}).call(this);
