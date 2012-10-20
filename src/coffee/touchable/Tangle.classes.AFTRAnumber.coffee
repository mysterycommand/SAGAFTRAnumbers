isNumberDragging = false

Tangle.classes.AFTRANumber = 
  initialize: (@element, options, @tangle, @variable) ->
    @$ele = $(@element)
    
    # @min = options.min ? 0
    # @max = options.max ? 1e100
    # @step = options.step ? 1

    @min = @$ele.attr('min') ? options.min ? 0
    @max = @$ele.attr('max') ? options.max ? 1e100
    @step = @$ele.attr('step') ? options.step ? 1
    
    if ! @_bound
      @_bound = 
        touchDown: bind(@_touchDown, this)
        touchMove: bind(@_touchMove, this)
        touchUp: bind(@_touchUp, this)

    @isInput = @$ele.is('input')
    
    @initializeHover()
    @initializeHelp()
    @initializeDrag()
    
    if @isInput
      @update = @updateValue
      @$ele.on 'change input', (event) =>
        value = @getValue()
        @tangle.setValue @variable, value if ! isNaN(value)
        return
      # @$ele.parent().find('.clickArea').on('click', (event) =>
      #   log event
      #   @$ele.select()
      # )
    
    return
    
  getValue: ->
    parseInt @$ele.val() || 0, 10
  
  updateValue: (element, value) ->
    currentValue = @getValue()
    if value isnt currentValue then @$ele.val value
    return
  
  initializeHover: ->
    @isHovering = false
    
    $(@element).on "mouseenter", (event) =>
      @isHovering = true
      @updateRollOver()
      return
      
    $(@element).on "mouseleave", (event) =>
      @isHovering = false
      @updateRollOver()
      return

    return
    
  updateRollOver: ->
    @updateStyle()
    @updateCursor()
    @updateHelp()
    
    return
    
  isActive: ->
    # return this.isDragging || (this.isHovering && !isAnyAdjustableNumberDragging);
    @isDragging or (@isHovering and !isNumberDragging)
    
  updateStyle: ->
    # if (this.isDragging) { this.element.addClass("TKAdjustableNumberDown"); }
    # else { this.element.removeClass("TKAdjustableNumberDown"); }
    #   
    # if (!this.isDragging && this.isActive()) { this.element.addClass("TKAdjustableNumberHover"); }
    # else { this.element.removeClass("TKAdjustableNumberHover"); }
      
    if @isDragging
      @$ele.addClass "TKAdjustableNumberDown" # "AFTRANumberDown"
    else
      @$ele.removeClass "TKAdjustableNumberDown" # "AFTRANumberDown"

    if ! @isDragging and @isActive()
      @$ele.addClass "TKAdjustableNumberHover" # "AFTRANumberHover"
    else
      @$ele.removeClass "TKAdjustableNumberHover" # "AFTRANumberHover"
        
    return
    
  updateCursor: ->
    # var body = document.getElement("body");
    # if (this.isActive()) { body.addClass("TKCursorDragHorizontal"); }
    # else { body.removeClass("TKCursorDragHorizontal"); }
      
    $body = $ "body"
    if @isActive()
      $body.addClass "TKCursorDragHorizontal"
    else
      $body.removeClass "TKCursorDragHorizontal"
      
    return
  
  initializeHelp: ->
    @$help = $("<div class='TKAdjustableNumberHelp'>#{if @isInput then 'click or ' else ''}drag</div>")
    if @isInput
      @$ele.wrap '<span style="display: inline-block; position: relative;" />'
      # $('<div class="clickArea">&nbsp;</div>').insertAfter(@$ele)
      @$help.insertAfter(@$ele).hide()
    else
      @$help.prependTo(@$ele).hide()
    return
    
  updateHelp: ->
    # l = Math.round((@$ele.width() - 20) / 2)
    # t = -@$ele.height() + 7
    l = Math.round((@$ele.outerWidth() - @$help.width()) / 2)
    pt = @$ele.css 'paddingTop'
    bt = @$ele.css 'borderTopWidth'
    t = -@$help.height() - (parseInt(pt) + parseInt(bt)) * 2
    d = if @isHovering and ! isNumberDragging then 'block' else 'none'
    @$help.css({left: l, top: t, display: d})
    return
  
  initializeDrag: ->
    @isDragging = false
    @touchable = new Touchable @element
    @$ele.on
      'touchDown': @_bound.touchDown
      'touchMove': @_bound.touchMove
      'touchUp': @_bound.touchUp
    return
  
  _touchDown: (event, touches) ->
    # this.valueAtMouseDown = this.tangle.getValue(this.variable);
    # this.isDragging = true;
    # isAnyAdjustableNumberDragging = true;
    # this.updateRolloverEffects();
    # this.updateStyle();
    
    @valStart = @tangle.getValue @variable
    @isDragging = true
    isNumberDragging = true
    @updateRollOver()
    
    return
  
  _touchMove: (event, touches) ->
    # var value = this.valueAtMouseDown + touches.translation.x / 5 * this.step;
    # value = ((value / this.step).round() * this.step).limit(this.min, this.max);
    # this.tangle.setValue(this.variable, value);
    # this.updateHelp();
    
    value = @valStart + touches.translation.x / 5 * @step
    value = Math.min(Math.max(@min, (Math.round(value / @step) * @step)), @max)
    @tangle.setValue @variable, value
    @updateHelp()
    
    return
  
  _touchUp: (event, touches) ->
    # this.isDragging = false;
    # isAnyAdjustableNumberDragging = false;
    # this.updateRolloverEffects();
    # this.updateStyle();
    # this.helpElement.setStyle("display", touches.wasTap ? "block" : "none");

    @isDragging = false
    isNumberDragging = false
    @updateRollOver()
    @$help.css('display', if touches.wasTap then 'block' else 'none')
    
    @$ele.select() if touches.delta?.x is 0 and @valStart is @getValue()
    
    return






























