root = this
log = root.log
define = root.define

define [
  'jquery'
  'underscore'
  'input/radio/broadcast-wild-spot-13'
  'input/radio/broadcast-wild-spot-8'
  'input/radio/broadcast-dealer-commercial'
  'input/radio/broadcast-network-program-commercial'
  'input/radio/broadcast-regional-network-program-commercial'
], ($, _, WildSpot13, WildSpot8, DealerCommercial, NetworkProgramCommercial, RegionalNetworkProgramCommercial) ->
	class UseBroadcast
    constructor: ->
      @label = "only as a radio broadcast"
      @html = """
        <p>
          It will be broadcast as a
          <select name="broadcast-type" id="broadcast-type" class="chzn-select" data-placeholder="please choose...">
            <option value="-1"></option>
          </select>
        </p>
      """
      @$el = $ @html
      @el = @$el[0]
      
      @setupOptions()
      @$el.on('change', '#broadcast-type', @onChange)
    
    setupOptions: ->
      @selectedIndex = -1
      @selectedItem = null
      @options = [
        new WildSpot13()
        new WildSpot8()
        new DealerCommercial()
        new NetworkProgramCommercial()
        new RegionalNetworkProgramCommercial()
      ]
      
      html = ''
      _.each @options, (el, i) -> html += """<option value="#{i}">#{el.label}</option>"""
      @$el.find('select').append(html);
    
    getSelectedItem: -> @selectedItem
    
    onChange: (event) =>
      @selectedIndex = parseInt(event.target.value, 10)
      @selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null
      
      # if @selectedItem? then 
    
  UseBroadcast
