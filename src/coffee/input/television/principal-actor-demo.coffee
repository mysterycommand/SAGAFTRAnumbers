root = this
log = root.log
define = root.define

define [
  'jquery'
  'input/principal-actor-character'
], ($, PrincipalActorCharacter) ->
	class PrincipalActorDemo
    constructor: (@index) ->
      @html = """
        <fieldset>
          I'll need
          <input type="number" name="num-actors" id="num-actors" value="0" min="0" max="10">
          <a href="#principal-actor" class="term open">principal actor</a>(s).
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]
      
      @actors = []
      @$el.on 'input change', '#num-actors', @onInputActors
    
    onInputActors: (event) =>
      numActors = parseInt(event.target.value, 10)
      if numActors is @actors.length then return
      
      if numActors > @actors.length
        while @actors.length < numActors
          actor = new PrincipalActorCharacter(@actors.length + 1)
          @actors.push actor
          @$el.appendPolyfill actor.$el
      else
        while @actors.length > numActors
          @actors.pop().$el.remove()
  
  PrincipalActorDemo