root = this
log = root.log
define = root.define

define [
	'jquery'
	'underscore'

	'input/corp-edu/category-audio-only'
	'input/corp-edu/principal-actor-audio-only'
], ($, _, CategoryAudioOnly, PrincipalActorAudioOnly) ->
	class CorpEduAudioOnly
		constructor: ->
			@label = "Corporate/Educational & Non-Broadcast - (Audio Only)"
			@value = "corp_edu_audio_only"
			@definitionId = "co-ed-contract"
			@steps = [
				new CategoryAudioOnly()
				new PrincipalActorAudioOnly()
			]
			@el = []
			_.each @steps, (el, i) => @el.push el.el
			@$el = $ @el
		
		destroy: ->
			@$el.off("**") # TODO: Make sure this works.
	
	CorpEduAudioOnly