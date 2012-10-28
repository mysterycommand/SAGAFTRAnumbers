root = this
log = root.log
define = root.define

define [
	'jquery'
], ($) ->
	class CorpEdu
		@onCameraSessionLineItems: (rates) ->
			category = parseInt $('input:radio[name=category]:checked').val(), 10 # Should be 0, or 1.
			categoryLabel = if (category == 0) then 'Category I' else 'Category II'
			categoryPrefix = if (category == 0) then 'cat_1_' else 'cat_2_'
			
			numNarrators = parseInt $('#num-narrators').val(), 10
			numPlayers = parseInt $('#num-players').val(), 10
			numExtras = parseInt $('#num-extras').val(), 10
			numDays = 0

			lineItems = []

			i = 0
			while i++ < numNarrators
				numDays = parseInt $("#narrator-#{i}-num-days").val(), 10

				lineItem = 
					label: "#{categoryLabel} Narrator #{i} - #{numDays} Days Total"
					first:
						label: "First Day"
						price: rates[categoryPrefix + 'session_narrator_day_1']
					items: []

				if numDays - 1
					lineItem.items.push
						count: numDays - 1
						label: "Add'l Days at $ #{rates[categoryPrefix + 'session_narrator_day_2'].toFixed(2)}"
						price: rates[categoryPrefix + 'session_narrator_day_2']

				lineItems.push lineItem

			i = 0
			while i++ < numPlayers
				numDays = parseFloat $("#player-#{i}-num-days").val(), 10

				numFullDays = Math.floor(numDays)
				numHalfDays = Math.ceil(numDays - numFullDays)
				numFiveDays = Math.floor(numFullDays / 5)
				numThreeDays = Math.floor((numFullDays - (numFiveDays * 5)) / 3)
				numSingleDays = numFullDays - ((numFiveDays * 5) + (numThreeDays * 3))

				lineItem = 
					label: "#{categoryLabel} Day Player #{i} - #{numDays} Days Total"
					items: []

				if numFiveDays then lineItem.items.push
					count: numFiveDays
					label: "Week Session(s) at $ #{rates[categoryPrefix + 'session_player_week'].toFixed(2)}"
					price: rates[categoryPrefix + 'session_player_week']

				if numThreeDays then lineItem.items.push
					count: numThreeDays
					label: "3-Day Session(s) at $ #{rates[categoryPrefix + 'session_player_day_3'].toFixed(2)}"
					price: rates[categoryPrefix + 'session_player_day_3']

				if numSingleDays then lineItem.items.push
					count: numSingleDays
					label: "Single Day Session(s) at $ #{rates[categoryPrefix + 'session_player_day_1'].toFixed(2)}"
					price: rates[categoryPrefix + 'session_player_day_1']

				if numHalfDays then lineItem.items.push
					count: numHalfDays
					label: "Half Day Session(s) at $ #{rates[categoryPrefix + 'session_player_half_day'].toFixed(2)}"
					price: rates[categoryPrefix + 'session_player_half_day']

				lineItems.push lineItem

			i = 0
			while i++ < numExtras
				numDays = parseInt $("#extra-#{i}-num-days").val(), 10

				extraTypeIndex = parseInt($("#extra-#{i}-type").val(), 10) || 0
				
				extraLabel = [
					'General Extra'
					'Special Ability Extra'
					'Silent Bit Extra'
				][extraTypeIndex]

				extraSuffix = [
					'_general'
					'_special'
					'_silent'
				][extraTypeIndex]

				lineItem = 
					label: "#{categoryLabel} Extra #{i} - #{numDays} Days Total"
					first:
						label: "#{extraLabel} at #{rates[categoryPrefix + 'session_extra' + extraSuffix].toFixed(2)}"
						price: rates[categoryPrefix + 'session_extra' + extraSuffix] * numDays
					items: []

				# lineItem.items.push
				# 	count: numDays
				# 	label: "#{extraLabel} at #{rates[categoryPrefix + 'session_extra' + extraSuffix].toFixed(2)}"
				# 	price: rates[categoryPrefix + 'session_extra' + extraSuffix]

				lineItems.push lineItem

			# lineItem = 
			# 	label: ""
			# 	first:
			# 		label: ""
			# 		price: 0
			# 	items: []

			# lineItem.items.push
			# 	count: 0
			# 	label: ""
			# 	price: 0

			lineItems

		@offCameraSessionLineItems: (rates) ->
			lineItems = []
			
			lineItem = 
				label: ""
				first:
					label: ""
					price: 0
				items: []

			lineItem.items.push
				count: 0
				label: ""
				price: 0

			lineItems.push lineItem
			lineItems

		@audioOnlySessionLineItems: (rates) ->
			lineItems = []
			
			lineItem = 
				label: ""
				first:
					label: ""
					price: 0
				items: []

			lineItem.items.push
				count: 0
				label: ""
				price: 0

			lineItems.push lineItem
			lineItems

	CorpEdu