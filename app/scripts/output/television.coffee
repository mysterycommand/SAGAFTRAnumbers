define [
    'jquery'
], ($) ->
    class Television
        @onCameraSessionLineItems: (rates) ->
            numDays = +$('#num-days').val()

            lineItems = []

            i = 0
            while i++ < numDays
                numActors = +$("#day-#{i}-num-actors").val()
                numExtras = +$("#day-#{i}-num-extras").val()
                numActorsWardrobe = +$("#day-#{i}-actors-wardrobe").val()
                numExtrasWardrobe = 0 # +$("#day-#{i}-extras-wardrobe").val()

                j = 0
                while j++ < numActors
                    lineItem =
                        label: "Day #{i} Principal Actor #{j}"
                        first:
                            label: "Session Fee"
                            price: rates.session_actor
                        items: []

                    if j <= numActorsWardrobe then lineItem.items.push
                        count: 0
                        label: "Wardrobe Fitting"
                        price: rates.actor_wardrobe

                    lineItems.push lineItem

                j = 0
                while j++ < numExtras
                    lineItem =
                        label: "Day #{i} General Extra #{j}"
                        first:
                            label: "Session Fee (Unlimited Use)"
                            price: rates.session_extra
                        items: []

                    if j <= numExtrasWardrobe then lineItem.items.push
                        count: 0
                        label: "Wardrobe Fitting"
                        price: rates.extra_wardrobe

                    lineItems.push lineItem

            lineItems

        @offCameraSessionLineItems: (rates) ->
            numActors = +$("#num-actors").val()
            numVersions = +$('#num-versions').val()
            numTags = +$('#num-tags').val()

            tagRate = 0
            if numTags > 1  then tagRate = rates.tag_2_25
            if numTags > 25 then tagRate = rates.tag_26_50
            if numTags > 50 then tagRate = rates.tag_51

            lineItems = []

            i = 0
            while i++ < numActors
                lineItem =
                    label: "Principal Actor #{i}"
                    first:
                        label: "Session Fee"
                        price: rates.session_actor
                    items: []

                if (numVersions - 1) then lineItem.items.push
                    count: numVersions - 1
                    label: "Add'l Versions of the Script"
                    price: rates.session_actor

                # if (i is 1 and tagRate) then lineItem.items.push
                #     count: numTags - 1
                #     label: "Add'l Tags at $ #{tagRate.toFixed(2)}"
                #     price: tagRate

                lineItems.push lineItem

            if (tagRate) then lineItems.push
                label: "Tags"
                first:
                    label: "#{numTags - 1} Additional Tags at $ #{tagRate.toFixed(2)} ea."
                    price: tagRate * (numTags - 1)
                items: []

            lineItems

        @demoSessionLineItems: (rates) ->
            numActors = +$("#num-actors").val()
            numCharacters = []
            $('.num-characters').each (i, el) ->
                numCharacters[i] = +$(el).val()
                return
            numVersions = +$('#num-versions').val()

            lineItems = []

            i = 0
            while i++ < numActors
                lineItem =
                    label: "Principal Actor #{i}"
                    first:
                        label: "Session Fee"
                        price: rates.session_actor
                    items: []

                if (numCharacters[i - 1] - 1) then lineItem.items.push
                    count: numCharacters[i - 1] - 1
                    label: "Add'l Characters/Voices"
                    price: rates.session_actor

                if (numVersions - 1) then lineItem.items.push
                    count: numVersions - 1
                    label: "Add'l Versions of the Script"
                    price: rates.session_actor

                lineItems.push lineItem

            lineItems

        @onCameraUsageLineItems: (rates) ->
            numDays = +$('#num-days').val()
            numActors = 0
            numExtras = 0

            i = 0
            while i++ < numDays
                numActors += +$("#day-#{i}-num-actors").val()
                numExtras += +$("#day-#{i}-num-extras").val()

            useType = +$('#use-type').val()
            broadcastType = -1
            internetType = -1

            switch useType
                when 0 # Broadcast
                    broadcastType = +$('#broadcast-type').val()
                when 1 # Internet/New Media
                    internetType = +$('#internet-type').val()
                when 2 # Both
                    broadcastType = +$('#broadcast-type').val()
                    internetType = +$('#internet-type').val()

            lineItems = []
            lineItem =
                label: ""
                items: []

            switch broadcastType
                when 0 # Wild Spot 13
                    lineItem =
                        label: "Wild Spot - 13 week cycle"
                        items: []

                    $markets = $('#markets')
                    selected = $markets.val()
                    markets = []

                    $(selected).each (i, el) ->
                        markets[i] = $markets.find("[value=#{el}]").data 'value'
                        return



                    cities = []
                    cityRate = 0



                    chicagoIndex = markets.indexOf 'Chicago'
                    if chicagoIndex isnt -1
                        cities[cities.length] = markets.splice(chicagoIndex, 1)[0]
                        cityRate = rates.wild_13_major_chicago

                    losAngelesIndex = markets.indexOf 'Los Angeles'
                    if losAngelesIndex isnt -1
                        cities[cities.length] = markets.splice(losAngelesIndex, 1)[0]
                        cityRate = rates.wild_13_major_los_angeles

                    newYorkIndex = markets.indexOf 'New York'
                    if newYorkIndex isnt -1
                        cities[cities.length] = markets.splice(newYorkIndex, 1)[0]
                        cityRate = rates.wild_13_major_new_york

                    if cities.length is 2 then cityRate = rates.wild_13_major_any_2
                    if cities.length is 3 then cityRate = rates.wild_13_major_all_3

                    if cityRate then lineItem.items.push
                        count: 0
                        label: "#{cities.length} Major Markets (#{cities.join ', '}) for #{numActors} Principal Actor(s)"
                        price: cityRate * numActors



                    if cityRate then lineItem.items.push
                        count: numActors
                        label: "Session Fee(s) credited"
                        price: -rates.session_actor



                    numUnits = if markets.length then markets.reduce((t, s) -> t + s) else 0
                    numUnits -= 1 unless cities.length

                    unitRate = 0
                    if numUnits > 0  then unitRate = rates.wild_13_unit_2_25
                    if numUnits > 25 or cities.length then unitRate = rates.wild_13_unit_26
                    if cities.length is 3 then unitRate = rates.wild_13_major_all_3_addl

                    if numUnits and unitRate then lineItem.items.push
                        count: numUnits
                        label: "Add'l Units at $ #{unitRate.toFixed 2} ea. for #{numActors} Principal Actor(s)"
                        price: unitRate * numActors



                    if ! cityRate and ! unitRate then lineItem.items.push
                        count: 0
                        label: "Please choose broadcast markets."
                        price: 0



                when 1 # Local Cable 13
                    lineItem =
                        label: "Local Cable - 13 week cycle"
                        items: []

                    subscribers = +$('#subscribers').val()
                    subscriberRates = [
                        rates.local_1_50k
                        rates.local_50k_100k
                        rates.local_100k_150k
                        rates.local_150k_200k
                        rates.local_200k_250k
                        rates.local_250k_500k
                        rates.local_500k_750k
                        rates.local_750k_1m
                    ]
                    subscriberRate = subscriberRates[subscribers] || 0

                    if ! subscriberRate then lineItem.items.push
                        count: 0
                        label: "Please choose the number of subscribers."
                        price: 0
                    else if numActors then lineItem.items.push
                        count: numActors
                        label: "Principal Actor(s)"
                        price: subscriberRate

                    # if numExtras then lineItem.items.push
                    #     count: numExtras
                    #     label: "General Extras"
                    #     price: rates.session_extra + subscriberRate



                when 2 # National Cable 13
                    lineItem =
                        label: "National Cable - 13 week cycle"
                        items: []

                    subscribers = +$('#subscribers').val()
                    subscriberRates = [
                        rates.national_min
                        rates.national_max
                    ]
                    subscriberRate = subscriberRates[subscribers] || 0

                    if ! subscriberRate then lineItem.items.push
                        count: 0
                        label: "Please choose the number of subscribers."
                        price: 0
                    else if numActors then lineItem.items.push
                        count: numActors
                        label: "Principal Actor(s)"
                        price: subscriberRate

                    # if numExtras then lineItem.items.push
                    #     count: numExtras
                    #     label: "General Extras"
                    #     price: rates.national_min



                when 3 # Network Program
                    lineItem =
                        label: "Network Program Commercial"
                        items: []

                    numUses = +$('#num-uses').val()

                    # useRate = 0
                    # useRate = rates.network_2 if numUses is 2
                    # useRate = rates.network_3 if numUses is 3
                    # useRate = rates.network_4_13 if 3 < numUses < 14
                    # useRate = rates.network_14 if 13 < numUses
                    useRate = rates.network_2 + (rates.network_3 * (numUses - 2))

                    if useRate then lineItem.items.push
                        count: numActors
                        label: "Principal Actor(s) with #{numUses} Program Class A Use(s)"
                        price: useRate

            if broadcastType isnt -1 then lineItems.push lineItem



            switch internetType
                when 0 # 4 Week
                    lineItem =
                        label: "Internet or New Media Use"
                        items: [
                            count: numActors
                            label: "Principal Actor(s) with the 4 Week Option"
                            price: switch useType
                              when 1
                                rates.internet_4_week
                              when 2
                                rates.internet_4_week_move_over
                        ]

                when 1 # 8 Week
                    lineItem =
                        label: "Internet or New Media Use"
                        items: [
                            count: numActors
                            label: "Principal Actor(s) with the 8 Week Option"
                            price: switch useType
                              when 1
                                rates.internet_8_week
                              when 2
                                rates.internet_8_week_move_over
                        ]

                when 2 # 1 Year
                    lineItem =
                        label: "Internet or New Media Use"
                        items: [
                            count: numActors
                            label: "Principal Actor(s) with the 1 Year Option"
                            price: switch useType
                              when 1
                                rates.internet_1_year
                              when 2
                                rates.internet_1_year_move_over
                        ]

            if internetType isnt -1 then lineItems.push lineItem

            # lineItem =
            #     label: ""
            #     first:
            #         label: ""
            #         price: 0
            #     items: []

            # lineItem.items.push
            #     count: 0
            #     label: ""
            #     price: 0

            # lineItems.push lineItem

            lineItems

        @offCameraUsageLineItems: (rates) ->
            numActors = +$("#num-actors").val()

            useType = +$('#use-type').val()
            broadcastType = -1
            internetType = -1

            switch useType
                when 0 # Broadcast
                    broadcastType = +$('#broadcast-type').val()
                when 1 # Internet/New Media
                    internetType = +$('#internet-type').val()
                when 2 # Both
                    broadcastType = +$('#broadcast-type').val()
                    internetType = +$('#internet-type').val()

            lineItems = []
            lineItem =
                label: ""
                items: []

            switch broadcastType
                when 0 # Wild Spot 13
                    lineItem =
                        label: "Wild Spot - 13 week cycle"
                        items: []

                    $markets = $('#markets')
                    selected = $markets.val()
                    markets = []

                    $(selected).each (i, el) ->
                        markets[i] = $markets.find("[value=#{el}]").data 'value'
                        return



                    cities = []
                    cityRate = 0

                    chicagoIndex = markets.indexOf 'Chicago'
                    if chicagoIndex isnt -1
                        cities[cities.length] = markets.splice(chicagoIndex, 1)[0]
                        cityRate = rates.wild_13_major_chicago

                    losAngelesIndex = markets.indexOf 'Los Angeles'
                    if losAngelesIndex isnt -1
                        cities[cities.length] = markets.splice(losAngelesIndex, 1)[0]
                        cityRate = rates.wild_13_major_los_angeles

                    newYorkIndex = markets.indexOf 'New York'
                    if newYorkIndex isnt -1
                        cities[cities.length] = markets.splice(newYorkIndex, 1)[0]
                        cityRate = rates.wild_13_major_new_york

                    if cities.length is 2 then cityRate = rates.wild_13_major_any_2
                    if cities.length is 3 then cityRate = rates.wild_13_major_all_3

                    if cityRate then lineItem.items.push
                        count: 0
                        label: "#{cities.length} Major Markets (#{cities.join ', '}) for #{numActors} Principal Actor(s)"
                        price: cityRate * numActors



                    if cityRate then lineItem.items.push
                        count: numActors
                        label: "Session Fee(s) credited"
                        price: -rates.session_actor



                    numUnits = if markets.length then markets.reduce((t, s) -> t + s) else 0
                    numUnits -= 1 unless cities.length

                    unitRate = 0
                    if numUnits > 0  then unitRate = rates.wild_13_unit_2_25
                    if numUnits > 25 or cities.length then unitRate = rates.wild_13_unit_26
                    if cities.length is 3 then unitRate = rates.wild_13_major_all_3_addl

                    if numUnits and unitRate then lineItem.items.push
                        count: numUnits
                        label: "Add'l Units at $ #{unitRate.toFixed 2} ea. for #{numActors} Principal Actor(s)"
                        price: unitRate * numActors




                    if ! cityRate and ! unitRate then lineItem.items.push
                        count: 0
                        label: "Please choose broadcast markets."
                        price: 0



                when 1 # Local Cable 13
                    lineItem =
                        label: "Local Cable - 13 week cycle"
                        items: []

                    subscribers = +$('#subscribers').val()
                    subscriberRates = [
                        rates.local_1_50k
                        rates.local_50k_100k
                        rates.local_100k_150k
                        rates.local_150k_200k
                        rates.local_200k_250k
                        rates.local_250k_500k
                        rates.local_500k_750k
                        rates.local_750k_1m
                    ]
                    subscriberRate = subscriberRates[subscribers] || 0

                    if ! subscriberRate then lineItem.items.push
                        count: 0
                        label: "Please choose the number of subscribers."
                        price: 0
                    else if numActors then lineItem.items.push
                        count: numActors
                        label: "Principal Actor(s)"
                        price: subscriberRate



                when 2 # National Cable 13
                    lineItem =
                        label: "National Cable - 13 week cycle"
                        items: []

                    subscribers = +$('#subscribers').val()
                    subscriberRates = [
                        rates.national_min
                        rates.national_max
                    ]
                    subscriberRate = subscriberRates[subscribers] || 0

                    if ! subscriberRate then lineItem.items.push
                        count: 0
                        label: "Please choose the number of subscribers."
                        price: 0
                    else if numActors then lineItem.items.push
                        count: numActors
                        label: "Principal Actor(s)"
                        price: subscriberRate

                    # if numExtras then lineItem.items.push
                    #     count: numExtras
                    #     label: "General Extras"
                    #     price: rates.national_min



                when 3 # Network Program
                    lineItem =
                        label: "Network Program Commercial"
                        items: []

                    numUses = +$('#num-uses').val()

                    # useRate = 0
                    # useRate = rates.network_2 if numUses is 2
                    # useRate = rates.network_3 if numUses is 3
                    # useRate = rates.network_4_13 if 3 < numUses < 14
                    # useRate = rates.network_14 if 13 < numUses
                    useRate = rates.network_2 + (rates.network_3 * (numUses - 2))

                    if useRate then lineItem.items.push
                        count: numActors
                        label: "Principal Actor(s) with #{numUses} Program Class A Use(s)"
                        price: useRate

            if broadcastType isnt -1 then lineItems.push lineItem



            lineItem =
                label: "Internet or New Media Use"
                items: []

            switch internetType
                when 0 # 4 Week
                    lineItem.items.push
                        count: numActors
                        label: "Principal Actor(s) with the 4 Week Option"
                        price: switch useType
                          when 1
                            rates.internet_4_week
                          when 2
                            rates.internet_4_week_move_over

                when 1 # 8 Week
                    lineItem.items.push
                        count: numActors
                        label: "Principal Actor(s) with the 8 Week Option"
                        price: switch useType
                          when 1
                            rates.internet_8_week
                          when 2
                            rates.internet_8_week_move_over

                when 2 # 1 Year
                    lineItem.items.push
                        count: numActors
                        label: "Principal Actor(s) with the 1 Year Option"
                        price: switch useType
                          when 1
                            rates.internet_1_year
                          when 2
                            rates.internet_1_year_move_over

            if internetType isnt -1 then lineItems.push lineItem

            # lineItem =
            #     label: ""
            #     first:
            #         label: ""
            #         price: 0
            #     items: []

            # lineItem.items.push
            #     count: 0
            #     label: ""
            #     price: 0

            # lineItems.push lineItem

            lineItems

    Television
