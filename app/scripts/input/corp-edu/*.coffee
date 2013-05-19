define [
	'jquery'
	'underscore'

	'input/corp-edu/corp-edu-on-camera'
	'input/corp-edu/corp-edu-off-camera'
	'input/corp-edu/corp-edu-audio-only'
], ($, _, CorpEduOnCamera, CorpEduOffCamera, CorpEduAudioOnly) ->
	exports =
		'OnCamera': CorpEduOnCamera
		'OffCamera': CorpEduOffCamera
		'AudioOnly': CorpEduAudioOnly

	exports
