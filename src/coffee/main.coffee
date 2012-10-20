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
    'webshim': 'plugins/webshim-1.8.9/polyfiller'
    'chosen': 'plugins/chosen.jquery-0.9.8'
    
    # Require JS plugins.
    'order': 'plugins/order-1.0.5'
  }
)

require [
  'order!jquery'
  'order!app'
  
  # jQuery plugins.
  'order!webshim'
  'order!chosen'
], (jQuery, App) ->
  
  # On scripts loaded.
  # log jQuery
  $ = jQuery
  $.webshims.polyfill()
  
  # On DOM loaded.
  $ ->
    $window = $ window
    $document = $ document
    
    $app = $ '#app'
    app = new App($app[0])
  
    $('.chzn-select').not('.chzn-done').chosen(
      allow_single_deselect: true
      disable_search_threshold: 20
    )
    
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
    
    onChangeApp = (event) ->
      $('.tooltip').fadeOut 400
      return
    
    $document
      .on('click', '.definitions.open, .definitions.close', onClickDefinitions)
      .on('click', '.term.open, .term.close', onClickTerm)
      .on('click', '.start-over a', onClickStartOver)
      .on('click', '.start a', onClickStart)
      .on('click', 'h1 a', onClickLogo)
    
    app.$el.on 'change', onChangeApp
    
    # TODO: Remove for production.
    # $compare = $ '#compare'
    #   
    # if location.hash is '#compare'
    #   $compare.show()
    #   onResize()
    
    # $document
    #   .find('.start a').click().end()
    #   # .find('.definitions a').click().end()
    #   .find('#job-type').val(2).trigger('liszt:updated').trigger('change').end()
    #   # .find('a[href=#actor-announcer]').click().end()
    
    return
  
  return





























