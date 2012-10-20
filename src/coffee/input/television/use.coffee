root = this
log = root.log
define = root.define

define [
  'jquery'
  'underscore'
  'input/television/use-broadcast'
  'input/television/use-internet'
  'input/television/use-both'
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
      
      @$el.find('p').remove()
      @$el.nextAll().remove()
      
      if @selectedItem?
        @$el.append @selectedItem.$el
        if @selectedIndex is 0 or @selectedIndex is 2
          @$el.off('change', '#broadcast-type').on('change', '#broadcast-type', @onBroadcastChange)
        
    onBroadcastChange: (event) =>
      @$el.nextAll().remove()
      
      broadcastType = @selectedItem.getSelectedItem()
      @$el.after broadcastType.$el
  
  Use
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  