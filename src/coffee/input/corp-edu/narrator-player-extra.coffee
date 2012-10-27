root = this
log = root.log
define = root.define

define [
	'jquery'
	'underscore'

	'input/corp-edu/narrator-day'
	'input/corp-edu/player-day'
	'input/corp-edu/extra-day'
], ($, _, NarratorDay, PlayerDay, ExtraDay) ->
	class NarratorPlayerExtra
		constructor: ->
			@html = """
				<fieldset>
					I'll need:
					<div>
						<input type="number" name="num-narrators" id="num-narrators" value="0" min="0" max="2">
						<a href="#narrator-spokesperson" class="term open">narrator/spokesperson</a>(s),
					</div>
					<div>
						<input type="number" name="num-half-players" id="num-half-players" value="0" min="0" max="10">
						<a href="#day-performer" class="term open">half day player</a>(s), and
					</div>
					<div>
						<input type="number" name="num-players" id="num-players" value="0" min="0" max="10">
						<a href="#day-performer" class="term open">day player</a>(s), and
					</div>
					<div>
						<input type="number" name="num-extras" id="num-extras" value="0" min="0" max="10">
						<a href="#general-extra" class="term open">extra</a>(s).
					</div>
				</fieldset>
			"""
			@$el = $ @html
			@el = @$el[0]
			
			@narrators = []
			@$el.on 'input change', '#num-narrators', @onInputNarrators

			@players = []
			@$el.on 'input change', '#num-players', @onInputPlayers

			@extras = []
			@$el.on 'input change', '#num-extras', @onInputExtras
		
		onInputNarrators: (event) =>
			numNarrators = parseInt(event.target.value, 10)
			if numNarrators is @narrators.length then return
			
			if numNarrators > @narrators.length
				while @narrators.length < numNarrators
					narrator = new NarratorDay(@narrators.length + 1)
					@narrators.push narrator
					
					# FIND ME LATER
					# @$el.appendPolyfill narrator.$el
					# @$el.append narrator.$el
					$(event.target).closest('div').appendPolyfill narrator.$el
			else
				while @narrators.length > numNarrators
					@narrators.pop().$el.remove()
			if event.type is 'input' then @$el.trigger 'change'
		
		onInputPlayers: (event) =>
			numPlayers = parseInt(event.target.value, 10)
			if numPlayers is @players.length then return
			
			if numPlayers > @players.length
				while @players.length < numPlayers
					player = new PlayerDay(@players.length + 1)
					@players.push player
					
					# FIND ME LATER
					# @$el.appendPolyfill player.$el
					# @$el.append player.$el
					$(event.target).closest('div').appendPolyfill player.$el
			else
				while @players.length > numPlayers
					@players.pop().$el.remove()
			if event.type is 'input' then @$el.trigger 'change'
		
		onInputExtras: (event) =>
			numExtras = parseInt(event.target.value, 10)
			if numExtras is @extras.length then return
			
			if numExtras > @extras.length
				while @extras.length < numExtras
					extra = new ExtraDay(@extras.length + 1)
					@extras.push extra
					
					# FIND ME LATER
					# @$el.appendPolyfill extra.$el
					# @$el.append extra.$el
					$(event.target).closest('div').appendPolyfill extra.$el
			else
				while @extras.length > numExtras
					@extras.pop().$el.remove()
			if event.type is 'input' then @$el.trigger 'change'
	
	NarratorPlayerExtra