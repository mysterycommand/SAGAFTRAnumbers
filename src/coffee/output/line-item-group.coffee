root = this
log = root.log
define = root.define

define [
  'jquery'
], ($) ->
  class LineItemGroup
    constructor: (className) ->
      @classNames = ['line-item-group']
      @classNames.push className
      return
    
    estimate: (@data) ->
      @html = ""
      @cost = 0
      
      @html += """
        <tbody class="#{@classNames.join ' '}">
          <tr>
            <th colspan="2" headers="line-item-label">#{@data.label}</th>
          </tr>
      """
      
      if @data.first?
        @html += """
          <tr>
            <td headers="line-item-label" class="label">#{@data.first.label}</td>
            <td headers="line-item-amount" class="amount">$ #{@data.first.price.toFixed(2)}</td>
          </tr>
        """
        @cost += @data.first.price
      
      for item in @data.items
        @html += """
          <tr>
            <td headers="line-item-label" class="label">#{if item.count > 0 then item.count.toString() + ' ' else ''}#{item.label}</td>
            <td headers="line-item-amount" class="amount">$ #{if item.count > 0 then (item.count * item.price).toFixed(2) else item.price.toFixed(2)}</td>
          </tr>
        """
        @cost += if item.count > 0 then (item.count * item.price) else item.price
      
      @html += """
        </tbody>
      """
      return
  
  LineItemGroup
