// Generated by CoffeeScript 1.6.1
(function() {
  var define, log, root;

  root = this;

  log = root.log;

  define = root.define;

  define(['jquery', 'underscore'], function($, _) {
    var Radio;
    Radio = (function() {

      function Radio() {}

      Radio.sessionLineItems = function(rates) {
        var i, lineItem, lineItems, numActors, numCharacters, numSingers, numTags, numVersions, tagRate;
        numActors = parseInt($('#num-actors').val(), 10);
        numSingers = parseInt($('#num-singers').val(), 10);
        numCharacters = [];
        $('.num-characters').each(function(i, el) {
          numCharacters[i] = parseInt($(el).val(), 10);
        });
        numVersions = parseInt($('#num-versions').val(), 10);
        numTags = parseInt($('#num-tags').val(), 10);
        tagRate = 0;
        if (numTags > 1) {
          tagRate = rates.tag_2_25;
        }
        if (numTags > 25) {
          tagRate = rates.tag_26_50;
        }
        if (numTags > 50) {
          tagRate = rates.tag_51;
        }
        lineItems = [];
        i = 0;
        while (i++ < numActors) {
          lineItem = {
            label: "Actor/Announcer " + i,
            first: {
              label: "Session Fee",
              price: rates.session_actor
            },
            items: []
          };
          if (numCharacters[i - 1] - 1) {
            lineItem.items.push({
              count: numCharacters[i - 1] - 1,
              label: "Add'l Characters/Voices",
              price: rates.session_actor
            });
          }
          if (numVersions - 1) {
            lineItem.items.push({
              count: numVersions - 1,
              label: "Add'l Versions of the Script",
              price: rates.session_actor
            });
          }
          lineItems.push(lineItem);
        }
        i = 0;
        while (i++ < numSingers) {
          lineItem = {
            label: "Singer " + i,
            first: {
              label: "Session Fee",
              price: rates.session_singer
            },
            items: []
          };
          if (numVersions - 1) {
            lineItem.items.push({
              count: numVersions - 1,
              label: "Add'l Versions of the Script",
              price: rates.session_singer
            });
          }
          lineItems.push(lineItem);
        }
        if (tagRate) {
          lineItems.push({
            label: "Tags",
            first: {
              label: "" + (numTags - 1) + " Additional Tags at $ " + (tagRate.toFixed(2)) + " ea.",
              price: tagRate * (numTags - 1)
            },
            items: []
          });
        }
        return lineItems;
      };

      Radio.usageLineItems = function(rates) {
        var $markets, broadcastType, chicagoIndex, cities, cityRate, internetType, lineItem, lineItems, losAngelesIndex, markets, networkUseRate, networkUseType, newYorkIndex, numActors, numSingers, numUnits, perActorSinger, selected, unitRate, useType;
        numActors = parseInt($('#num-actors').val(), 10);
        numSingers = parseInt($('#num-singers').val(), 10);
        perActorSinger = [];
        if (numActors > 0) {
          perActorSinger.push("" + numActors + " Actor/Announcer(s)");
        }
        if (numSingers > 0) {
          perActorSinger.push("" + numSingers + " Singer(s)");
        }
        useType = parseInt($('#use-type').val(), 10);
        broadcastType = -1;
        internetType = -1;
        lineItems = [];
        lineItem = {
          label: "",
          items: []
        };
        switch (useType) {
          case 0:
            broadcastType = parseInt($('#broadcast-type').val(), 10);
            break;
          case 1:
            internetType = parseInt($('#internet-type').val(), 10);
            break;
          case 2:
            broadcastType = parseInt($('#broadcast-type').val(), 10);
            internetType = parseInt($('#internet-type').val(), 10);
        }
        switch (broadcastType) {
          case 0:
            lineItem.label = "Wild Spot (13 Week Cycle)";
            $markets = $('#markets');
            selected = $markets.val();
            markets = [];
            $(selected).each(function(i, el) {
              markets[i] = $markets.find("[value=" + el + "]").data('value');
            });
            cities = [];
            cityRate = 0;
            chicagoIndex = _.indexOf(markets, 'Chicago');
            if (chicagoIndex !== -1) {
              cities[cities.length] = markets.splice(chicagoIndex, 1)[0];
              cityRate = rates.wild_13_major_chicago;
            }
            losAngelesIndex = _.indexOf(markets, 'Los Angeles');
            if (losAngelesIndex !== -1) {
              cities[cities.length] = markets.splice(losAngelesIndex, 1)[0];
              cityRate = rates.wild_13_major_los_angeles;
            }
            newYorkIndex = _.indexOf(markets, 'New York');
            if (newYorkIndex !== -1) {
              cities[cities.length] = markets.splice(newYorkIndex, 1)[0];
              cityRate = rates.wild_13_major_new_york;
            }
            if (cities.length === 2) {
              cityRate = rates.wild_13_major_any_2;
            }
            if (cities.length === 3) {
              cityRate = rates.wild_13_major_all_3;
            }
            if (cityRate) {
              lineItem.items.push({
                count: 0,
                label: "" + cities.length + " Major Markets (" + (cities.join(', ')) + ") for " + (perActorSinger.join(' and ')),
                price: cityRate * (numActors + numSingers)
              });
            }
            numUnits = markets.length ? _.reduce(markets, function(t, s) {
              return t + s;
            }) - 1 : 0;
            unitRate = 0;
            if (numUnits > 0) {
              unitRate = rates.wild_13_unit_2_25;
            }
            if (numUnits > 25 || cities.length) {
              unitRate = rates.wild_13_unit_26;
            }
            if (numUnits && unitRate) {
              lineItem.items.push({
                count: numUnits,
                label: "Add'l Units at $ " + (unitRate.toFixed(2)) + " ea. for " + (perActorSinger.join(' and ')),
                price: unitRate * (numActors + numSingers)
              });
            } else if (cityRate) {
              if (numActors) {
                lineItem.items.push({
                  count: numActors,
                  label: "Actor/Announcer Session Fee(s) credited",
                  price: -rates.session_actor
                });
              }
              if (numSingers) {
                lineItem.items.push({
                  count: numSingers,
                  label: "Singer Session Fee(s) credited",
                  price: -rates.session_singer
                });
              }
            }
            if (!cityRate && !unitRate) {
              lineItem.items.push({
                count: 0,
                label: "Please choose broadcast markets.",
                price: 0
              });
            }
            break;
          case 1:
            lineItem.label = "Wild Spot (8 Week Cycle)";
            $markets = $('#markets');
            selected = $markets.val();
            markets = [];
            $(selected).each(function(i, el) {
              markets[i] = $markets.find("[value=" + el + "]").data('value');
            });
            cities = [];
            cityRate = 0;
            chicagoIndex = _.indexOf(markets, 'Chicago');
            if (chicagoIndex !== -1) {
              cities[cities.length] = markets.splice(chicagoIndex, 1)[0];
              cityRate = rates.wild_8_major_chicago;
            }
            losAngelesIndex = _.indexOf(markets, 'Los Angeles');
            if (losAngelesIndex !== -1) {
              cities[cities.length] = markets.splice(losAngelesIndex, 1)[0];
              cityRate = rates.wild_8_major_los_angeles;
            }
            newYorkIndex = _.indexOf(markets, 'New York');
            if (newYorkIndex !== -1) {
              cities[cities.length] = markets.splice(newYorkIndex, 1)[0];
              cityRate = rates.wild_8_major_new_york;
            }
            if (cities.length === 2) {
              cityRate = rates.wild_8_major_any_2;
            }
            if (cities.length === 3) {
              cityRate = rates.wild_8_major_all_3;
            }
            if (cityRate) {
              lineItem.items.push({
                count: 0,
                label: "" + cities.length + " Major Markets (" + (cities.join(', ')) + ") for " + (perActorSinger.join(' and ')),
                price: cityRate * (numActors + numSingers)
              });
            }
            numUnits = markets.length ? _.reduce(markets, function(t, s) {
              return t + s;
            }) - 1 : 0;
            unitRate = 0;
            if (numUnits > 0) {
              unitRate = rates.wild_8_unit_2_25;
            }
            if (numUnits > 25 || cities.length) {
              unitRate = rates.wild_8_unit_26;
            }
            if (numUnits && unitRate) {
              lineItem.items.push({
                count: numUnits,
                label: "Add'l Units at $ " + (unitRate.toFixed(2)) + " ea. for " + (perActorSinger.join(' and ')),
                price: unitRate * (numActors + numSingers)
              });
            } else if (cityRate) {
              if (numActors) {
                lineItem.items.push({
                  count: numActors,
                  label: "Actor/Announcer Session Fee(s) credited",
                  price: -rates.session_actor
                });
              }
              if (numSingers) {
                lineItem.items.push({
                  count: numSingers,
                  label: "Singer Session Fee(s) credited",
                  price: -rates.session_singer
                });
              }
            }
            if (!cityRate && !unitRate) {
              lineItem.items.push({
                count: 0,
                label: "Please choose broadcast markets.",
                price: 0
              });
            }
            break;
          case 2:
            lineItem.label = "Dealer Commercial (6 Month Use)";
            if (numActors) {
              lineItem.items.push({
                count: numActors,
                label: "Actor/Announcer(s)",
                price: rates.dealer_actor
              });
            }
            if (numSingers) {
              lineItem.items.push({
                count: numSingers,
                label: "Singer(s)",
                price: rates.dealer_singer
              });
            }
            break;
          case 3:
            lineItem.label = "Network Program Commercial (13 Week Cycle";
            networkUseType = parseInt($('#network-program-use-type').val(), 10);
            networkUseRate = 0;
            switch (networkUseType) {
              case 0:
                lineItem.label += " - 1 Week Use)";
                networkUseRate = rates.network_1;
                break;
              case 1:
                lineItem.label += " - 4 Week Use)";
                networkUseRate = rates.network_4;
                break;
              case 2:
                lineItem.label += " - 8 Week Use)";
                networkUseRate = rates.network_8;
                break;
              case 3:
                lineItem.label += " - 13 Week Use)";
                networkUseRate = rates.network_13;
                break;
              case 4:
                lineItem.label += " - 13 Week Limited Use - 26 Uses)";
                networkUseRate = rates.network_13_limited_26;
                break;
              case 5:
                lineItem.label += " - 13 Week Limited Use - 39 Uses)";
                networkUseRate = rates.network_13_limited_39;
                break;
              default:
                lineItem.label += ")";
            }
            if (!networkUseRate) {
              lineItem.items.push({
                count: 0,
                label: "Please choose network use type.",
                price: 0
              });
            } else {
              if (numActors) {
                lineItem.items.push({
                  count: numActors,
                  label: "Actor/Announcer(s)",
                  price: networkUseRate
                });
              }
              if (numSingers) {
                lineItem.items.push({
                  count: numSingers,
                  label: "Singer(s)",
                  price: networkUseRate
                });
              }
            }
            break;
          case 4:
            lineItem.label = "Regional Network Program Commercial (13 Week Use)";
            if (numActors) {
              lineItem.items.push({
                count: numActors,
                label: "Actor/Announcer(s)",
                price: rates.regional_network
              });
            }
            if (numSingers) {
              lineItem.items.push({
                count: numSingers,
                label: "Singer(s)",
                price: rates.regional_network
              });
            }
        }
        if (lineItem.items.length) {
          lineItems.push(lineItem);
        }
        lineItem = {
          label: "Internet or New Media Use",
          items: []
        };
        switch (internetType) {
          case 0:
            if (numActors || numSingers) {
              lineItem.items.push({
                count: 0,
                label: "" + (perActorSinger.join(' and ')) + " with the 8 Week Option",
                price: rates.internet_8_week * (numActors + numSingers)
              });
            }
            break;
          case 1:
            if (numActors || numSingers) {
              lineItem.items.push({
                count: 0,
                label: "" + (perActorSinger.join(' and ')) + " with the 1 Year Option",
                price: rates.internet_1_year * (numActors + numSingers)
              });
            }
        }
        if (lineItem.items.length) {
          lineItems.push(lineItem);
        }
        return lineItems;
      };

      return Radio;

    })();
    return Radio;
  });

}).call(this);
