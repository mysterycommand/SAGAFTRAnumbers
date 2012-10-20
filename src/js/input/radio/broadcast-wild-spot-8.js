(function() {
  var define, log, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery', 'underscore'], function($, _) {
    var WildSpot8;
    WildSpot8 = (function() {

      function WildSpot8() {
        this.onChange = __bind(this.onChange, this);        this.label = "Wild Spot - 8 week cycle";
        this.html = "<fieldset>\n  It will be broadcast in the following markets:\n  <select name=\"markets\" id=\"markets\" multiple class=\"chzn-select\" data-placeholder=\"please choose...\">\n    <option value=\"-1\"></option>\n  </select>\n</fieldset>";
        this.$el = $(this.html);
        this.el = this.$el[0];
        this.setupOptions();
        this.$el.on('change', '#markets', this.onChange);
      }

      WildSpot8.prototype.setupOptions = function() {
        var html;
        this.selectedIndex = -1;
        this.selectedItem = null;
        this.options = [];
        html = '';
        _.each(this.options, function(el, i) {
          return html += "<option value=\"" + i + "\">" + el.label + "</option>";
        });
        return this.$el.find('select').append(this.options);
      };

      WildSpot8.prototype.getSelectedItem = function() {
        return this.selectedItem;
      };

      WildSpot8.prototype.onChange = function(event) {
        this.selectedIndex = parseInt(event.target.value, 10);
        return this.selectedItem = this.selectedIndex !== -1 ? this.options[this.selectedIndex] : null;
      };

      return WildSpot8;

    })();
    return WildSpot8;
  });

}).call(this);
