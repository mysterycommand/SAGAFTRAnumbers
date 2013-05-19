define [
  'jquery'
  'underscore'
], ($, _) ->
	class NetworkProgramCommercial
    constructor: ->
      @label = "Network Program Commercial"
      @html = """
        <fieldset>
          Thirteen week cycle, with a
          <select name="network-program-use-type" id="network-program-use-type" class="chzn-select" data-placeholder="please choose...">
            <option value="-1"></option>
          </select>
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]

      @setupOptions()
      @$el.on('change', '#network-program-use-type', @onChange)

    setupOptions: ->
      @selectedIndex = -1
      @selectedItem = null
      @options = [
        '1 Week Use'
        '4 Week Use'
        '8 Week Use'
        '13 Week Use'
        '13 Week Limited Use (26 Uses)'
        '13 Week Limited Use (39 Uses)'
      ]
      html = ''
      _.each @options, (el, i) -> html += """<option value="#{i}">#{el}</option>"""
      @$el.find('select').append(html);


    getSelectedItem: -> @selectedItem

    onChange: (event) =>
      @selectedIndex = parseInt(event.target.value, 10)
      @selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null

  NetworkProgramCommercial
