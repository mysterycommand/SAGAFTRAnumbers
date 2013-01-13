###
	Author: Matt Hayes
###

root = this
log = root.log
require = root.require

require.config(
	paths: {
		'jquery': 'libs/jquery-1.7.1'
		'underscore': 'libs/underscore-1.3.2'
	
		# jQuery plugins.
		
		# FIND ME LATER
		'webshim': 'plugins/webshim-1.8.9/polyfiller'
		'chosen': 'plugins/chosen/chosen.jquery'
		# 'chosen': 'plugins/chosen.jquery-0.9.8'
		
		# Require JS plugins.
		'order': 'plugins/order-1.0.5'
	}
)

require [
	'order!jquery'
	'order!app'
	
	# jQuery plugins.

	# FIND ME LATER
	'order!webshim'
	
	'order!chosen'
], (jQuery, App) ->
	
	# On scripts loaded.
	# log jQuery
	$ = jQuery

	# FIND ME LATER
	$.webshims.polyfill()
	
	# On DOM loaded.
	$ ->
		$window = $ window
		$document = $ document
		
		$app = $ '#app'
		app = new App($app[0])
	
		$('.chzn-select').not('.chzn-done').chosen
			allow_single_deselect: true
			disable_search_threshold: 20
		
		onClickStartOver = (event) ->
			event.preventDefault()
			app.restart()
			return
	
		onClickStart = (event) ->
			event.preventDefault()
		
			$('.hud .start, .calculator .both').fadeOut 400
			$('.hud .estimate, .hud h5, nav li').fadeIn 400
			# $('.calculator .left, .calculator .right').fadeIn 400
			$('footer h3, footer h4, footer address').show 400, () ->
				return null if ( ! $('.page').hasClass('home')) # This is silly, not sure how best to get this event to only trigger once though.
				$('.page').removeClass('home')
				app.start()
		
			return
		
		onClickShare = (event) ->
			event.preventDefault()
			url = $(event.target).attr 'href'
			
			$('#output tr')
				.each (i, el) ->
					$el = $ el
					
					line = '%0A'
					tab = '%09'
					
					isHeader = $el.find('th').size() > 0
					isFirst = $el.parent().is 'thead'
					isSubtotal = $el.parent().is('.session-fees-subtotal') or $el.parent().is('.usage-fees-subtotal')
					isTotal = $el.is('#subtotal') or $el.is('#total')
					isLast = $el.parent().is 'tfoot'
					
					label = 
						if isHeader 
							if isFirst
								encodeURIComponent($el.find('th').text().toUpperCase())
							else if isSubtotal
								line + encodeURIComponent($el.find('.label').text())
							else if isLast
								line + encodeURIComponent('*' + $el.find('.label').text() + '*')
							else
								line + encodeURIComponent('*' + $el.find('th').text() + '*')
						else
							tab + encodeURIComponent($el.find('.label').text())
					amount = encodeURIComponent $el.find('.amount').text()
					log amount, isHeader
					
					url += line + '------------------------------' if isSubtotal
					url += label
					url += tab + amount unless isHeader and ! isSubtotal and ! isLast
					url += line
					url += '------------------------------' + line if isSubtotal
			
			mailto = window.open url, 'mailto'
			if mailto and mailto.open and ! mailto.closed then mailto.close()
			
			return
	
		onClickLogo = (event) ->
			event.preventDefault()
		
			$('.page').addClass 'home'
			$('.hud .start, #splash').fadeIn 400
			$('.hud .estimate, .hud h5, nav li').fadeOut 400
			# $('.calculator .left, .calculator .right').fadeOut 400
			$('footer h3, footer h4, footer address').hide 400
		
			return
			
		onClickDefinitions = (event) ->
			event.preventDefault()
			
			$targ = $ @hash

			if $targ.is(':visible')
				$(@hash + '-overlay').fadeOut 400
				$targ.fadeOut 400
			else
				$(@hash + '-overlay').fadeIn 400
				$targ.fadeIn 400
			
			$('#tooltip-left').fadeOut 400
			$('#tooltip-right').fadeOut 400
			
			return
		
		onClickTerm = (event) ->
			event.preventDefault()
			
			$this = $ this
			$term = $ @hash
			
			side = '#tooltip-' + if $this.closest('.inner').hasClass('left') then 'left' else 'right'
			
			$targ = $ side
			
			if @hash is side # you clicked the close button
				$targ.fadeOut 400
				return
			
			top = ($this.position().top + $this.height() + 14) | 0
			left = ($this.position().left + ($this.width() / 2) - 46) | 0 # $this.offsetParent().position().left
			
			if $targ.find(@hash).length # you clicked the same term a second time
				newTop = $targ.position().top isnt top
				newLeft = $targ.find('.pointer').position().left isnt left
				
				if newTop or newLeft
					$targ.css('top', top).find('.pointer').css('left', left).end().fadeIn 400
					return
				
				if $targ.is(':visible') then $targ.fadeOut 400 else $targ.fadeIn 400
				return
			
			$targ
				.find('.content')
					.empty()
					.append($term.clone())
				.end()
				.css('top', top)
				.find('.pointer')
					.css('left', left)
				.end()

			if ! $targ.is(':visible') then $targ.fadeIn 400
			
			return
		
		updateCount = 0
		updateCountToCTA = 10

		onUpdate = (event) ->
			# log 'main.onUpdate', event.type, event.target.id
			$('div.tooltip').filter(":visible").fadeOut 400
			# if $('#output').height() > $('#input').height() then $('#input').height($('#output').height())
			height = Math.max $('#input').css('height', 'auto').height(), $('#output').css('height', 'auto').height()
			
			$('#input').height height
			$('#output').height height

			if updateCount < updateCountToCTA
				updateCount++
				if updateCount == updateCountToCTA
					$('#output-cta').fadeIn 400

			return
		
		$document
			.on('click', '.definitions.open, .definitions.close', onClickDefinitions)
			.on('click', '.term.open, .term.close', onClickTerm)
			.on('click', '.start-over a', onClickStartOver)
			.on('click', '.start a', onClickStart)
			.on('click', '.share a', onClickShare)
			.on('click', 'h1 a', onClickLogo)
		
		app.$el.on 'update', onUpdate

		# onResize = (event) ->
		# 	$debug = $ '#debug'
		# 	$debug = $ '<div id="debug" style="position: absolute; top: 0; left: 0;"/>' unless $debug.size()
		# 	$('body').append $debug.text($window.width() + ' x ' + $window.height())

		# $window.on 'resize', onResize
		# onResize()
		
		# TODO: Remove for production.
		# $compare = $ '#compare'
		#   
		# if location.hash is '#compare'
		#   $compare.show()
		#   onResize()
		
		$document
			.find('.start a').click().end()
			# .find('.definitions a').click().end()
			.find('#job-type').val(10).trigger('liszt:updated').trigger('change').end()
			# .find('#storecasting').prop('checked', true).trigger('change').end()
			# .find('#use-type').val(0).trigger('liszt:updated').trigger('change').end()
			# .find('#broadcast-type').val(0).trigger('liszt:updated').trigger('change').end()
			# .find('a[href=#actor-announcer]').click().end()
			
			# # Radio Commercial
			# .find('#num-actors').val(3).trigger('change').end()
			# .find('#actor-1-num-characters').val(2).trigger('change').end()
			# .find('#actor-2-num-characters').val(3).trigger('change').end()
			# .find('#num-singers').val(1).trigger('change').end()
			# .find('#num-versions').val(2).trigger('change').end()
			# .find('#num-tags').val(12).trigger('change').end()
			# .find('#use-type').val(0).trigger('liszt:updated').trigger('change').end()
			# .find('#broadcast-type').val(0).trigger('liszt:updated').trigger('change').end()
			
			# .find('#markets').val([0, 4, 6, 13, 21, 22, 30]).trigger('liszt:updated').trigger('change').end()
			# .find('#markets_chzn').trigger('mousedown').end()
		
		return
	
	return

