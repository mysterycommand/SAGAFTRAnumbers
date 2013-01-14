// Generated by CoffeeScript 1.4.0
(function(){var e,t,n,r=function(e,t){return function(){return e.apply(t,arguments)}};n=this;t=n.log;e=n.define;e(["jquery","underscore","input/radio/*","input/television/*","input/psa/*","input/corp-edu/*","chosen"],function(e,t,n,i,s,o){var u;u=function(){function u(){this.onChange=r(this.onChange,this);this.html='<fieldset id="job-type-fieldset">\n    <span style="vertical-align: top;">I\'m hiring for a</span>\n    <span id="job-type-span">\n        <select name="job-type" id="job-type" class="chzn-select" data-placeholder="please choose your job">\n            <option value="-1" data-value="none"></option>\n        </select>\n    </span>\n</fieldset>';this.$el=e(this.html);this.el=this.$el[0];this.setupOptions();this.$el.on("change","#job-type",this.onChange)}u.prototype.setupOptions=function(){var e;this.selectedIndex=-1;this.selectedItem=null;this.options=[new n.Commercial,new n.Demo,new i.OnCamera,new i.OffCamera,new i.Demo,new s.Radio,new s.OnCamera,new s.OffCamera,new o.OnCamera,new o.OffCamera,new o.AudioOnly,{value:"mailto:Timothy.Ogren@sagaftra.org?subject=SAG-AFTRAnumbers%20Question",label:"Not seeing what you're looking for?  Ask Tim"}];e="";t.each(this.options,function(t,n){return e+='<option value="'+n+'" data-value="'+t.value+'" '+(t.value.indexOf("mailto")>-1?'class="mailto"':"")+">"+t.label+"</option>"});return this.$el.find("select").append(e)};u.prototype.onChange=function(t){var n,r;this.selectedIndex=parseInt(t.target.value,10);this.selectedItem=this.selectedIndex!==-1?this.options[this.selectedIndex]:null;if(this.selectedItem!=null){this.$el.siblings().detach();this.$el.find("a.term.open").remove();this.$el.afterPolyfill(this.selectedItem.$el);this.$el.find("#job-type-span").append('<a href="#'+this.selectedItem.definitionId+'" class="term open">What is: '+this.selectedItem.label+"?</a>");2<=(r=this.selectedIndex)&&r<=4&&this.selectedItem.$el.find("#num-days").trigger("input");if(this.selectedItem.value.indexOf("mailto")===-1)return;n=window.open(this.selectedItem.value,"mailto");n&&n.open&&!n.closed&&n.close();return this.$el.find("#job-type").val(-1).trigger("change").trigger("liszt:updated")}this.$el.siblings().find("input").filter("[type=number]").each(function(t,n){return e(n).val(e(n).attr("min")||0).trigger("change")});this.$el.siblings().find("select").not("#job-type").val(-1).trigger("liszt:updated").trigger("change").filter("[multiple]").val([]).trigger("liszt:updated").trigger("change");this.$el.siblings().detach();return this.$el.find("a.term.open").remove()};return u}();return u})}).call(this);