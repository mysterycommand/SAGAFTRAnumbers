# Based on:
# //
# //  BVTouchable.js
# //  ExplorableExplanations
# //
# //  Created by Bret Victor on 3/10/11.
# //  (c) 2011 Bret Victor.  MIT open-source license.
# //
# However, this object will dispatch events to which it's observers will respond,
# rather than have a delegate passed in, and use jQuery instead of MooTools.

root = this
log = root.log
define = root.define

define [
  'jquery'
  'touchable/touches'
], ($, Touches) ->

  slice = Array.prototype.slice

  rest = (array, index, guard) ->
    slice.call(array, if index? or guard then 1 else index)

  bind = (func, obj) ->
    args = rest arguments, 2
    -> func.apply obj or root, args.concat arguments

  class Touchable
    constructor: (@element) ->
      @$ele = $ @element
      @setTouchable true
      return
  
    setTouchable: (touchable) ->
      if @touchable is touchable then return
      @touchable = touchable
    
      @$ele.css 'pointer-events', if @touchable or @hoverable then 'auto' else 'none'
    
      if @touchable
        # if ! @_bound
        #   @_bound = 
        #     mouseDown:   bind(@_mouseDown, this)
        #     mouseMove:   bind(@_mouseMove, this)
        #     mouseUp:     bind(@_mouseUp, this)
        #   
        #     touchStart:  bind(@_touchStart, this)
        #     touchMove:   bind(@_touchMove, this)
        #     touchEnd:    bind(@_touchEnd, this)
        #     touchCancel: bind(@_touchCancel, this)
        @$ele.on
          'mousedown': @onMouseDown
          'touchstart': @onTouchStart
      else
        @$ele.off
          'mousedown': @onMouseDown
          'touchstart': @onTouchStart
    
      return
  
    triggerTouchDown: (touches) ->
      @$ele.trigger 'touchabledown', [touches]
    
    triggerTouchMove: (touches) ->
      @$ele.trigger 'touchablemove', [touches]
  
    triggerTouchUp: (touches) ->
      @$ele.trigger 'touchableup', [touches]
    
    onMouseDown: (event) =>
      $(document).on
        'mousemove': @onMouseMove
        'mouseup': @onMouseUp
    
      @touches = new Touches event
      @triggerTouchDown @touches
      return
  
    onMouseMove: (event) =>
      event.stopPropagation()
      event.preventDefault()
      @touches._updateWithEvent event
      @triggerTouchMove @touches
      return
  
    onMouseUp: (event) =>
      return unless @touches
      @touches._goUpWithEvent event
      @triggerTouchUp @touches
    
      delete @touches
      $(document).off
        'mousemove': @onMouseMove
        'mouseup': @onMouseUp
      return
  
    onTouchStart: (event) =>
      event.stopPropagation()
      event.preventDefault()
      
      # Prevent multi-touch.
      if @touches? or event.length > 1
        @onTouchCancel event
        return
      
      $(document).on
        'touchmove': @onTouchMove
        'touchend': @onTouchEnd
        'touchcancel': @onTouchCancel
      
      @touches = new Touches event
      @triggerTouchDown @touches
      return
  
    onTouchMove: (event) =>
      event.stopPropagation()
      event.preventDefault()
      return unless @touches?

      @touches._updateWithEvent event
      @triggerTouchMove @touches
      return
  
    onTouchEnd: (event) =>
      event.stopPropagation()
      event.preventDefault()
      return unless @touches?

      @touches._goUpWithEvent event
      @triggerTouchUp @touches
    
      delete @touches
      $(document).off
        'touchmove': @onTouchMove
        'touchend': @onTouchEnd
        'touchcancel': @onTouchCancel
      return
  
    onTouchCancel: (event) =>
      @onTouchEnd event
      return
  
  Touchable





























