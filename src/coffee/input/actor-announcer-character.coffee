root = this
log = root.log
define = root.define

define [
  'jquery'
], ($) ->
	class ActorAnnouncerCharacter
    constructor: (@index) ->
      @html = """
        <p>
          Actor/announcer #{@index + 1} will do
          <input type="number" name="actor-#{@index}-num-characters" value="1" min="1" max="10">
          <a href="#character-voice">character/voice</a>(s).
        </p>

      """
      @$el = $ @html
      @el = @$el[0]
  
  ActorAnnouncerCharacter
