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
      price = 0
      count = 0
      
      @html += """
        <tbody class="#{@classNames.join ' '}">
          <tr>
            <th colspan="2" headers="line-item-label">#{@data.label}</th>
          </tr>
      """
      
      if @data.first?
        price = if isNaN @data.first.price then 0 else @data.first.price
        @html += """
          <tr>
            <td headers="line-item-label" class="label">#{@data.first.label}</td>
            <td headers="line-item-amount" class="amount">$ #{price.toFixed(2)}</td>
          </tr>
        """
        @cost += price
      
      for item in @data.items
        count = if isNaN item.count then 0 else item.count
        price = if isNaN item.price then 0 else item.price
        @html += """
          <tr>
            <td headers="line-item-label" class="label">#{if count > 0 then count.toString() + ' ' else ''}#{item.label}</td>
            <td headers="line-item-amount" class="amount">$ #{if count > 0 then (count * price).toFixed(2) else price.toFixed(2)}</td>
          </tr>
        """
        @cost += if count > 0 then (count * price) else price
      
      @html += """
        </tbody>
      """
      return
  
  LineItemGroup
