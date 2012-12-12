root = this
log = root.log
define = root.define

define [
	'jquery'
	'underscore'
], ($, _) ->
	class UseStorecasting
		constructor: ->
			@html = """
				<fieldset>
					This storecasting will be used for
					<select name="use-type-storecasting" id="use-type-storecasting" class="chzn-select">
						<option value="0">3 months</option>
						<option value="1">6 months</option>
					</select>.
				</fieldset>
			"""
			@$el = $ @html
			@el = @$el[0]

	UseStorecasting