// Generated by CoffeeScript 1.4.0
(function(){var e,t,n,r=function(e,t){return function(){return e.apply(t,arguments)}};n=this;t=n.log;e=n.define;e(["jquery","underscore","input/corp-edu/principal-actor-hour"],function(e,t,n){var i;i=function(){function t(){this.onInputPrincipals=r(this.onInputPrincipals,this);this.html='<fieldset>\n	I\'ll need:\n	<div>\n		<input type="number" name="num-principals" id="num-principals" value="0" min="0" max="10">\n		<a href="#principal-actor" class="term open">principal actor</a>(s),\n	</div>\n</fieldset>';this.$el=e(this.html);this.el=this.$el[0];this.principals=[];this.$el.on("input change","#num-principals",this.onInputPrincipals)}t.prototype.onInputPrincipals=function(t){var r,i;r=parseInt(t.target.value,10);if(r===this.principals.length)return;if(this.principals.length<r)while(this.principals.length<r){i=new n(this.principals.length+1);this.principals.push(i);e(t.target).closest("div").appendPolyfill(i.$el)}else while(this.principals.length>r)this.principals.pop().$el.remove();if(t.type==="input")return this.$el.trigger("change")};return t}();return i})}).call(this);