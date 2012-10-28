root = this
log = root.log
define = root.define

define [
	'jquery'
], ($) ->
	class PrincipalActorHour
		constructor: (@index) ->
			@html = """
				<p>
					I'll need principal actor #{@index} for
					<input type="number" name="principal-#{@index}-num-hours" id="principal-#{@index}-num-hours" class="num-hours" value="1" min="1" max="8" step="0.5">
					hours(s).
				</p>

			"""
			@$el = $ @html
			@el = @$el[0]
	
	PrincipalActorHour