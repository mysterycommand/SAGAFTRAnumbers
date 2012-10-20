root = this
log = root.log
define = root.define

define [
], () ->
  class Touches
    constructor: (@event) ->
      @globalPoint = 
        x: parseInt event.pageX or event.originalEvent.touches[0].pageX, 10
        y: parseInt event.pageY or event.originalEvent.touches[0].pageY, 10
      @translation = 
        x: 0
        y: 0
      @delta = 
        x: 0
        y: 0
      @vel = 
        x: 0
        y: 0
      @count = 1
      @timestamp = event.timestamp
      @downTimestamp = @timestamp
      return
  
    _updateWithEvent: (event, remove) ->
      @event = event
      unless remove
        px = parseInt event.pageX or event.originalEvent.touches[0].pageX, 10
        py = parseInt event.pageY or event.originalEvent.touches[0].pageY, 10
        dx = px - @globalPoint.x
        dy = -py - @globalPoint.y
        @translation.x += dx
        @translation.y += dy
        @delta.x += dx
        @delta.y += dy
        @globalPoint.x = px
        @globalPoint.y = py
      
      timestamp = event.timestamp
      dt = timestamp - @timestamp
      samePoint = remove or (dx is 0 and dy is 0)
      stopped = samePoint and dt > 150
    
      @vel.x = if stopped then 0 else if (samePoint or dt is 0) then @vel.x else (dx / dt * 1000)
      @vel.y = if stopped then 0 else if (samePoint or dt is 0) then @vel.y else (dy / dt * 1000)
      @timestamp = timestamp
      return
  
    _goUpWithEvent: (event) ->
      @_updateWithEvent event, true
      @count = 0
    
      didMove = Math.abs(@translation.x) > 10 or Math.abs(@translation.y) > 10
      wasMoving = Math.abs(@vel.x) > 400 or Math.abs(@vel.y) > 400
      @wasTap = ! didMove and ! wasMoving and (@getTimeSinceGoingDown() < 300)
      return
  
    getTimeSinceGoingDown: () ->
      @timestamp - @downTimestamp
  
    resetDeltaTranslation: () ->
      @delta.x = 0
      @delta.y = 0
      return
  
  Touches





























