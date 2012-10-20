root = this
log = root.log
define = root.define

define [
  'jquery'
], ($) ->
  class Television
    @onCameraSessionLineItems: (rates) ->
      numDays = parseInt $('#num-days').val(), 10
      
      lineItems = []
      
      i = 0
      while i++ < numDays
        numActors = parseInt $("#day-#{i}-num-actors").val(), 10
        numExtras = parseInt $("#day-#{i}-num-extras").val(), 10
        numActorsWardrobe = parseInt $("#day-#{i}-actors-wardrobe").val(), 10
        numExtrasWardrobe = parseInt $("#day-#{i}-extras-wardrobe").val(), 10
      
        j = 0
        while j++ < numActors
          lineItem = 
            label: "Day #{i} Principal Actor #{j}"
            first:
              label: "Initial Session Fee"
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
              label: "Initial Session Fee"
              price: rates.session_extra
            items: []
        
          if j <= numExtrasWardrobe then lineItem.items.push
            count: 0
            label: "Wardrobe Fitting"
            price: rates.extra_wardrobe
        
          lineItems.push lineItem
      
      lineItems
    
    @offCameraSessionLineItems: (rates) ->
      numActors = parseInt $("#num-actors").val(), 10
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
          label: "Principal Actor #{i}"
          first:
            label: "Initial Session Fee"
            price: rates.session_actor
          items: []
        
        if (numVersions - 1) then lineItem.items.push
          count: numVersions - 1
          label: "Add'l Versions of the Script"
          price: rates.session_actor
        
        if (tagRate) then lineItem.items.push
          count: numTags - 1
          label: "Add'l Tags at $ #{tagRate.toFixed(2)}"
          price: tagRate
        
        lineItems.push lineItem
      
      lineItems
    
    @demoSessionLineItems: (rates) ->
      numActors = parseInt $("#num-actors").val(), 10
      numCharacters = []
      $('.num-characters').each (i, el) ->
        numCharacters[i] = parseInt $(el).val(), 10
      numVersions = parseInt $('#num-versions').val(), 10
      
      lineItems = []
      
      i = 0
      while i++ < numActors
        lineItem = 
          label: "Principal Actor #{i}"
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
        
        lineItems.push lineItem
      
      lineItems
    
    @usageLineItems: (rates) ->
      lineItems = []
      lineItems
  
  Television