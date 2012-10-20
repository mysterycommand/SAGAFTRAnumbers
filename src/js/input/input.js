(function() {
  var define, log, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery', 'input/job-type', 'chosen'], function($, JobType) {
    var Input;
    Input = (function() {

      function Input(el) {
        this.el = el;
        this.onChange = __bind(this.onChange, this);
        this.$el = $(this.el);
        this.jobType = new JobType();
        this.jobType.$el.prependTo(this.$el);
        this.$el.on('change', '.chzn-select', this.onChange);
      }

      Input.prototype.onChange = function(event) {
        return this.$el.find('.chzn-select').not('.chzn-done').chosen({
          allow_single_deselect: true,
          disable_search_threshold: 20
        });
      };

      Input.prototype.clear = function() {
        return this.jobType.$el.find('#job-type').val(-1).trigger('liszt:updated').trigger('change');
      };

      return Input;

    })();
    return Input;
  });

}).call(this);
