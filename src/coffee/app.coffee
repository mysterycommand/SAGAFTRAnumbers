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
      
      @input.$el.on 'change', @output.onChange
      
    start: ->
      # @input.test()
  
  App