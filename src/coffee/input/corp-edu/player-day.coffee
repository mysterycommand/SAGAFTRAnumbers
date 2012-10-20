root = this
log = root.log
define = root.define

define [
	'jquery'
], ($) ->
	class PlayerDay
		constructor: (@index) ->
			@html = """
				<p>
					I'll need day player #{@index} for
					<input type="number" name="player-#{@index}-num-days" id="player-#{@index}-num-days" class="num-days" value="1" min="0.5" max="10" step="0.5">
					day(s).
				</p>

			"""
			@$el = $ @html
			@el = @$el[0]
	
	PlayerDay
