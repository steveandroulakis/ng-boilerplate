angular.module("ngBoilerplate").service "ServerDataModel", ServerDataModel = ->
  @data = [
    {
      gameid: 1
      opponent: "Tech"
      date: new Date(2014, 4, 7)
      attendance: 2038
    }
    {
      gameid: 2
      opponent: "State"
      date: new Date(2014, 4, 13)
      attendance: 1655
    }
    {
      gameid: 3
      opponent: "College"
      date: new Date(2014, 4, 20)
      attendance: 1897
    }
  ]
  @getData = ->
    @data

  @setData = (data) ->
    @data = data
    return

  @findOne = (gameid) ->
    # find the game that matches that id
    list = $.grep(@getData(), (element, index) ->
      element.gameid is parseInt(gameid)
    )
    return {}  if list.length is 0
    
    # even if list contains multiple items, just return first one
    list[0]

  @findAll = ->
    @getData()

  
  # options parameter is an object with key value pairs
  # in this simple implementation, value is limited to
  # a single value (no arrays)
  @findMany = (options) ->
    
    # find games that match all of the options
    list = $.grep(@getData(), (element, index) ->
      matchAll = true
      $.each options, (optionKey, optionValue) ->
        unless element[optionKey] is optionValue
          matchAll = false
          false

      matchAll
    )
    return

  
  # add a new data item that does not exist already
  # must compute a new unique id and backfill in
  @addOne = (dataItem) ->
    
    # must calculate a unique ID to add the new data
    newId = @newId()
    dataItem.gameid = newId
    @data.push dataItem
    dataItem

  
  # return an id to insert a new data item at
  @newId = ->
    
    # find all current ids
    currentIds = $.map(@getData(), (dataItem) ->
      dataItem.gameid
    )
    
    # since id is numeric, and we will treat like an
    # autoincrement field, find max
    maxId = Math.max.apply(Math, currentIds)
    
    # increment by one
    maxId + 1

  @updateOne = (gameid, dataItem) ->
    
    # find the game that matches that id
    games = @getData()
    match = null
    i = 0

    while i < games.length
      if games[i].gameid is parseInt(gameid)
        match = games[i]
        break
      i++
    return {}  unless angular.isObject(match)
    angular.extend match, dataItem
    match

  @deleteOne = (gameid) ->
    
    # find the game that matches that id
    games = @getData()
    match = false
    i = 0

    while i < games.length
      if games[i].gameid is parseInt(gameid)
        match = true
        games.splice i, 1
        break
      i++
    match

  return
