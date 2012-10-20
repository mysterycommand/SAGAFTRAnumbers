root = this
log = root.log
define = root.define

define [
  'jquery'
  'underscore'
], ($, _) ->
	class NationalCable13
    constructor: ->
      @label = "National Cable - 13 week cycle"
      @html = """
        <fieldset>
          It will be broadcast on a national station with
          <select name="subscribers" id="subscribers" class="chzn-select" data-placeholder="please choose...">
            <option value="-1"></option>
          </select>
          subscribers.
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]
      
      @setupOptions()
      @$el.on('change', '#subscribers', @onChange)
    
    setupOptions: ->
      @selectedIndex = -1
      @selectedItem = null
      @options = [
        'Minimum'
        'Maximum (2,000 units)'
      ]
      html = ''
      _.each @options, (el, i) -> html += """<option value="#{i}">#{el}</option>"""
      @$el.find('select').append(html);
    
    getSelectedItem: -> @selectedItem
    
    onChange: (event) =>
      @selectedIndex = parseInt(event.target.value, 10)
      @selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null
    
  NationalCable13
