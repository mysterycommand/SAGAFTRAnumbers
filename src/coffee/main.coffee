###
    Author: Matt Hayes
###

# require.config(
#     paths: {
#         'jquery': 'libs/jquery-1.7.1'
#         'underscore': 'libs/underscore-1.3.2'
    
#         # jQuery plugins.
        
#         # FIND ME LATER
#         'webshim': 'plugins/webshim-1.8.9/polyfiller'
#         'chosen': 'plugins/chosen/chosen.jquery'
#         # 'chosen': 'plugins/chosen.jquery-0.9.8'
        
#         # Require JS plugins.
#         'order': 'plugins/order-1.0.5'
#     }
# )

require [
    'jquery'
    'app'
    'webshim'
    'chosen'
], (jQuery, App) ->
    
    # On scripts loaded.
    # log jQuery
    $ = jQuery

    # FIND ME LATER
    $.webshims.debug = false
    $.webshims.setOptions
      basePath: 'js/plugins/webshim/shims/'
      waitReady: false
    $.webshims.polyfill 'forms forms-ext'
    
    # On DOM loaded.
    $ ->
        $window = $ window
        $document = $ document
        
        $app = $ '#app'
        app = new App($app[0])
        
        # updateCount = 0
        # updateCountToCTA = 10

        $('.touch .chzn-select').each (i, el) ->
            $opt = $(@).find('option').first()
            isEmpty = $opt.text() is ''
            if isEmpty then $opt.text($(@).data('placeholder'))
            return

        $('.no-touch .chzn-select').chosen
            allow_single_deselect: true
            disable_search_threshold: 20
        
        onClickStartOver = (event) ->
            event.preventDefault()
            app.restart()
            return
    
        onClickStart = (event) ->
            event.preventDefault()
            return unless $('.page.home').size() is 1

            $('.hud .start, .calculator .both').fadeOut 400
            $('.hud .estimate, .hud h5, nav li').fadeIn 400

            if $document.width() < 480 then $('nav').animate { height: '53px', marginTop: '-53px'}, 400
            # $('.calculator .left, .calculator .right').fadeIn 400
            $('footer .colophon').animate { height: 'toggle', opacity: 1 }, 400, () ->
                return null if ( ! $('.page').hasClass('home')) # This is silly, not sure how best to get this event to only trigger once though.
                $('.page').removeClass('home')
                app.start()
        
            return
    
        onClickLogo = (event) ->
            event.preventDefault()
            return unless $('.page.home').size() is 0
        
            $('.page').addClass 'home'
            $('.hud .start, #splash').fadeIn 400
            $('.hud .estimate, .hud h5, nav li').fadeOut 400
            
            if $document.width() < 480 then $('nav').animate { height: '24px', marginTop: '-65px'}, 400
            # $('.calculator .left, .calculator .right').fadeOut 400
            $('footer .colophon').animate { height: 'toggle', opacity: 0 }, 400
        
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
            # fix = ($this.offsetParent().width() * 0.625) / 2
            left = ($this.position().left + $this.width() - 46) | 0 # $this.offsetParent().position().left

            if $targ.find(@hash).length # you clicked the same term a second time
                newTop = $targ.position().top isnt top
                newLeft = $targ.find('.pointer').position().left isnt left
                
                if newTop or newLeft
                    $targ.css('top', top).find('.pointer').css('left', left).end().fadeIn 400
                    return
                
                if $targ.is(':visible') then $targ.fadeOut 400 else $targ.fadeIn 400
                return
            
            $targ
                .css('top', top)
                .find('.pointer')
                    .css('left', left)
                .end()
                .find('.content')
                    .empty()
                    .append($term.clone())
                .end()

            if ! $targ.is(':visible') then $targ.fadeIn 400
            
            return

        updateShareURL = () ->
            $targ = $('#share')
            url = $targ.attr 'href'
            url = url.substr(0, url.indexOf('body=') + 5)
            
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
                    # log amount, isHeader
                    
                    url += line + '------------------------------' if isSubtotal
                    url += label
                    url += tab + amount unless isHeader and ! isSubtotal and ! isLast
                    url += line
                    url += '------------------------------' + line if isSubtotal
            
            # mailto = window.open url, 'mailto'
            # if mailto and mailto.open and ! mailto.closed then mailto.close()
            $targ.attr 'href', url
            return

        onUpdate = (event) ->
            updateShareURL()

            # log 'main.onUpdate', event.type, event.target.id

            # $('div.tooltip').filter(":visible").fadeOut 400
            # # if $('#output').height() > $('#input').height() then $('#input').height($('#output').height())
            # height = Math.max $('#input').css('height', 'auto').height(), $('#output').css('height', 'auto').height()

            # $('#input').height height
            # $('#output').height height

            # if $('#job-type').val() is '-1'
            #     updateCount = 0
            #     $('#output-cta').fadeOut 400
            #     $('#input-cta').fadeOut 400
            #     return;

            # if updateCount < updateCountToCTA
            #     updateCount++
            #     if updateCount == updateCountToCTA
            #         $('#output-cta').fadeIn 400
            #         $('#input-cta').fadeIn 400
            
            return
        
        $document
            .on('click', '.definitions.open, .definitions.close', onClickDefinitions)
            .on('click', '.term.open, .term.close', onClickTerm)
            .on('click', '.start-over a', onClickStartOver)
            .on('click', '.start a', onClickStart)
            # .on('click', '.share a', onClickShare)
            .on('click', 'h1 a', onClickLogo)
        
        app.$el.on 'update', onUpdate

        # onResize = (event) ->
        #   $debug = $ '#debug'
        #   $debug = $ '<div id="debug" style="position: absolute; top: 0; left: 0;"/>' unless $debug.size()
        #   $('body').append $debug.text($window.width() + ' x ' + $window.height())
        #   # # 
        #   # $('.chzn-select').trigger 'liszt:updated'
        #   return

        # $window.on 'resize', onResize
        # onResize()
        
        # TODO: Remove for production.
        # $compare = $ '#compare'
        #   
        # if location.hash is '#compare'
        #   $compare.show()
        #   onResize()
        
        # $document
        #     .find('.start a').click().end()
        #     # .find('.definitions a').click().end()

        #     # # Co/Ed Audio Only
        #     # .find('#job-type').val(10).trigger('liszt:updated').trigger('change').end()
        #     # .find('#storecasting').prop('checked', true).trigger('change').end()

        #     # .find('#use-type').val(0).trigger('liszt:updated').trigger('change').end()
        #     # .find('#broadcast-type').val(0).trigger('liszt:updated').trigger('change').end()
        #     # .find('a[href=#actor-announcer]').click().end()
            
        #     # # Radio Commercial
        #     # .find('#job-type').val(0).trigger('liszt:updated').trigger('change').end()
        #     # .find('#num-actors').val(3).trigger('change').end()
        #     # .find('#actor-1-num-characters').val(2).trigger('change').end()
        #     # .find('#actor-2-num-characters').val(3).trigger('change').end()
        #     # .find('#num-singers').val(1).trigger('change').end()
        #     # .find('#num-versions').val(2).trigger('change').end()
        #     # .find('#num-tags').val(12).trigger('change').end()
        #     # .find('#use-type').val(0).trigger('liszt:updated').trigger('change').end()
        #     # .find('#broadcast-type').val(0).trigger('liszt:updated').trigger('change').end()
            
        #     # # Television Commercial
        #     .find('#job-type').val(3).trigger('liszt:updated').trigger('change').end()
        #     .find('#use-type').val(0).trigger('liszt:updated').trigger('change').end()
        #     .find('#broadcast-type').val(0).trigger('liszt:updated').trigger('change').end()
            
        #     # .find('#markets').val([0, 4, 6, 13, 21, 22, 30]).trigger('liszt:updated').trigger('change').end()
        #     # .find('#markets_chzn').trigger('mousedown').end()
        
        return
    
    return


