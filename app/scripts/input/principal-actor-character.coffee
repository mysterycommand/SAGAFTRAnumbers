define [
  'jquery'
], ($) ->
  class PrincipalActorCharacter
    constructor: (@index) ->
      @html = """
        <p>
          Principal actor #{@index} will do
          <input type="number" name="actor-#{@index}-num-characters" id="actor-#{@index}-num-characters" class="num-characters" value="1" min="1" max="10">
          <a href="#character-voice" class="term open">character/voice</a>(s).
        </p>

      """
      @$el = $ @html
      @el = @$el[0]

  PrincipalActorCharacter
