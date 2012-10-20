root = this
log = root.log
define = root.define

define [
  'jquery'
  # 'input/actor-wardrobe'
  # 'input/extra-wardrobe'
], ($) -> #, ActorWardrobe, ExtraWardrobe
	class PrincipalActorGeneralExtra
    constructor: (@index) ->
      @html = """
        <div>
          On day #{@index + 1}, I'll need
          <input type="number" name="day-#{@index}-num-actors" id="day-#{@index}-num-actors" value="0" min="0" max="10">
          <a href="#principal-actor" class="term open">principal actor</a>(s) and
          <input type="number" name="day-#{@index}-num-extras" id="day-#{@index}-num-extras" value="0" min="0" max="10">
          <a href="#general-extra" class="term open">general extra</a>(s).
          <div class="actors" style="display: none">
            <input type="number" name="actor-wardrobe-fittings" id="actor-wardrobe-fittings" value="0" min="0" max="0">
            principal actors will need wardrobe fittings.
          </div>
          <div class="extras" style="display: none">
            <input type="number" name="extra-wardrobe-fittings" id="extra-wardrobe-fittings" value="0" min="0" max="0">
            general extras will need wardrobe fittings.
          </div>
        </div>
      """
      @$el = $ @html
      @el = @$el[0]
      
      @$el.on 'input change', "#day-#{@index}-num-actors", @onInputActors
      @$el.on 'input change', "#day-#{@index}-num-extras", @onInputExtras
    
    onInputActors: (event) =>
      numActors = parseInt event.target.value, 10
      if numActors > 0 then @$el.find('.actors').show() else @$el.find('.actors').hide()
      
      $fittings = @$el.find '#actor-wardrobe-fittings'
      prevMax = parseInt $fittings.prop('max'), 10
      prevVal = parseInt $fittings.val(), 10
      $fittings.prop 'max', numActors
      
      $fittings.val Math.max(0, prevVal + (numActors - prevMax))
      return
    
    onInputExtras: (event) =>
      numExtras = parseInt event.target.value, 10
      if numExtras > 0 then @$el.find('.extras').show() else @$el.find('.extras').hide()
      
      $fittings = @$el.find '#extra-wardrobe-fittings'
      prevMax = parseInt $fittings.prop('max'), 10
      prevVal = parseInt $fittings.val(), 10
      $fittings.prop 'max', numExtras
      
      $fittings.val Math.max(0, prevVal + (numExtras - prevMax))
      return
  
  PrincipalActorGeneralExtra