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
				<fieldset>
					I'm hiring for a
					<select name="job-type" id="job-type" class="chzn-select" data-placeholder="please choose your job">
						<option value="-1" data-value="none"></option>
					</select>.
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
				@$el.append """<a href="##{@selectedItem.value.replace "_", "-"}" class="term open">What is #{@selectedItem.label}?</a>"""
				# @$el.after @selectedItem.$el
				
				# This only applies to 'input/television/principal-actor-general-extra', but it needs to be called after that object is added to the DOM.
				@selectedItem.$el.find('#num-days').trigger 'input'
			else
				@$el.siblings().find('input')
					.filter('[type=number]').each (i, el) -> $(el).val($(el).attr('min') || 0).trigger 'change'
				@$el.siblings().find('select').not('#job-type')
					.val(-1).trigger('liszt:updated').trigger('change')
					.filter('[multiple]').val([]).trigger('liszt:updated').trigger('change')
				
				@$el.siblings().detach() # TODO: Make sure that detach is better than remove, and that we're not having a bunch of event handler references floating around.
				@$el.find('a.term.open').remove()
	
	JobType





























