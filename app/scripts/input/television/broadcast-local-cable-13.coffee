define [
	'jquery'
	'underscore'
], ($, _) ->
	class LocalCable13
		constructor: ->
			@label = "Local Cable - 13 week cycle"
			@html = """
				<fieldset>
					It will be broadcast on a local station with
					<select name="subscribers" id="subscribers" class="chzn-select" data-placeholder="please choose...">
						<option value="-1"></option>
					</select>
					subscribers.
				</fieldset>
			"""
			@$el = $ @html
			@el = @$el[0]

			@setupOptions()
			@$el.on('change', '#subscribers', @onChange)

		setupOptions: ->
			@selectedIndex = -1
			@selectedItem = null
			@options = [
				'1 - 50,000'
				'50,001 - 100,000'
				'100,001 - 150,000'
				'150,001 - 200,000'
				'200,001 - 250,000'
				'250,001 - 500,000'
				'500,001 - 750,000'
				'750,001 - 1,000,000'
			]
			html = ''
			_.each @options, (el, i) -> html += """<option value="#{i}">#{el}</option>"""
			@$el.find('select').append(html);

		getSelectedItem: -> @selectedItem

		onChange: (event) =>
			@selectedIndex = parseInt(event.target.value, 10)
			@selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null


	LocalCable13
