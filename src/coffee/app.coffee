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
      @$el = $ @el
      @input = new Input @$el.find('#input')[0]
      @output = new Output @$el.find('#output')[0]
      
      @input.$el.on 'input change', @output.onChange
      @$el.on 'input change', @onChange
      
    start: ->
      # @input.test()
    
    onChange: (event) =>
      # log 'App.onChange', event.type, event.target.id
      @$el.trigger 'update'
      return
      
    restart: ->
      @input.clear()
      @output.clear()
  
  App