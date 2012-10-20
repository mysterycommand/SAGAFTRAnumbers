(function() {
  var define, log, root;

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery', 'underscore', 'input/television/day', 'input/version'], function($, _, Day, Version) {
    var PublicServiceAnnouncementTelevisionOnCamera;
    PublicServiceAnnouncementTelevisionOnCamera = (function() {

      function PublicServiceAnnouncementTelevisionOnCamera() {
        var _this = this;
        this.label = "Public Service Announcement - Television (On Camera)";
        this.steps = [new Day(), new Version()];
        this.el = [];
        _.each(this.steps, function(el, i) {
          return _this.el.push(el.el);
        });
        this.$el = $(this.el);
      }

      PublicServiceAnnouncementTelevisionOnCamera.prototype.destroy = function() {
        return this.$el.off("**");
      };

      return PublicServiceAnnouncementTelevisionOnCamera;

    })();
    return PublicServiceAnnouncementTelevisionOnCamera;
  });

}).call(this);
