define [
  'jquery'
  'underscore'
], ($, _) ->
  class Category
    constructor: ->
      @notice = '<p id="category-i-notice" class="outset">*Choose Category I for approved <a href="#twin-cities-co-ed-waiver" class="term open">Twin Cities Local waiver</a>s.</p>'
      @html = """
        <fieldset>
          <span style="vertical-align: top;">It's a</span>
          <span style="display: inline-block;">
            <input type="radio" name="category" id="category-i" value="0" checked /> <label for="category-i"><a href="#category-i-definition" class="term open">Category I</a><span id="category-i-asterisk">*</span></label><br/>
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

      # Hide the notice if Category I isn't selected.
      $halfNarrators = $ '#num-half-narrators' # Kind of a hack.
      # This grabs the #num-half-narrators input field from the next fieldset
      # and hide/shows it (and it's label/notice) based on the current category.
      # This particular kind of branching was never really planned for in the
      # original app design. ¯\_(ツ)_/¯
      if @selectedIndex != 0
        @$el
          .find('#category-i-asterisk')
          .css('visibility', 'hidden').end()
          .find('#category-i-notice').remove()

        $halfNarrators
          .val(0)
          .closest('div')
          .hide()
          .closest('fieldset')
          .find('#half-day-narrator-notice')
          .hide()
      else
        @$el
          .find('#category-i-asterisk')
          .css('visibility', 'visible').end()
          .append(@notice)

        $halfNarrators
          .closest('div')
          .show()
          .closest('fieldset')
          .find('#half-day-narrator-notice')
          .show()
      # log @selectedIndex, @selectedItem

  Category
