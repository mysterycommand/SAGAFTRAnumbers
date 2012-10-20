root = this
log = root.log
define = root.define

define [
  'jquery'
  'output/line-item-group'
], ($, LineItemGroup) ->
  class Estimator
    constructor: (@label, @className) ->
      @estimators = []
      return
    
    estimate: (@data) ->
      @html = ""
      @cost = 0
      
      for lineItem, i in @data
        @estimators[i] ?= new LineItemGroup(@className)
        @estimators[i].estimate lineItem
        @html += @estimators[i].html
        @cost += @estimators[i].cost
      
      @html += """
        <tbody class="line-item-group #{@className}-subtotal">
          <tr>
            <th headers="line-item-label" class="label">#{@label}</th>
            <th headers="line-item-amount" class="amount">$ #{@cost.toFixed(2)}</th>
          </tr>
        </tbody>
      """
      return
    
  Estimator
