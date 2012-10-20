root = this
log = root.log
define = root.define

define [
  'jquery'
  'input/actor-wardrobe'
  'input/extra-wardrobe'
], ($, ActorWardrobe, ExtraWardrobe) ->
	class PrincipalActorGeneralExtra
    constructor: (@index) ->
      @html = """
        <div>
          On day #{@index + 1}, I'll need
          <input type="number" name="day-#{@index}-num-actors" id="day-#{@index}-num-actors" value="0" min="0" max="10">
          <a href="#principal-actor">principal actor</a>(s) and
          <input type="number" name="day-#{@index}-num-extras" id="day-#{@index}-num-extras" value="0" min="0" max="10">
          <a href="#general-extra">general extra</a>(s).
          <ul class="actors"></ul>
          <ul class="extras"></ul>
        </div>
      """
      @$el = $ @html
      @el = @$el[0]
      
      @actors = []
      @extras = []
      @$el.on 'input', "#day-#{@index}-num-actors", @onInputActors
      @$el.on 'input', "#day-#{@index}-num-extras", @onInputExtras
    
    onInputActors: (event) =>
      numActors = parseInt(event.target.value, 10)
      if numActors is @actors.length then return
      
      if numActors > @actors.length
        while @actors.length < numActors
          actor = new ActorWardrobe(@actors.length)
          @actors.push actor
          @$el.find('.actors').append actor.$el
      else
        while @actors.length > numActors
          @actors.pop().$el.remove()
    
    onInputExtras: (event) =>
      numExtras = parseInt(event.target.value, 10)
      if numExtras is @extras.length then return
      
      if numExtras > @extras.length
        while @extras.length < numExtras
          extra = new ExtraWardrobe(@extras.length)
          @extras.push extra
          @$el.find('.extras').append extra.$el
      else
        while @extras.length > numExtras
          @extras.pop().$el.remove()
      
  
  PrincipalActorGeneralExtra