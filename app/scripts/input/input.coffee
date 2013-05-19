define [
    'jquery'
    'input/job-type'
    'touchable/draggable-number'
    'chosen'
], ($, JobType, DraggableNumber) ->
    class Input
        constructor: (@el) ->
            @$el = $ @el
            @jobType = new JobType();
            @jobType.$el.prependTo @$el

            @$el.on 'input change', @onChange

        onChange: (event) =>
            # console.log 'Input.onChange', event.type, event.target.id
            # if event.type is 'input'
            #   event.preventDefault()
            #   event.stopPropagation()
            #   @$el.trigger 'change'
            #   return

            # if $('.no-touch').size() < 1
            #     @$el.find('.chzn-select').each (i, el) ->
            #         $opt = $(@).find('option').first()
            #         isEmpty = $opt.text() is ''
            #         if isEmpty then $opt.text($(@).data('placeholder'))
            #         return
            # else
            #     # if $(event.target).is('#job-type') and parseInt($('#job-type').val(), 10) is -1 then @clear()
            #     @$el.find('.chzn-select').not('.chzn-done').each (i, el) ->
            #         $(el).chosen
            #             allow_single_deselect: ( !! $(el).find('option[value=-1]').size())
            #             disable_search_threshold: 20

            $('.touch .chzn-select').each (i, el) ->
                $opt = $(@).find('option').first()
                isEmpty = $opt.text() is ''
                if isEmpty then $opt.text($(@).data('placeholder'))
                return

            $('.no-touch .chzn-select').chosen
                allow_single_deselect: true
                disable_search_threshold: 20

            # logtype = (event) -> console.log event.type
            $('.touch input[type=number]')
                # .on 'touchstart touchend mousedown mouseup focus click', logtype
                .off('focus mouseup')
                .on('focus', (event) ->
                    # console.log this, event
                    # $this = $(this)
                    # select = () -> $this.select()
                    # setTimeout select, 10
                    # $this.select()
                    console.log event.type
                    this.setSelectionRange(0, 9999))
                .on('mouseup', (event) ->
                    console.log event.type
                    event.preventDefault())

            # @$el.find('input[type=number]')
            $('.no-touch input[type=number]')
                .not('.draggable-number')
                .each (i, el) -> new DraggableNumber el
            return

        clear: () ->
            @jobType.$el.find('#job-type').val(-1).trigger('liszt:updated').trigger('change')

    Input
