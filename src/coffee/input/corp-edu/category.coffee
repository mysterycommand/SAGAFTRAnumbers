root = this
log = root.log
define = root.define

define [
	'jquery'
	'underscore'
], ($, _) ->
	class Category
		constructor: ->
			@html = """
				<fieldset>
					It's a
					<select name="category" id="category" class="chzn-select" data-placeholder="please choose...">
						<!-- USER MUST CHOOSE A CATEGORY! -->
						<!-- <option value="-1"></option> -->
					</select>
					program.
				</fieldset>
			"""
			@$el = $ @html
			@el = @$el[0]
			
			@setupOptions()
			@$el.on 'change', '#category', @onChange
		
		setupOptions: ->
			@selectedIndex = -1
			@selectedItem = null
			@options = [
				'Category I'
				'Category II'
			]
			html = ''
			_.each @options, (el, i) -> html += """<option value="#{i + 1}">#{el}</option>"""
			@$el.find('select').append(html);
		
		getSelectedItem: -> @selectedItem
		
		onChange: (event) =>
			@selectedIndex = parseInt(event.target.value, 10)
			@selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null
	
	Category