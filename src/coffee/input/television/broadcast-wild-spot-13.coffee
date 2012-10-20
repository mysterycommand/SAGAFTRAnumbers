root = this
log = root.log
define = root.define

define [
  'jquery'
  'underscore'
], ($, _) ->
	class WildSpot13
    constructor: ->
      @label = "Wild Spot - 13 week cycle"
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
      @options = [
        #   {value: 4, label: "Minneapolis-St. Paul"}
        #   {value: 6, label: "Atlanta"}
        #   {value: 3, label: "Baltimore"}
        #   {value: 2, label: "Birmingham (Ann, Tusc)"}
        #   {value: 6, label: "Boston"}
        #   {value: 3, label: "Charlotte"}
        #   {value: "Chicago", label: "Chicago"}
        #   {value: 2, label: "Cincinnati"}
        #   {value: 4, label: "Cleveland"}
        #   {value: 2, label: "Colombus, OH"}
        #   {value: 7, label: "Dallas-Fort Worth"}
        #   {value: 4, label: "Denver"}
        #   {value: 5, label: "Detroit"}
        #   {value: 2, label: "Grand Rapids-Kalamazoo-Battle Creek"}
        #   {value: 2, label: "Greenville-Spartanburg-Asheville-Anderson, NC"}
        #   {value: 2, label: "Harrisburg-Lancaster-Lebanon-York"}
        #   {value: 2, label: "Hartford-New Haven"}
        #   {value: 6, label: "Houston"}
        #   {value: 3, label: "Indianapolis"}
        #   {value: 2, label: "Kansas City"}
        #   {value: 2, label: "Las Vegas"}
        #   {value: "Los Angeles", label: "Los Angeles"}
        #   {value: 43, label:"Mexico/Mexico City"}
        #   {value: 4, label: "Miami"}
        #   {value: 2, label: "Milwaukee"}
        #   {value: 4, label: "Montreal"}
        #   {value: 2, label: "Nashville"}
        #   {value: "New York", label: "New York"}
        #   {value: 2, label: "Norfolk-Portsmouth-Newport News"}
        #   {value: 4, label: "Orlando-Daytona Beach"}
        #   {value: 8, label: "Philadelphia"}
        #   {value: 5, label: "Phoenix"}
        #   {value: 3, label: "Pittsburgh"}
        #   {value: 3, label: "Portland, OR"}
        #   {value: 3, label: "Puerto Rico"}
        #   {value: 3, label: "Raleigh-Durham"}
        #   {value: 3, label: "Sacramento-Stockton"}
        #   {value: 2, label: "San Antonio"}
        #   {value: 2, label: "Salt Lake City"}
        #   {value: 3, label: "San Diego"}
        #   {value: 7, label: "San Francisco"}
        #   {value: 5, label: "Seattle-Tacoma"}
        #   {value: 3, label: "St. Louis"}
        #   {value: 5, label: "Tampa-St. Petersburg"}
        #   {value: 7, label: "Toronto"}
        #   {value: 3, label: "Vancouver, B.C."}
        #   {value: 6, label: "Washington, D.C."}
        #   {value: 2, label: "West Palm Beach-Ft. Pierce"}
        #   {value: 0, label: "Looking for state-wide buys or smaller markets? Ask Tim at SAG-AFTRA"}
      ]
      html = ''
      _.each @options, (el, i) -> html += """<option value="#{i}">#{el.label}</option>"""
      # _.each @options, (el, i) -> html += """<option value="#{i}" data-value="#{el.value}">#{el.label}</option>"""
      @$el.find('select').append(@options);
    
    getSelectedItem: -> @selectedItem
    
    onChange: (event) =>
      @selectedIndex = parseInt(event.target.value, 10)
      @selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null
    
    
  WildSpot13
