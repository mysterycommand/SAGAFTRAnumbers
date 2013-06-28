define [
  'jquery'
], ($) ->
  class PSA
    @radioSessionLineItems: (rates) ->
      numActors = +$('#num-actors').val()
      numSingers = +$('#num-singers').val()
      numCharacters = []
      $('.num-characters').each (i, el) ->
        numCharacters[i] = +$(el).val()
        return
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
          label: "Actor/Announcer #{i}"
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

        # if (tagRate) then lineItem.items.push
        #   count: numTags - 1
        #   label: "Add'l Tags at $ #{tagRate.toFixed(2)}"
        #   price: tagRate

        lineItems.push lineItem

      i = 0
      while i++ < numSingers
        lineItem =
          label: "Singer #{i}"
          first:
            label: "Session Fee"
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

    @tvOnCameraSessionLineItems: (rates) ->
      numDays = +$('#num-days').val()
      numVersions = +$('#num-versions').val()

      lineItems = []

      i = 0
      while i++ < numDays
        numActors = +$("#day-#{i}-num-actors").val()
        numExtras = +$("#day-#{i}-num-extras").val()
        numActorsWardrobe = +$("#day-#{i}-actors-wardrobe").val()
        numExtrasWardrobe = +$("#day-#{i}-extras-wardrobe").val()

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

          if (numVersions - 1) then lineItem.items.push
            count: numVersions - 1
            label: "Add'l Versions of the Script"
            price: rates.session_actor

          lineItems.push lineItem

        j = 0
        while j++ < numExtras
          lineItem =
            label: "Day #{i} General Extra #{j}"
            first:
              label: "Session Fee"
              price: rates.session_extra
            items: []

          if j <= numExtrasWardrobe then lineItem.items.push
            count: 0
            label: "Wardrobe Fitting"
            price: rates.extra_wardrobe

          if (numVersions - 1) then lineItem.items.push
            count: numVersions - 1
            label: "Add'l Versions of the Script"
            price: rates.session_actor

          lineItems.push lineItem

      lineItems

    @tvOffCameraSessionLineItems: (rates) ->
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

        # if (tagRate) then lineItem.items.push
        #   count: numTags - 1
        #   label: "Add'l Tags at $ #{tagRate.toFixed(2)}"
        #   price: tagRate

        lineItems.push lineItem

      if (tagRate) then lineItems.push
        label: "Tags"
        first:
          label: "#{numTags - 1} Additional Tags at $ #{tagRate.toFixed(2)} ea."
          price: tagRate * (numTags - 1)
        items: []

      lineItems

  PSA
