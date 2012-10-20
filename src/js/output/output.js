// Generated by CoffeeScript 1.3.3
(function() {
  var define, log, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery', 'output/estimator', 'output/radio', 'output/television', 'output/psa', 'output/corp-edu'], function($, Estimator, Radio, Television, PSA, CorpEdu) {
    var Output;
    Output = (function() {

      function Output(el) {
        this.el = el;
        this.onChange = __bind(this.onChange, this);

        this.$el = $(this.el);
        this.sessionFeesEstimator = new Estimator("Session Fees Subtotal", "session-fees");
        this.usageFeesEstimator = new Estimator("Usage Fees Subtotal", "usage-fees");
        this.type = 'none';
      }

      Output.prototype.clear = function() {
        return this.$el.find('tbody').remove();
      };

      Output.prototype.onChange = function(event) {
        var $targ, agents10, hrph, payroll, subtotal, total, type;
        $targ = $(event.target);
        if ($targ.is('#job-type')) {
          type = $targ.find("[value=" + ($targ.val()) + "]").data('value');
          if (this.type !== type) {
            this.type = type;
            this.rates = root.sag_aftra_rates[this.type];
          }
        }
        this.clear();
        this.html = '';
        this.cost = 0;
        if (this.type !== 'none') {
          this[this.type]();
        }
        this.$el.find('thead').after(this.html);
        agents10 = this.cost * 0.1;
        subtotal = this.cost + agents10;
        hrph = subtotal * 0.155;
        payroll = subtotal * 0.14;
        total = subtotal + hrph + payroll;
        $('#estimate-agents-10 .amount').text(agents10.toFixed(2));
        $('#subtotal .amount').text(subtotal.toFixed(2));
        $('#estimate-hr-ph .amount').text(hrph.toFixed(2));
        $('#estimate-payroll-taxes .amount').text(payroll.toFixed(2));
        $('#total .amount').text(total.toFixed(2));
        $('#hud-total .amount').text(total.toFixed(2));
        this.$el.trigger('change');
      };

      Output.prototype.radio_commercial = function() {
        this.sessionFeesEstimator.estimate(Radio.sessionLineItems(this.rates));
        this.usageFeesEstimator.estimate(Radio.usageLineItems(this.rates));
        this.html = this.sessionFeesEstimator.html + this.usageFeesEstimator.html;
        this.cost = this.sessionFeesEstimator.cost + this.usageFeesEstimator.cost;
      };

      Output.prototype.radio_commercial_demo = function() {
        this.sessionFeesEstimator.estimate(Radio.sessionLineItems(this.rates));
        this.html = this.sessionFeesEstimator.html;
        this.cost = this.sessionFeesEstimator.cost;
      };

      Output.prototype.television_commercial_on_camera = function() {
        this.sessionFeesEstimator.estimate(Television.onCameraSessionLineItems(this.rates));
        this.usageFeesEstimator.estimate(Television.usageLineItems(this.rates));
        this.html = this.sessionFeesEstimator.html + this.usageFeesEstimator.html;
        this.cost = this.sessionFeesEstimator.cost + this.usageFeesEstimator.cost;
      };

      Output.prototype.television_commercial_off_camera = function() {
        this.sessionFeesEstimator.estimate(Television.offCameraSessionLineItems(this.rates));
        this.usageFeesEstimator.estimate(Television.usageLineItems(this.rates));
        this.html = this.sessionFeesEstimator.html + this.usageFeesEstimator.html;
        this.cost = this.sessionFeesEstimator.cost + this.usageFeesEstimator.cost;
      };

      Output.prototype.television_commercial_demo = function() {
        this.sessionFeesEstimator.estimate(Television.demoSessionLineItems(this.rates));
        this.html = this.sessionFeesEstimator.html;
        this.cost = this.sessionFeesEstimator.cost;
      };

      Output.prototype.psa_radio = function() {
        this.sessionFeesEstimator.estimate(PSA.radioSessionLineItems(this.rates));
        this.html = this.sessionFeesEstimator.html;
        this.cost = this.sessionFeesEstimator.cost;
      };

      Output.prototype.psa_television_on_camera = function() {
        this.sessionFeesEstimator.estimate(PSA.tvOnCameraSessionLineItems(this.rates));
        this.html = this.sessionFeesEstimator.html;
        this.cost = this.sessionFeesEstimator.cost;
      };

      Output.prototype.psa_television_off_camera = function() {
        this.sessionFeesEstimator.estimate(PSA.tvOffCameraSessionLineItems(this.rates));
        this.html = this.sessionFeesEstimator.html;
        this.cost = this.sessionFeesEstimator.cost;
      };

      Output.prototype.corp_edu_on_camera = function() {
        this.sessionFeesEstimator.estimate(CorpEdu.onCameraSessionLineItems(this.rates));
        this.html = this.sessionFeesEstimator.html;
        this.cost = this.sessionFeesEstimator.cost;
      };

      Output.prototype.corp_edu_off_camera = function() {
        this.sessionFeesEstimator.estimate(CorpEdu.offCameraSessionLineItems(this.rates));
        this.html = this.sessionFeesEstimator.html;
        this.cost = this.sessionFeesEstimator.cost;
      };

      Output.prototype.corp_edu_audio_only = function() {
        this.sessionFeesEstimator.estimate(CorpEdu.audioOnlySessionLineItems(this.rates));
        this.html = this.sessionFeesEstimator.html;
        this.cost = this.sessionFeesEstimator.cost;
      };

      return Output;

    })();
    return Output;
  });

}).call(this);
