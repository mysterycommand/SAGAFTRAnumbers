root = this
log = root.log
define = root.define

define [
	'jquery'
	'underscore'

	'input/corp-edu/category'
	'input/corp-edu/principal-actor'
], ($, _, Category, PrincipalActor) ->
	class CorpEduOffCamera
		constructor: ->
			@label = "Corporate/Educational & Non-Broadcast - (Off Camera)"
			@value = "corp_edu_off_camera"
			@definitionId = "co-ed-contract"
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