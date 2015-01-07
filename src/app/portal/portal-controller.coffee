angular.module("ngBoilerplate.portal", [
  "ui.router"
]).config(config = ($stateProvider) ->
  $stateProvider.state "portal",
    url: "/portal"
    views:
      main:
        controller: "PortalCtrl"
        templateUrl: "portal/get.tpl.html"

    data:
      pageTitle: "Portal"

  return
).controller "PortalCtrl",
($scope, ResourceService, HttpService, ServerDataModel) ->
  
  # putting our server data on scope to display it for learning purposes
  $scope.dataModel = ServerDataModel
  
  # 1) Add new game form
  $scope.masterGame = date: new Date()
  $scope.reset = ->
    $scope.game = angular.copy($scope.masterGame)
    return

  $scope.saveHttp = (game) ->
    HttpService.save game
    return

  $scope.saveResource = (game) ->
    ResourceService.save game
    return

  $scope.reset()
  
  # date field display options
  $scope.opened = {}
  $scope.open = ($event, id) ->
    $event.preventDefault()
    $event.stopPropagation()
    $scope.opened[id] = true
    return

  $scope.dateOptions =
    formatYear: "yy"
    startingDay: 1

  
  # 2) Query data
  $scope.queryReset = ->
    $scope.queryResults = []
    return

  $scope.queryHttp = ->
    HttpService.query().then (response) ->
      $scope.queryResults = response.data
      return

    return

  $scope.queryResource = ->
    $scope.queryResults = ResourceService.query()
    return

  $scope.queryReset()
  
  # 3) Get single record
  $scope.getReset = ->
    $scope.getGameid = 1
    $scope.getResults = null
    return

  $scope.getHttp = (gameid) ->
    HttpService.get(gameid).then (response) ->
      $scope.getResults = response.data
      return

    return

  $scope.getResource = (gameid) ->
    $scope.getResults = ResourceService.get(gameid: gameid)
    return

  
  # 4) Update a single record
  $scope.updateReset = ->
    
    # updateGameid is used for the initial record to select
    $scope.updateGameid = 1
    
    # updateGame holds the game fetched from server using updateGameId
    $scope.updateGame = null
    
    # updateResults holds the results of query() when update has completed
    $scope.updateResults = []
    return

  $scope.updateGetResource = (gameid) ->
    $scope.updateGame = ResourceService.get(gameid: gameid)
    return

  $scope.updateHttp = (game) ->
    HttpService.save(game).then (response) ->
      
      # ignore the response, just query to pull in everything
      HttpService.query().then (queryResponse) ->
        $scope.updateResults = queryResponse.data
        return

      return

    return

  
  # because the game object was from updateGetResource(), it is already a
  # $resource object, so can just call $save on it
  $scope.updateResource = (game) ->
    $scope.updateGame.$save().then (response) ->
      $scope.updateResults = ResourceService.query()
      return

    return

  $scope.updateReset()
  
  # 5) Delete a single record
  $scope.deleteReset = ->
    
    # deleteGameid is used for the initial record to select
    $scope.deleteGameid = 1
    
    # deleteGame holds the game fetched from server using deleteGameId
    $scope.deleteGame = null
    
    # deleteResults holds the results of query() when delete has completed
    $scope.deleteResults = []
    return

  $scope.deleteGetResource = (gameid) ->
    $scope.deleteGame = ResourceService.get(gameid: gameid)
    return

  $scope.deleteHttp = (gameid) ->
    HttpService.delete_single(gameid).then (response) ->
      
      # ignore the response, just query to pull in everything
      HttpService.query().then (queryResponse) ->
        $scope.deleteResults = queryResponse.data
        return

      return

    return

  
  # because the game object was from deleteGetResource(), it is already a
  # $resource object, so can just call $delete on it
  $scope.deleteResource = (gameid) ->
    $scope.deleteGame = ResourceService.get(
      gameid: gameid
    , ->
      return  unless angular.isDefined($scope.deleteGame.gameid)
      $scope.deleteGame.$delete().then ->
        $scope.deleteResults = ResourceService.query()
        return

      return
    )
    return

  $scope.deleteReset()
  return
