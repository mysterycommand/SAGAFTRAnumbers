root = this
log = root.log
define = root.define

define [
  'jquery'
], ($) ->
  class Radio
  	@sessionLineItems: (rates) ->
      numActors = parseInt $('#num-actors').val(), 10
      numSingers = parseInt $('#num-singers').val(), 10
      numCharacters = []
      $('.num-characters').each (i, el) ->
        numCharacters[i] = parseInt $(el).val(), 10
      numVersions = parseInt $('#num-versions').val(), 10
      numTags = parseInt $('#num-tags').val(), 10

      tagRate = 0
      if numTags > 1  then tagRate = rates.tag_2_25
      if numTags > 25 then tagRate = rates.tag_26_50
      if numTags > 50 then tagRate = rates.tag_51

      lineItems = []
      
      i = 0
      while i++ < numActors
        lineItem = 
          label: "Actor/Announcer #{i}"
          first:
            label: "Initial Session Fee"
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
        
        # if (i is 1 and tagRate) then lineItem.items.push
        #   count: numTags - 1
        #   label: "Add'l Tags at $ #{tagRate.toFixed(2)}"
        #   price: tagRate
        
        lineItems.push lineItem
      
      i = 0
      while i++ < numSingers
        lineItem = 
          label: "Singer #{i}"
          first:
            label: "Initial Session Fee"
            price: rates.session_singer
          items: []
        
        if (numVersions - 1) then lineItem.items.push
          count: numVersions - 1
          label: "Add'l Versions of the Script"
          price: rates.session_singer
        
        lineItems.push lineItem

      if (tagRate) then lineItems.push
        label: "Tags"
        first:
          label: "#{numTags - 1} Additional Tags at $ #{tagRate.toFixed(2)} ea."
          price: tagRate * (numTags - 1)
        items: []
      
      lineItems
    
  	@usageLineItems: (rates) ->
      numActors = parseInt $('#num-actors').val(), 10
      numSingers = parseInt $('#num-singers').val(), 10
      
      useType = parseInt $('#use-type').val(), 10
      broadcastType = -1
      internetType = -1
      
      lineItems = []
      lineItem = 
        label: ""
        items: []
      
      switch useType
        when 0 # Broadcast
          broadcastType = parseInt $('#broadcast-type').val(), 10
        when 1 # Internet/New Media
          internetType = parseInt $('#internet-type').val(), 10
        when 2 # Both
          broadcastType = parseInt $('#broadcast-type').val(), 10
          internetType = parseInt $('#internet-type').val(), 10
      
      switch broadcastType
        when 0 # Wild 13
          lineItem.label = "Wild Spot (13 Week Cycle)"
          
          $markets = $('#markets')
          selected = $markets.val()
          markets = []
          
          $(selected).each (i, el) -> markets[i] = $markets.find("[value=#{el}]").data 'value'
          
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
          
          numUnits = if markets.length then markets.reduce((t, s) -> t + s) - 1 else 0
          
          unitRate = 0
          if numUnits > 1  then unitRate = rates.wild_13_unit_2_25
          if numUnits > 25 or cities.length then unitRate = rates.wild_13_unit_26
          
          if cityRate then lineItem.items.push
            count: cities.length
            label: "Major Markets (#{cities.join ', '})"
            price: cityRate
          
          if unitRate then lineItem.items.push
            count: numUnits
            label: "Add'l Units at $ #{unitRate.toFixed 2}"
            price: unitRate
          
          if ! cityRate and ! unitRate then lineItem.items.push
            count: 0
            label: "Please choose broadcast markets."
            price: 0
        
        
        when 1 # Wild 8
          lineItem.label = "Wild Spot (8 Week Cycle)"
          
          $markets = $('#markets')
          selected = $markets.val()
          markets = []
          
          $(selected).each (i, el) -> markets[i] = $markets.find("[value=#{el}]").data 'value'
          
          cities = []
          cityRate = 0
          
          chicagoIndex = markets.indexOf 'Chicago'
          if chicagoIndex isnt -1
            cities[cities.length] = markets.splice(chicagoIndex, 1)[0]
            cityRate = rates.wild_8_major_chicago
          
          losAngelesIndex = markets.indexOf 'Los Angeles'
          if losAngelesIndex isnt -1
            cities[cities.length] = markets.splice(losAngelesIndex, 1)[0]
            cityRate = rates.wild_8_major_los_angeles
          
          newYorkIndex = markets.indexOf 'New York'
          if newYorkIndex isnt -1
            cities[cities.length] = markets.splice(newYorkIndex, 1)[0]
            cityRate = rates.wild_8_major_new_york
          
          if cities.length is 2 then cityRate = rates.wild_8_major_any_2
          if cities.length is 3 then cityRate = rates.wild_8_major_all_3
          
          numUnits = if markets.length then markets.reduce((t, s) -> t + s) else 0
          unitRate = 0
          if numUnits > 1  then unitRate = rates.wild_8_unit_2_25
          if numUnits > 25 or cities.length then unitRate = rates.wild_8_unit_26
          
          if cityRate then lineItem.items.push
            count: cities.length
            label: "Major Markets (#{cities.join ', '})"
            price: cityRate
          
          if unitRate then lineItem.items.push
            count: numUnits
            label: "Add'l Units at $ #{unitRate.toFixed 2}"
            price: unitRate
          
          if ! cityRate and ! unitRate then lineItem.items.push
            count: 0
            label: "Please choose broadcast markets."
            price: 0
        
        
        when 2 # Dealer
          lineItem.label = "Dealer Commercial (6 Month Use)"
          
          if (numActors) then lineItem.items.push
            count: numActors
            label: "Actor/Announcer(s)"
            price: rates.dealer_actor
          
          if (numSingers) then lineItem.items.push
            count: numSingers
            label: "Singer(s)"
            price: rates.dealer_singer
        
        
        when 3 # Network
          lineItem.label = "Network Program Commercial (13 Week Cycle"
          
          networkUseType = parseInt $('#network-program-use-type').val(), 10
          networkUseRate = 0
          
          switch networkUseType
            when 0 # 1 Week
              lineItem.label += " - 1 Week Use)"
              networkUseRate = rates.network_1
            when 1 # 4 Week
              lineItem.label += " - 4 Week Use)"
              networkUseRate = rates.network_4
            when 2 # 8 Week
              lineItem.label += " - 8 Week Use)"
              networkUseRate = rates.network_8
            when 3 # 13 Week
              lineItem.label += " - 13 Week Use)"
              networkUseRate = rates.network_13
            when 4 # 13 Week Limited 26
              lineItem.label += " - 13 Week Limited Use - 26 Uses)"
              networkUseRate = rates.network_13_limited_26
            when 5 # 13 Week Limited 39
              lineItem.label += " - 13 Week Limited Use - 39 Uses)"
              networkUseRate = rates.network_13_limited_39
            else
              lineItem.label += ")"
          
          if ( ! networkUseRate)
            lineItem.items.push
              count: 0
              label: "Please choose network use type."
              price: 0
          else
            if (numActors) then lineItem.items.push
              count: numActors
              label: "Actor/Announcer(s)"
              price: networkUseRate
          
            if (numSingers) then lineItem.items.push
              count: numSingers
              label: "Singer(s)"
              price: networkUseRate
        
        
        when 4 # Regional
          lineItem.label = "Regional Network Program Commercial (13 Week Use)"
          
          if (numActors) then lineItem.items.push
            count: numActors
            label: "Actor/Announcer(s)"
            price: rates.regional_network
          
          if (numSingers) then lineItem.items.push
            count: numSingers
            label: "Singer(s)"
            price: rates.regional_network
      
      if lineItem.items.length then lineItems.push lineItem
      
      lineItem = 
        label: "Internet or New Media Use"
        items: []
      
      switch internetType
        when 0
          lineItem.items.push
            count: 0
            label: "8 Week Option"
            price: rates.internet_8_week
        when 1
          lineItem.items.push
            count: 0
            label: "1 Year Option"
            price: rates.internet_1_year
      
      if lineItem.items.length then lineItems.push lineItem
      
      lineItems
  
  Radio
