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
  }
)

require [
  'jquery'
  'app'
], ($, App) ->
    
  $window = $ window
  $document = $ document
  app = new App($document.find('#app')[0])
  
  # $('select').chosen(
  #   allow_single_deselect: true
  #   disable_search_threshold: 20
  # )
  
  # TODO: Remove for production
  $compare = $ '#compare'
  
  onClickStart = (event) ->
    event.preventDefault()
    
    $('.hud .start, .calculator .both').fadeOut 400
    $('.hud .estimate, .hud h5, nav li').fadeIn 400
    # $('.calculator .left, .calculator .right').fadeIn 400
    $('footer h3, footer h4, footer address').show 400, () ->
      return null if ( ! $('.page').hasClass('home')) # This is silly, not sure how best to get this event to only trigger once though.
      $('.page').removeClass('home')
      app.start();
    
    return
  
  onClickLogo = (event) ->
    event.preventDefault()
    
    $('.page').addClass 'home'
    $('.hud .start, .calculator .both').fadeIn 400
    $('.hud .estimate, .hud h5, nav li').fadeOut 400
    # $('.calculator .left, .calculator .right').fadeOut 400
    $('footer h3, footer h4, footer address').hide 400
    
    return
    
  onResize = (event) ->
    $compare.text($window.width() + " x " + $window.height())
    return
  
  $document
    .on('click', '.start a', onClickStart)
    .on('click', 'h1 a', onClickLogo)
  
  $window
    .on('resize', onResize)
  
  if location.hash is '#compare'
    $compare.show()
    onResize()
  
  # TODO: Remove for production.
  # $('.start a').click();
  
  return





























