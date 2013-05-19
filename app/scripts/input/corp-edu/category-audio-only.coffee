define [
	'jquery'
	'underscore'

	'input/corp-edu/use-storecasting'
], ($, _, UseStorecasting) ->
	class Category
		constructor: ->
			@html = """
				<fieldset>
					<span style="vertical-align: top;">This Audio Only program is a (please choose one):</span>
					<div>
						<input type="radio" name="category" id="category-i" value="0" checked /> <label for="category-i"><a href="#category-i-definition" class="term open">Category I</a></label><br/>

						<input type="radio" name="category" id="category-ii" value="1" /> <label for="category-ii"><a href="#category-ii-definition" class="term open">Category II</a></label><br/>

						<input type="radio" name="category" id="ivr-category" value="2" />
						<label for="ivr-category" style="display: inline-block; vertical-align: top;">
							<a href="#interactive-voice-recording-ivr-phone-prompt-systems" class="term open">
								Interactive Voice Recording (IVR), <br/>
								Phone Prompt System, or <br/>
								Phonecasting
							</a>
						</label><br/>

						<input type="radio" name="category" id="storecasting" value="3" /> <label for="storecasting"><a href="#storecasting-definition" class="term open">Storecasting</a></label>
					</div>
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
				new UseStorecasting()
			]
		# 	html = ''
		# 	_.each @options, (el, i) -> html += """<option value="#{i}">#{el}</option>"""
		# 	@$el.find('select').append(html);

		getSelectedItem: -> @selectedItem

		onChange: (event) =>
			@selectedIndex = parseInt event.target.value, 10

			if @selectedIndex isnt parseInt @$el.find('#storecasting').val(), 10
				@selectedItem.$el.detach() if @selectedItem?
				@selectedItem = null
				return

			@selectedItem = @options[0]
			# # @selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null
			# if @selectedIndex isnt -1
			# 	if @selectedIndex is 0 or @selectedIndex is 1 or @selectedIndex is 3
			# 		@selectedItem = @options[0]
			# 	else
			# 		@selectedItem = @options[1]
			# else
			# 	@selectedItem =  null

			# @$el.nextAll().not('#input-cta').detach()

			if @selectedItem?
				# FIND ME LATER
				# @$el.siblings('fieldset').last().after @selectedItem.$el
				@$el.siblings('fieldset').last().afterPolyfill @selectedItem.$el

	Category









