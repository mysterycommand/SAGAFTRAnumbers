define [
  'jquery'
  'underscore'
], ($, _) ->
  class Category
    constructor: ->
      @notice = '<p id="category-i-notice" class="outset">Choose Category I for approved <a href="#twin-cities-co-ed-waiver" class="term open">Twin Cities Local waiver</a>s.</p>'
      @html = """
        <fieldset>
          <span style="vertical-align: top;">It's a</span>
          <span style="display: inline-block;">
            <input type="radio" name="category" id="category-i" value="0" checked /> <label for="category-i"><a href="#category-i-definition" class="term open">Category I</a></label><br/>
            <input type="radio" name="category" id="category-ii" value="1" /> <label for="category-ii"><a href="#category-ii-definition" class="term open">Category II</a></label>
          </span>
          program.<br/>
          #{@notice}
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]

      @setupOptions()
      @$el.on 'change', 'input', @onChange

    setupOptions: ->
      @selectedIndex = -1
      @selectedItem = null
      @options = [
        'Category I'
        'Category II'
      ]
    #     html = ''
    #     _.each @options, (el, i) -> html += """<option value="#{i}">#{el}</option>"""
    #     @$el.find('select').append(html);

    getSelectedItem: -> @selectedItem

    onChange: (event) =>
      @selectedIndex = parseInt(event.target.value, 10)
      @selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null
      if @selectedIndex != 0
        @$el.find('#category-i-notice').remove()
      else
        @$el.append(@notice)
      # log @selectedIndex, @selectedItem

  Category
