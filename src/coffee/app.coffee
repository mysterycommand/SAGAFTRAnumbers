root = this
log = root.log
define = root.define

define [
  'jquery'
  'input/input'
  'output/output'
], ($, Input, Output) ->
	class App
    constructor: (@el) ->
      @updateCount = 0
      @updateCountToCTA = 5

      @$el = $ @el
      @input = new Input @$el.find('#input')[0]
      @output = new Output @$el.find('#output')[0]
      
      @input.$el.on 'input change', @output.onChange
      @$el.on 'input change', @onChange
      
    start: ->
      # @input.test()
    
    onChange: (event, isReset=false) =>
      # log event.type, isReset
      # log 'App.onChange', event.type, event.target.id
      @$el.trigger 'update'

      $('div.tooltip').filter(":visible").fadeOut 400
      # if $('#output').height() > $('#input').height() then $('#input').height($('#output').height())
      @calcHeight();

      # As of v0.9, all job-types reset their fields when being navigated to, we don't want to show the CTA based on this "input"
      if isReset
        @updateCount = 0
        return

      if event.target.id is 'job-type'
          @updateCount = 0
          $('#output-cta').fadeOut 400
          $('#input-cta').fadeOut 400
          return;

      if @updateCount < @updateCountToCTA
          @updateCount++
          if @updateCount == @updateCountToCTA
              $('#output-cta').fadeIn 400
              $('#input-cta').fadeIn 400
              @calcHeight();

      return

    calcHeight: ->
      height = Math.max @input.$el.css('height', 'auto').height(), @output.$el.css('height', 'auto').height()

      @input.$el.height height
      @output.$el.height height
      return
      
    restart: ->
      @input.clear()
      @output.clear()
  
  App