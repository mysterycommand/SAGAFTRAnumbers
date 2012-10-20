root = this
log = root.log
define = root.define

define [
  'jquery'
  'underscore'
], ($, _) ->
	class WildSpot8
    constructor: ->
      @label = "Wild Spot - 8 week cycle"
      @html = """
        <fieldset>
          It will be broadcast in the following markets:
          <select name="markets" id="markets" multiple class="chzn-select" data-placeholder="please choose...">
            <option value="-1"></option>
          </select>
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]
      
      @setupOptions()
      @$el.on('change', '#markets', @onChange)
    
    setupOptions: ->
      @selectedIndex = -1
      @selectedItem = null
      @options = []
      html = ''
      _.each @options, (el, i) -> html += """<option value="#{i}">#{el.label}</option>"""
      @$el.find('select').append(@options);
    
    getSelectedItem: -> @selectedItem
    
    onChange: (event) =>
      @selectedIndex = parseInt(event.target.value, 10)
      @selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null
    
  WildSpot8
