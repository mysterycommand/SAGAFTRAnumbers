// Generated by CoffeeScript 1.4.0
(function(){var e,t,n,r=function(e,t){return function(){return e.apply(t,arguments)}};n=this;t=n.log;e=n.define;e(["jquery","underscore","input/television/use-broadcast-on-camera","input/television/use-internet","input/television/use-both-on-camera"],function(e,t,n,i,s){var o;o=function(){function o(){this.onBroadcastChange=r(this.onBroadcastChange,this);this.onUseChange=r(this.onUseChange,this);this.html='<fieldset>\n  This commercial will air\n  <select name="use-type" id="use-type" class="chzn-select" data-placeholder="please choose...">\n    <option value="-1"></option>\n  </select>\n</fieldset>';this.$el=e(this.html);this.el=this.$el[0];this.setupOptions();this.$el.on("change","#use-type",this.onUseChange)}o.prototype.setupOptions=function(){var e;this.selectedIndex=-1;this.selectedItem=null;this.options=[new n,new i,new s];e="";t.each(this.options,function(t,n){return e+='<option value="'+n+'">'+t.label+"</option>"});return this.$el.find("select").append(e)};o.prototype.onUseChange=function(e){this.selectedIndex=parseInt(e.target.value,10);this.selectedItem=this.selectedIndex!==-1?this.options[this.selectedIndex]:null;this.$el.find("p").detach();this.$el.nextAll().not("#input-cta").detach();if(this.selectedItem!=null){this.$el.appendPolyfill(this.selectedItem.$el);if(this.selectedIndex===0||this.selectedIndex===2){this.$el.off("change","#broadcast-type").on("change","#broadcast-type",this.onBroadcastChange);return this.selectedItem.$el.find("#broadcast-type").trigger("change")}}};o.prototype.onBroadcastChange=function(e){var t;this.$el.nextAll().not("#input-cta").detach();t=this.selectedItem.getSelectedItem();if(t!=null)return this.$el.afterPolyfill(t.$el)};return o}();return o})}).call(this);