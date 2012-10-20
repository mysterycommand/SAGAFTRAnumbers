(function() {
  var define, log, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery', 'underscore', 'input/television/broadcast-wild-spot-13', 'input/television/broadcast-local-cable-13', 'input/television/broadcast-national-cable-13', 'input/television/broadcast-network-program-commercial'], function($, _, WildSpot13, LocalCable13, NationalCable13, NetworkProgramCommercial) {
    var UseBroadcast;
    UseBroadcast = (function() {

      function UseBroadcast() {
        this.onChange = __bind(this.onChange, this);        this.label = "only as a television broadcast";
        this.html = "<p>\n  It will be broadcast as a\n  <select name=\"broadcast-type\" id=\"broadcast-type\" class=\"chzn-select\" data-placeholder=\"please choose...\">\n    <option value=\"-1\"></option>\n  </select>\n</p>";
        this.$el = $(this.html);
        this.el = this.$el[0];
        this.setupOptions();
        this.$el.on('change', '#broadcast-type', this.onChange);
      }

      UseBroadcast.prototype.setupOptions = function() {
        var html;
        this.selectedIndex = -1;
        this.selectedItem = null;
        this.options = [new WildSpot13(), new LocalCable13(), new NationalCable13(), new NetworkProgramCommercial()];
        html = '';
        _.each(this.options, function(el, i) {
          return html += "<option value=\"" + i + "\">" + el.label + "</option>";
        });
        return this.$el.find('select').append(html);
      };

      UseBroadcast.prototype.getSelectedItem = function() {
        return this.selectedItem;
      };

      UseBroadcast.prototype.onChange = function(event) {
        this.selectedIndex = parseInt(event.target.value, 10);
        return this.selectedItem = this.selectedIndex !== -1 ? this.options[this.selectedIndex] : null;
      };

      return UseBroadcast;

    })();
    return UseBroadcast;
  });

}).call(this);
