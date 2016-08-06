define [
  'jquery'
  'underscore'
  'input/use/internet-4-week'
  'input/use/internet-8-week'
  'input/use/internet-1-year'
], ($, _, Internet4Week, Internet8Week, Internet1Year) ->
  class UseInternet
    constructor: ->
      @label = "on the Internet or in new media"
      @html = """
        <p>
          It will be used on the Internet or in new media with the
          <select name="internet-type" id="internet-type" class="chzn-select" data-placeholder="please choose...">
            <option value="-1"></option>
          </select>
        </p>
      """
      @$el = $ @html
      @el = @$el[0]

      @setupOptions()
      @$el.on('change', '#internet-type', @onChange)

    setupOptions: ->
      @selectedIndex = -1
      @selectedItem = null
      @options = [
        new Internet4Week()
        new Internet8Week()
        new Internet1Year()
      ]

      html = ''
      _.each @options, (el, i) -> html += """<option value="#{i}">#{el.label}</option>"""
      @$el.find('select').append(html);

    getSelectedItem: -> @selectedItem

    onChange: (event) =>
      @selectedIndex = parseInt(event.target.value, 10)
      @selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null

  UseInternet
