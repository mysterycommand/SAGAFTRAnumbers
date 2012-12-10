root = this
log = root.log
define = root.define

define [
	'jquery'
	'underscore'

	'input/corp-edu/category-audio-only'
], ($, _, CategoryAudioOnly) ->
	class CorpEduAudioOnly
		constructor: ->
			@label = "Corporate/Educational & Non-Broadcast - (Audio Only)"
			@value = "corp_edu_audio_only"
			@definitionId = "co-ed-contract"
			@steps = [
				new CategoryAudioOnly()
			]
			@el = []
			_.each @steps, (el, i) => @el.push el.el
			@$el = $ @el
		
		destroy: ->
			@$el.off("**") # TODO: Make sure this works.
	
	CorpEduAudioOnly