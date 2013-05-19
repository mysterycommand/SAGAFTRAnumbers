define [
	'jquery'
	'underscore'
], ($, _) ->
	class Category
		constructor: ->
			@html = """
				<fieldset>
					<span style="vertical-align: top;">It's a</span>
					<span style="display: inline-block;">
						<input type="radio" name="category" id="category-i" value="0" checked /> <label for="category-i"><a href="#category-i-definition" class="term open">Category I</a></label><br/>
						<input type="radio" name="category" id="category-ii" value="1" /> <label for="category-ii"><a href="#category-ii-definition" class="term open">Category II</a></label>
					</span>
					program.
				</fieldset>
			"""
			@$el = $ @html
			@el = @$el[0]

			@setupOptions()
			@$el.on 'change', 'input', @onChange

		setupOptions: ->
			@selectedIndex = -1
			@selectedItem = null
			@options = [
				'Category I'
				'Category II'
			]
		# 	html = ''
		# 	_.each @options, (el, i) -> html += """<option value="#{i}">#{el}</option>"""
		# 	@$el.find('select').append(html);

		getSelectedItem: -> @selectedItem

		onChange: (event) =>
			@selectedIndex = parseInt(event.target.value, 10)
			@selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null
			# log @selectedIndex, @selectedItem

	Category
