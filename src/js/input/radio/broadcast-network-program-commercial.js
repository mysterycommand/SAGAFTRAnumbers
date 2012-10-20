(function() {
  var define, log, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery', 'underscore'], function($, _) {
    var NetworkProgramCommercial;
    NetworkProgramCommercial = (function() {

      function NetworkProgramCommercial() {
        this.onChange = __bind(this.onChange, this);        this.label = "Network Program Commercial";
        this.html = "<fieldset>\n  Thirteen week cycle, with a \n  <select name=\"network-program-use-type\" id=\"network-program-use-type\" class=\"chzn-select\" data-placeholder=\"please choose...\">\n    <option value=\"-1\"></option>\n  </select>\n</fieldset>";
        this.$el = $(this.html);
        this.el = this.$el[0];
        this.setupOptions();
        this.$el.on('change', '#network-program-use-type', this.onChange);
      }

      NetworkProgramCommercial.prototype.setupOptions = function() {
        var html;
        this.selectedIndex = -1;
        this.selectedItem = null;
        this.options = [];
        html = '';
        _.each(this.options, function(el, i) {
          return html += "<option value=\"" + i + "\">" + el + "</option>";
        });
        return this.$el.find('select').append(this.options);
      };

      NetworkProgramCommercial.prototype.getSelectedItem = function() {
        return this.selectedItem;
      };

      NetworkProgramCommercial.prototype.onChange = function(event) {
        this.selectedIndex = parseInt(event.target.value, 10);
        return this.selectedItem = this.selectedIndex !== -1 ? this.options[this.selectedIndex] : null;
      };

      return NetworkProgramCommercial;

    })();
    return NetworkProgramCommercial;
  });

}).call(this);
