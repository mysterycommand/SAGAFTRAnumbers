define [
	'jquery'
	'underscore'

	'input/corp-edu/category'
	'input/corp-edu/principal-actor'
], ($, _, Category, PrincipalActor) ->
	class CorpEduOffCamera
		constructor: ->
			@label = "Corporate/Educational & Non-Broadcast - (Voiceover/Off Camera)"
			@value = "corp_edu_off_camera"
			@definitionId = "co-ed-contract"
			@headsUpItems = [
				'Retakes'
				'Multiple characters'
				'Supplemental use'
			]
			@steps = [
				new Category()
				new PrincipalActor()
			]
			@el = []
			_.each @steps, (el, i) => @el.push el.el
			@$el = $ @el

		destroy: ->
			@$el.off("**") # TODO: Make sure this works.

	CorpEduOffCamera
