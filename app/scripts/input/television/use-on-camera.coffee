define [
  'jquery'
  'underscore'
  'input/television/use-broadcast-on-camera'
  'input/television/use-internet'
  'input/television/use-both-on-camera'
], ($, _, UseBroadcast, UseInternet, UseBoth) ->
	class Use
    constructor: ->
      @html = """
        <fieldset>
          This commercial will air
          <select name="use-type" id="use-type" class="chzn-select" data-placeholder="please choose...">
            <option value="-1"></option>
          </select>
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]

      @setupOptions()
      @$el.on('change', '#use-type', @onUseChange)

    setupOptions: ->
      @selectedIndex = -1
      @selectedItem = null
      @options = [
        new UseBroadcast()
        new UseInternet()
        new UseBoth()
      ]

      html = ''
      _.each @options, (el, i) -> html += """<option value="#{i}">#{el.label}</option>"""
      @$el.find('select').append(html);

    onUseChange: (event) =>
      @selectedIndex = parseInt(event.target.value, 10)
      @selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null

      @$el.find('p').detach()
      @$el.nextAll().not('#input-cta').detach()

      if @selectedItem?

        # FIND ME LATER
        # @$el.append @selectedItem.$el
        @$el.appendPolyfill @selectedItem.$el

        if @selectedIndex is 0 or @selectedIndex is 2
          @$el
            .off('change', '#broadcast-type')
            .on('change', '#broadcast-type', @onBroadcastChange)
          @selectedItem.$el.find('#broadcast-type').trigger 'change'

    onBroadcastChange: (event) =>
      @$el.nextAll().not('#input-cta').detach()

      broadcastType = @selectedItem.getSelectedItem()

      # FIND ME LATER
      # if broadcastType? then @$el.after broadcastType.$el
      if broadcastType? then @$el.afterPolyfill broadcastType.$el

  Use






























