define [
  'jquery'
  # 'input/actor-wardrobe'
  # 'input/extra-wardrobe'
], ($) -> #, ActorWardrobe, ExtraWardrobe
  class PrincipalActorGeneralExtra
    constructor: (@index) ->
      @html = """
        <div>
          On day #{@index}, I'll need
          <input type="number" name="day-#{@index}-num-actors" id="day-#{@index}-num-actors" class="actor" value="0" min="0" max="10">
          <a href="#principal-actor" class="term open">principal actor</a>(s) and
          <input type="number" name="day-#{@index}-num-extras" id="day-#{@index}-num-extras" class="extra" value="0" min="0" max="10">
          <a href="#general-extra" class="term open">general extra</a>(s).
          <div class="actors" style="display: none">
            <input type="number" name="day-#{@index}-actors-wardrobe" id="day-#{@index}-actors-wardrobe" class="actors-wardrobe" value="0" min="0" max="0">
            principal actor(s) will need <a href="#wardrobe-fitting" class="term open">wardrobe fittings</a>.
          </div>
          <!--
          <div class="extras" style="display: none">
            <input type="number" name="day-#{@index}-extras-wardrobe" id="day-#{@index}-extras-wardrobe" class="extras-wardrobe" value="0" min="0" max="0">
            general extra(s) will need <a href="#wardrobe-fitting" class="term open">wardrobe fittings</a>.
          </div>
          -->
        </div>
      """
      @$el = $ @html
      @el = @$el[0]

      if @index is 1
        @$el.on 'input change', "#day-#{@index}-num-actors", @onInputActors
        @$el.on 'input change', "#day-#{@index}-num-extras", @onInputExtras

    onInputActors: (event) =>
      numActors = parseInt event.target.value, 10
      console.log event.target.value, numActors
      if numActors > 0 then @$el.find('.actors').show() else @$el.find('.actors').hide()

      $fittings = @$el.find '.actors-wardrobe'
      prevMax = parseInt($fittings.prop('max'), 10) or 0
      prevVal = parseInt($fittings.val(), 10) or 0
      $fittings.prop 'max', numActors

      $fittings.val Math.max(0, prevVal + (numActors - prevMax))
      return

    onInputExtras: (event) =>
      numExtras = parseInt event.target.value, 10
      if numExtras > 0 then @$el.find('.extras').show() else @$el.find('.extras').hide()

      $fittings = @$el.find '.extras-wardrobe'
      prevMax = parseInt $fittings.prop('max'), 10
      prevVal = parseInt $fittings.val(), 10
      $fittings.prop 'max', numExtras

      $fittings.val Math.max(0, prevVal + (numExtras - prevMax))
      return

  PrincipalActorGeneralExtra
