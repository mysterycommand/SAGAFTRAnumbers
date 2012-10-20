root = this
log = root.log
define = root.define

define [
  'jquery'
  'underscore'
  
  'input/radio/radio-commercial'
  'input/radio/radio-commercial-demo'
  
  'input/television/television-commercial-on-camera'
  'input/television/television-commercial-off-camera'
  'input/television/television-commercial-demo'
  
  'input/psa/psa-radio'
  'input/psa/psa-television-on-camera'
  'input/psa/psa-television-off-camera'

  'chosen'
], ($, _, RadioCommercial, RadioCommercialDemo, TelevisionCommercialOnCamera, TelevisionCommercialOffCamera, TelevisionCommercialDemo, PublicServiceAnnouncementRadio, PublicServiceAnnouncementTelevisionOnCamera, PublicServiceAnnouncementTelevisionOffCamera) ->
	class JobType
		constructor: () ->
      @html = """
        <fieldset>
          I'm hiring for a
          <select name="job-type" id="job-type" class="chzn-select" data-placeholder="please choose your job">
            <option value="-1"></option>
          </select>.
        </fieldset>
      """
      @$el = $ @html
      @el = @$el[0]
      
      @setupOptions()
      @$el.on('change', '#job-type', @onChange)
    
    setupOptions: ->
      @selectedIndex = -1
      @selectedItem = null
      @options = [
        new RadioCommercial()
        new RadioCommercialDemo()
        new TelevisionCommercialOnCamera()
        new TelevisionCommercialOffCamera()
        new TelevisionCommercialDemo()
        new PublicServiceAnnouncementRadio()
        new PublicServiceAnnouncementTelevisionOnCamera()
        new PublicServiceAnnouncementTelevisionOffCamera()
      ]
      
      html = ''
      _.each @options, (el, i) -> html += """<option value="#{i}">#{el.label}</option>"""
      @$el.find('select').append(html)
    
    onChange: (event) =>
      log event
      # if @selectedItem? then @selectedItem.destroy()
      # if @selectedItem? then @selectedItem.cleanup() # Should set all selects to -1, and clear any values?
      
      @selectedIndex = parseInt(event.target.value, 10)
      @selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null
      
      @$el.siblings().detach() # TODO: Make sure that detach is better than remove, and that we're not having a bunch of event handler references floating around.
      if @selectedItem?
        @$el.afterPolyfill @selectedItem.$el
        # This only applies to 'input/television/principal-actor-general-extra', 
        # but it needs to be called after that objec is added to the DOM.
        @selectedItem.$el.find('#num-days').trigger 'input'
	
	JobType
