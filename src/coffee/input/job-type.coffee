root = this
log = root.log
define = root.define

define [
	'jquery'
	'underscore'

	'input/radio/*'
	'input/television/*'
	'input/psa/*'
	'input/corp-edu/*'

	'chosen'
], ($, _, Radio, TV, PSA, CorpEdu) ->
	class JobType
		constructor: () ->
			@html = """
				<fieldset id="job-type-fieldset">
					<span style="vertical-align: top;">I'm hiring for a</span>
					<span id="job-type-span">
						<select name="job-type" id="job-type" class="chzn-select" data-placeholder="please choose your job">
							<option value="-1" data-value="none"></option>
						</select>
					</span>
				</fieldset>
			"""
			@$el = $ @html
			@el = @$el[0]
			
			@setupOptions()
			@$el.on 'change', '#job-type', @onChange
		
		setupOptions: ->
			@selectedIndex = -1
			@selectedItem = null
			@options = [
				new Radio.Commercial()
				new Radio.Demo()

				new TV.OnCamera()
				new TV.OffCamera()
				new TV.Demo()
				
				new PSA.Radio()
				new PSA.OnCamera()
				new PSA.OffCamera()

				new CorpEdu.OnCamera()
				new CorpEdu.OffCamera()
				new CorpEdu.AudioOnly()
			]
			
			html = ''
			_.each @options, (el, i) -> html += """<option value="#{i}" data-value="#{el.value}">#{el.label}</option>"""
			@$el.find('select').append(html)
		
		onChange: (event) =>
			@selectedIndex = parseInt event.target.value, 10
			@selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null
			
			if @selectedItem?
				@$el.siblings().detach() # TODO: Make sure that detach is better than remove, and that we're not having a bunch of event handler references floating around.
				@$el.find('a.term.open').remove()
				
				# FIND ME LATER
				@$el.afterPolyfill @selectedItem.$el
				@$el.find('#job-type-span').append """<a href="##{@selectedItem.definitionId}" class="term open">What is: #{@selectedItem.label}?</a>"""
				# @$el.after @selectedItem.$el
				
				# There are a couple of special cases that need to be handled after the job-type is added to the DOM.
				if 2 <= @selectedIndex <= 4 then @selectedItem.$el.find('#num-days').trigger 'input' # TV.*
				# if @selectedIndex is 10 then @selectedItem.$el.find('#storecasting').trigger 'change' # CorpEdu.AudioOnly
			else
				@$el.siblings().find('input')
					.filter('[type=number]').each (i, el) -> $(el).val($(el).attr('min') || 0).trigger 'change'
				@$el.siblings().find('select').not('#job-type')
					.val(-1).trigger('liszt:updated').trigger('change')
					.filter('[multiple]').val([]).trigger('liszt:updated').trigger('change')
				
				@$el.siblings().detach() # TODO: Make sure that detach is better than remove, and that we're not having a bunch of event handler references floating around.
				@$el.find('a.term.open').remove()
	
	JobType





























