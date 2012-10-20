(function() {
  var define, log, root;

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery'], function($) {
    var ExtraWardrobe;
    ExtraWardrobe = (function() {

      function ExtraWardrobe(index) {
        this.index = index;
        this.html = "<li>\n  <input type=\"checkbox\" name=\"extra-" + this.index + "-wardrobe-fitting\" value=\"1\" checked>\n  wardrobe fitting for general extra " + (this.index + 1) + ".\n</li>";
        this.$el = $(this.html);
        this.el = this.$el[0];
      }

      return ExtraWardrobe;

    })();
    return ExtraWardrobe;
  });

}).call(this);
