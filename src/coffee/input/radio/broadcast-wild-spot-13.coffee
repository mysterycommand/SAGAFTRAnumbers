root = this
log = root.log
define = root.define

define [
    'jquery'
    'underscore'
    'input/util/broadcastMarkets'
], ($, _, broadcastMarkets) ->
    class WildSpot13
        constructor: ->
            @label = "Wild Spot - 13 week cycle"
            @html = """
                <fieldset>
                    It will be broadcast in the following markets:
                    <select name="markets" id="markets" multiple class="chzn-select" data-placeholder="please choose all that apply...">
                        <option value="-1"></option>
                    </select>
                </fieldset>
            """
            @$el = $ @html
            @$markets = @$el.find '#markets'
            @el = @$el[0]
            
            @setupOptions()
            @$el.on('change', '#markets', @onChange)
        
        setupOptions: ->
            @selectedIndex = -1
            @selectedItem = null
            @options = broadcastMarkets
            html = ''
            _.each @options, (el, i) -> html += """<option value="#{i}" data-value="#{el.value}"#{if el.value.toString().indexOf('mailto') > -1 then ' class="mailto"' else ''}>#{el.label}</option>"""
            @$el.find('select').append(html);
        
        getSelectedItem: -> @selectedItem
        
        onChange: (event) =>
            val = @$markets.val()
            
            @selectedIndex = val?.pop() || -1; # parseInt(event.target.value, 10)
            @selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null
            
            # log '1', val, @selectedIndex, @selectedItem
            return if ! @selectedItem or @selectedItem is null
            
            # log '2', @selectedItem.value, isNaN(parseInt(@selectedItem.value, 10))
            return unless isNaN(parseInt(@selectedItem.value, 10))
            
            # log '3', @selectedItem.value.indexOf('mailto'), @selectedItem.value.indexOf('mailto') is -1
            return if @selectedItem.value.indexOf('mailto') is -1
            
            # log '4', val, @selectedIndex, @selectedItem, @selectedItem.value, isNaN(parseInt(@selectedItem.value, 10)), @selectedItem.value.indexOf('mailto'), @selectedItem.value.indexOf('mailto') is -1
            
            # Open the mailto link.
            mailto = window.open @selectedItem.value, 'mailto'
            if mailto and mailto.open and ! mailto.closed then mailto.close()
            
            # Remove the mailto item from the selection.
            @$markets.val(val).trigger('change').trigger('liszt:updated')
            return
    
    WildSpot13
