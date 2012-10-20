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
    'colorbox': 'plugins/jquery.colorbox-1.3.19'
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
  'order!colorbox'
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
      $('.hud .start, .calculator .both').fadeIn 400
      $('.hud .estimate, .hud h5, nav li').fadeOut 400
      # $('.calculator .left, .calculator .right').fadeOut 400
      $('footer h3, footer h4, footer address').hide 400
    
      return
    
    $document
      .find('.definitions a').colorbox({inline: true, opacity: 0.5, top: $app.offset().top, width: $app.width()}).end()
      .on('click', '.start-over a', onClickStartOver)
      .on('click', '.start a', onClickStart)
      .on('click', 'h1 a', onClickLogo)
    
    
    
    onResize = (event) ->
      # $compare.text($window.width() + " x " + $window.height())
      $.colorbox.resize {width: $app.width()}
      return
  
    $window
      .on('resize', onResize)
    
    
    
    # TODO: Remove for production.
    # $compare = $ '#compare'
    #   
    # if location.hash is '#compare'
    #   $compare.show()
    #   onResize()
    #   
    # $('.start a').click();
    
    return
  
  return





























