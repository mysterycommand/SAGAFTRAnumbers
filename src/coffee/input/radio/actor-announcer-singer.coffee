root = this
log = root.log
define = root.define

define [
  'jquery'
  'input/actor-announcer-character'
], ($, ActorAnnouncerCharacter) ->
	class ActorAnnouncerSinger
    constructor: ->
      @html = """
        <fieldset>
          I'll need
          <input type="number" name="num-actors" id="num-actors" value="0" min="0" max="10">
          <a href="#actor-announcer">actor/announcer</a>(s) and
          <input type="number" name="num-singers" id="num-singers" value="0" min="0" max="2">
          <a href="#singer">singer</a>(s).
          <span style="display: none;" id="more-singers">
            Looking for more singers?
            <a href="mailto:togren@sagaftra.org?subject=SAG-AFTRAnumbers%20Question">Contact Tim at SAG-AFTRA</a>!
          </span>
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]
      
      @actors = []
      @$el.on 'input', '#num-actors', @onInputActors
      @$el.on 'input', '#num-singers', @onInputSingers
    
    onInputActors: (event) =>
      numActors = parseInt(event.target.value, 10)
      if numActors is @actors.length then return
      
      if numActors > @actors.length
        while @actors.length < numActors
          actor = new ActorAnnouncerCharacter(@actors.length)
          @actors.push actor
          @$el.append actor.$el
      else
        while @actors.length > numActors
          @actors.pop().$el.remove()
    
    onInputSingers: (event) =>
      # numSingers = parseInt(event.target.value, 10)
      if event.target.value is $(event.target).attr 'max'
        @$el.find('#more-singers').filter(":hidden").show()
      else
        @$el.find('#more-singers').filter(":visible").hide()
      
  
  ActorAnnouncerSinger