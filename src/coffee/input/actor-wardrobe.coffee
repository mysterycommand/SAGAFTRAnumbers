root = this
log = root.log
define = root.define

define [
  'jquery'
], ($) ->
	class ActorWardrobe
    constructor: (@index) ->
      @html = """
        <li>
          <input type="checkbox" name="actor-#{@index}-wardrobe-fitting" value="1" checked>
          wardrobe fitting for principal actor #{@index + 1}.
        </li>
      """
      @$el = $ @html
      @el = @$el[0]
      throw "This class was deprecated as of version 0.5!"
  
  ActorWardrobe
