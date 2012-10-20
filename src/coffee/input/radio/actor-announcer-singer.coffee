root = this
log = root.log
define = root.define

define [
  'jquery'
  'input/actor-announcer-character'
  'touchable/draggable-number'
], ($, ActorAnnouncerCharacter, DraggableNumber) ->
	class ActorAnnouncerSinger
    constructor: ->
      @html = """
        <fieldset>
          I'll need
          <input type="number" name="num-actors" id="num-actors" value="0" min="0" max="10">
          <a href="#actor-announcer" class="term open">actor/announcer</a>(s) and
          <input type="number" name="num-singers" id="num-singers" value="0" min="0" max="2">
          <a href="#singer" class="term open">singer</a>(s).
          <span style="display: none;" id="more-singers">
            Looking for more singers?
            <a href="mailto:togren@sagaftra.org?subject=SAG-AFTRAnumbers%20Question">Contact Tim at SAG-AFTRA</a>!
          </span>
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]
      
      @actors = []
      @$el.on 'input change', '#num-actors', @onInputActors
      @$el.on 'input change', '#num-singers', @onInputSingers
    
    onInputActors: (event) =>
      # log 'onInputActors', event.type, event.target.id
      numActors = parseInt(event.target.value, 10)
      if numActors is @actors.length then return
      
      if numActors > @actors.length
        while @actors.length < numActors
          actor = new ActorAnnouncerCharacter(@actors.length + 1)
          @actors.push actor
          @$el.appendPolyfill actor.$el
      else
        while @actors.length > numActors
          @actors.pop().$el.remove()
      if event.type is 'input' then @$el.trigger 'change'
    
    onInputSingers: (event) =>
      # numSingers = parseInt(event.target.value, 10)
      if event.target.value is $(event.target).attr 'max'
        @$el.find('#more-singers').filter(":hidden").show()
      else
        @$el.find('#more-singers').filter(":visible").hide()
      if event.type is 'input' then @$el.trigger 'change'
  
  ActorAnnouncerSinger