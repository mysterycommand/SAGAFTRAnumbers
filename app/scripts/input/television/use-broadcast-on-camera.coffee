define [
  'jquery'
  'underscore'
  'input/television/broadcast-wild-spot-13'
  'input/television/broadcast-local-cable-13'
  'input/television/broadcast-national-cable-13'
  'input/television/broadcast-network-program-commercial'
], ($, _, WildSpot13, LocalCable13, NationalCable13, NetworkProgramCommercial) ->
  class UseBroadcast
    constructor: ->
      @label = "only as a television broadcast"
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
        new LocalCable13()
        new NationalCable13()
        new NetworkProgramCommercial()
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
