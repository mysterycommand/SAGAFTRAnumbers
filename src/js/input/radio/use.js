(function() {
  var define, log, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery', 'underscore', 'input/radio/use-broadcast', 'input/radio/use-internet', 'input/radio/use-both'], function($, _, UseBroadcast, UseInternet, UseBoth) {
    var Use;
    Use = (function() {

      function Use() {
        this.onBroadcastChange = __bind(this.onBroadcastChange, this);
        this.onUseChange = __bind(this.onUseChange, this);        this.html = "<fieldset>\n  This commercial will air\n  <select name=\"use-type\" id=\"use-type\" class=\"chzn-select\" data-placeholder=\"please choose...\">\n    <option value=\"-1\"></option>\n  </select>\n</fieldset>";
        this.$el = $(this.html);
        this.el = this.$el[0];
        this.setupOptions();
        this.$el.on('change', '#use-type', this.onUseChange);
      }

      Use.prototype.setupOptions = function() {
        var html;
        this.selectedIndex = -1;
        this.selectedItem = null;
        this.options = [new UseBroadcast(), new UseInternet(), new UseBoth()];
        html = '';
        _.each(this.options, function(el, i) {
          return html += "<option value=\"" + i + "\">" + el.label + "</option>";
        });
        return this.$el.find('select').append(html);
      };

      Use.prototype.onUseChange = function(event) {
        this.selectedIndex = parseInt(event.target.value, 10);
        this.selectedItem = this.selectedIndex !== -1 ? this.options[this.selectedIndex] : null;
        this.$el.find('p').detach();
        this.$el.nextAll().detach();
        if (this.selectedItem != null) {
          this.$el.appendPolyfill(this.selectedItem.$el);
          if (this.selectedIndex === 0 || this.selectedIndex === 2) {
            this.$el.off('change', '#broadcast-type').on('change', '#broadcast-type', this.onBroadcastChange);
            return this.selectedItem.$el.find('#broadcast-type').trigger('change');
          }
        }
      };

      Use.prototype.onBroadcastChange = function(event) {
        var broadcastType;
        this.$el.nextAll().detach();
        broadcastType = this.selectedItem.getSelectedItem();
        if (broadcastType != null) {
          return this.$el.afterPolyfill(broadcastType.$el);
        }
      };

      return Use;

    })();
    return Use;
  });

}).call(this);
