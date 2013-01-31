root = this
log = root.log
define = root.define

define [
    'jquery'
    'underscore'

    'input/radio/*'
    'input/television/*'
    'input/psa/*'
    'input/corp-edu/*'

    'chosen'
], ($, _, Radio, TV, PSA, CorpEdu) ->
    class JobType
        constructor: () ->
            @html = """
                <fieldset id="job-type-fieldset">
                    <span style="vertical-align: top;">I'm hiring for a</span>
                    <span id="job-type-span">
                        <select name="job-type" id="job-type" class="chzn-select" data-placeholder="please choose your job">
                            <option value="-1" data-value="none"></option>
                        </select>
                    </span>
                </fieldset>
            """
            @$el = $ @html
            @el = @$el[0]
            
            @setupOptions()
            @$el.on 'change', '#job-type', @onChange
        
        setupOptions: ->
            @selectedIndex = -1
            @selectedItem = null
            @options = [
                new Radio.Commercial()
                new Radio.Demo()

                new TV.OnCamera()
                new TV.OffCamera()
                new TV.Demo()
                
                new PSA.Radio()
                new PSA.OnCamera()
                new PSA.OffCamera()

                new CorpEdu.OnCamera()
                new CorpEdu.OffCamera()
                new CorpEdu.AudioOnly()
                
                {value: "mailto:Timothy.Ogren@sagaftra.org?subject=SAG-AFTRAnumbers%20Question", label: "Not seeing the job you're looking for?  Ask Tim"}
            ]
            
            html = ''
            _.each @options, (el, i) -> html += """<option value="#{i}" data-value="#{el.value}"#{if el.value.toString().indexOf('mailto') > -1 then ' class="mailto"' else ''}>#{el.label}</option>"""
            @$el.find('select').append(html)
        
        onChange: (event) =>
            @selectedIndex = parseInt event.target.value, 10
            @selectedItem = if @selectedIndex isnt -1 then @options[@selectedIndex] else null
            
            if @selectedItem?
                @$el.siblings().detach() # TODO: Make sure that detach is better than remove, and that we're not having a bunch of event handler references floating around.
                @$el.find('a.term.open').remove()
                
                # FIND ME LATER
                # @$el.after @selectedItem.$el
                @$el.afterPolyfill @selectedItem.$el
                @$el.find('#job-type-span').append """<a href="##{@selectedItem.definitionId}" class="term open">What is: #{@selectedItem.label}?</a>"""

                isPSA = (4 < @selectedIndex < 8)
                headsUp = if isPSA then "Prior Union authorization required for PSA waivers." else """
                    These things might apply to your #{@selectedItem.label}:
                    #{@selectedItem.headsUpItems.join(', ') + ', etc'}.
                """
                @$el.parent().append """
                <div id="input-cta" class="cta" style="display: none;">
                    <p>Heads Up! #{headsUp} For details <a href="mailto:Timothy.Ogren@sagaftra.org">Ask Tim</a>.</p>
                </div>
                """
                # @selectedItem.headsUpItems.join(', ') + ', etc.'
                # @$el.after @selectedItem.$el
                
                # There are a couple of special cases that need to be handled after the job-type is added to the DOM.
                if 2 <= @selectedIndex <= 4 then @selectedItem.$el.find('#num-days').trigger 'input' # TV.*
                # if @selectedIndex is 10 then @selectedItem.$el.find('#storecasting').trigger 'change' # CorpEdu.AudioOnly
                
                # Handle the mailto: link.
                return if @selectedItem.value.indexOf('mailto') is -1
                
                # Open the mailto link.
                mailto = window.open @selectedItem.value, 'mailto'
                if mailto and mailto.open and ! mailto.closed then mailto.close()

                @$el.find('#job-type').val(-1).trigger('change').trigger('liszt:updated')
            else
                @$el.siblings().find('input')
                    .filter('[type=number]').each (i, el) -> $(el).val($(el).attr('min') || 0).trigger 'change'
                @$el.siblings().find('select').not('#job-type')
                    .val(-1).trigger('liszt:updated').trigger('change')
                    .filter('[multiple]').val([]).trigger('liszt:updated').trigger('change')
                
                @$el.siblings().detach() # TODO: Make sure that detach is better than remove, and that we're not having a bunch of event handler references floating around.
                @$el.find('a.term.open').remove()
    
    JobType
