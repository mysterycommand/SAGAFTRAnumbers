root = this
log = root.log
define = root.define

define [
	'jquery'
	'underscore'
], ($, _) ->
	class ExtraDay
		constructor: (@index) ->
			@html = """
				<p>
					Extra #{@index} is a
					<select name="extra-#{@index}-type" id="extra-#{@index}-type" class="chzn-select" data-placeholder="please choose...">
						<!-- EXTRA MUST HAVE A TYPE! -->
						<!-- <option value="-1"></option> -->
					</select>-type
					extra, and I'll need them for
					<input type="number" name="extra-#{@index}-num-days" id="extra-#{@index}-num-days" class="num-days" value="1" min="1" max="10">
					day(s).
				</p>

			"""
			@$el = $ @html
			@el = @$el[0]
			
			@setupOptions()
			@$el.on 'change', '#extra-type', @onChange
		
		setupOptions: ->
			@selectedIndex = -1
			@selectedItem = null
			@options = [
				'general'
				'special ability'
				'silent bit'
			]
			html = ''
			_.each @options, (el, i) -> html += """<option value="#{i}">#{el}</option>"""
			@$el.find('select').append(html);
		
		getSelectedItem: -> @selectedItem
		
		onChange: (event) =>
			@selectedIndex = parseInt(event.target.value, 10)
			@selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null
	
	ExtraDay
