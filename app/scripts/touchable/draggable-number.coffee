root = this

define [
  'jquery'
  'touchable/touchable'
], ($, Touchable) ->
  root.isNumberDragging = false

  class DraggableNumber
    constructor: (@element, @options) ->
      @$ele = $(@element).addClass 'draggable-number'

      @initializeHover()
      @initializeHelp()
      @initializeDrag()

      return

    initializeHover: ->
      @isHovering = false

      @$ele.on
        'mouseenter': @onMouseEnter
        'mouseleave': @onMouseLeave

      return

    initializeHelp: ->
      isInput = @$ele.is 'input'

      @$help = $ """<div class="number-help">#{if isInput then 'click or ' else ''}drag</div>"""

      if isInput
        @$ele.wrap """<span style="display: inline-block; position: relative;" />"""
        @$help.insertAfter(@$ele).hide()
      else
        @$help.prependTo(@$ele).hide()

      return

    initializeDrag: ->
      @isDragging = false

      @touchable = new Touchable @element

      @$ele.on
        'touchabledown': @onTouchableDown
        'touchablemove': @onTouchableMove
        'touchableup': @onTouchableUp

      return

    onMouseEnter: (event) =>
      @isHovering = true
      @updateRollOver()
      return

    onMouseLeave: (event) =>
      @isHovering = false
      @updateRollOver()
      return

    onTouchableDown: (event, touches) =>
      @min = @$ele.attr('min') ? @options?.min ? 0
      @max = @$ele.attr('max') ? @options?.max ? 1e100
      @step = @$ele.attr('step') ? @options?.step ? 1

      @valStart = parseInt @$ele.val(), 10 or 0
      @isDragging = root.isNumberDragging = true
      @updateRollOver()
      return

    onTouchableMove: (event, touches) =>
      value = parseInt(@valStart, 10) + touches.translation.x / 5 * @step
      value = Math.min(Math.max(@min, Math.round(value / @step) * @step), @max)
      @$ele.val(value).trigger 'change'
      @updateHelp()
      return

    onTouchableUp: (event, touches) =>
      @isDragging = root.isNumberDragging = false
      @updateRollOver()

      @$help.css 'display', if touches.wasTap then 'block' else 'none'
      @$ele.select() if touches.delta?.x is 0 and @valStart is parseInt @$ele.val(), 10
      return

    updateRollOver: ->
      @updateStyle()
      @updateCursor()
      @updateHelp()
      return

    isActive: -> not @isDragging and not root.isNumberDragging and @isHovering

    updateStyle: ->
      @$ele.toggleClass 'number-down', @isDragging
      @$ele.toggleClass 'number-hover', @isActive()
      return

    updateCursor: ->
      $('body').toggleClass 'number-drag-cursor-h', @isActive()
      return

    updateHelp: ->
      l = Math.round((@$ele.outerWidth() - @$help.width()) / 2)
      pt = @$ele.css 'paddingTop'
      bt = @$ele.css 'borderTopWidth'
      t = -@$help.height() - (parseInt(pt, 10) + parseInt(bt, 10))
      d = if @isHovering and not root.isNumberDragging then 'block' else 'none'
      @$help.css
        display: d
        left: l
        top: t
      return

  DraggableNumber





























