define [
  'jquery'
  'underscore'

  'input/corp-edu/principal-actor-hour'
], ($, _, PrincipalActorHour) ->
  class PrincipalActorAudioOnly
    constructor: ->
      @html = """
        <fieldset>
          I'll need:
          <div>
            <input type="number" name="num-principals" id="num-principals" value="0" min="0" max="10">
            <a href="#principal-actor-audio-only" class="term open">Audio Only - principal actor</a>(s),
          </div>
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]

      @principals = []
      @$el.on 'input change', '#num-principals', @onInputPrincipals

    onInputPrincipals: (event) =>
      numPrincipals = parseInt event.target.value, 10
      if numPrincipals is @principals.length then return

      if @principals.length < numPrincipals
        while @principals.length < numPrincipals
          principal = new PrincipalActorHour @principals.length + 1
          @principals.push principal
          # @principals.push "#{@principals.length + 1}"

          # FIND ME LATER
          # $(event.target).closest('div').append principal.$el
          $(event.target).closest('div').appendPolyfill principal.$el
      else
        while @principals.length > numPrincipals
          @principals.pop().$el.remove()

      if event.type is 'input' then @$el.trigger 'change'

  PrincipalActorAudioOnly
