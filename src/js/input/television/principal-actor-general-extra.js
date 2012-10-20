// Generated by CoffeeScript 1.3.3
(function() {
  var define, log, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery'], function($) {
    var PrincipalActorGeneralExtra;
    PrincipalActorGeneralExtra = (function() {

      function PrincipalActorGeneralExtra(index) {
        this.index = index;
        this.onInputExtras = __bind(this.onInputExtras, this);

        this.onInputActors = __bind(this.onInputActors, this);

        this.html = "<div>\n  On day " + this.index + ", I'll need\n  <input type=\"number\" name=\"day-" + this.index + "-num-actors\" id=\"day-" + this.index + "-num-actors\" class=\"actor\" value=\"0\" min=\"0\" max=\"10\">\n  <a href=\"#principal-actor\" class=\"term open\">principal actor</a>(s) and\n  <input type=\"number\" name=\"day-" + this.index + "-num-extras\" id=\"day-" + this.index + "-num-extras\" class=\"extra\" value=\"0\" min=\"0\" max=\"10\">\n  <a href=\"#general-extra\" class=\"term open\">general extra</a>(s).\n  <div class=\"actors\" style=\"display: none\">\n    <input type=\"number\" name=\"day-" + this.index + "-actors-wardrobe\" id=\"day-" + this.index + "-actors-wardrobe\" class=\"actors-wardrobe\" value=\"0\" min=\"0\" max=\"0\">\n    principal actor(s) will need wardrobe fittings.\n  </div>\n  <div class=\"extras\" style=\"display: none\">\n    <input type=\"number\" name=\"day-" + this.index + "-extras-wardrobe\" id=\"day-" + this.index + "-extras-wardrobe\" class=\"extras-wardrobe\" value=\"0\" min=\"0\" max=\"0\">\n    general extra(s) will need wardrobe fittings.\n  </div>\n</div>";
        this.$el = $(this.html);
        this.el = this.$el[0];
        this.$el.on('input change', "#day-" + this.index + "-num-actors", this.onInputActors);
        this.$el.on('input change', "#day-" + this.index + "-num-extras", this.onInputExtras);
      }

      PrincipalActorGeneralExtra.prototype.onInputActors = function(event) {
        var $fittings, numActors, prevMax, prevVal;
        numActors = parseInt(event.target.value, 10);
        if (numActors > 0) {
          this.$el.find('.actors').show();
        } else {
          this.$el.find('.actors').hide();
        }
        $fittings = this.$el.find('.actors-wardrobe');
        prevMax = parseInt($fittings.prop('max'), 10);
        prevVal = parseInt($fittings.val(), 10);
        $fittings.prop('max', numActors);
        $fittings.val(Math.max(0, prevVal + (numActors - prevMax)));
      };

      PrincipalActorGeneralExtra.prototype.onInputExtras = function(event) {
        var $fittings, numExtras, prevMax, prevVal;
        numExtras = parseInt(event.target.value, 10);
        if (numExtras > 0) {
          this.$el.find('.extras').show();
        } else {
          this.$el.find('.extras').hide();
        }
        $fittings = this.$el.find('.extras-wardrobe');
        prevMax = parseInt($fittings.prop('max'), 10);
        prevVal = parseInt($fittings.val(), 10);
        $fittings.prop('max', numExtras);
        $fittings.val(Math.max(0, prevVal + (numExtras - prevMax)));
      };

      return PrincipalActorGeneralExtra;

    })();
    return PrincipalActorGeneralExtra;
  });

}).call(this);
