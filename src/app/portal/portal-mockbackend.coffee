# We will be using backend-less development
# $http uses $httpBackend to make its calls to the server
# $resource uses $http, so it uses $httpBackend too
# We will mock $httpBackend, capturing routes and returning data
# steve todo: rename this file back to coffee to make it active
angular.module("ngBoilerplate.portal").run ($httpBackend, ServerDataModel) ->
  $httpBackend.whenGET("/games").respond (method, url, data) ->
    games = ServerDataModel.findAll()
    [
      200
      games
      {}
    ]

  $httpBackend.whenGET(/\/games\/\d+/).respond (method, url, data) ->
    
    # parse the matching URL to pull out the id (/games/:id)
    gameid = url.split("/")[2]
    game = ServerDataModel.findOne(gameid)
    [
      200
      game
      {}
    ]

  
  # this is the creation of a new resource
  $httpBackend.whenPOST("/games").respond (method, url, data) ->
    params = angular.fromJson(data)
    game = ServerDataModel.addOne(params)
    
    # get the id of the new resource to populate the Location field
    gameid = game.gameid
    [
      201
      game
      {
        Location: "/games/" + gameid
      }
    ]

  
  # this is the update of an existing resource
  #(ngResource does not send PUT for update)
  $httpBackend.whenPOST(/\/games\/\d+/).respond (method, url, data) ->
    params = angular.fromJson(data)
    
    # parse the matching URL to pull out the id (/games/:id)
    gameid = url.split("/")[2]
    game = ServerDataModel.updateOne(gameid, params)
    [
      201
      game
      {
        Location: "/games/" + gameid
      }
    ]

  
  # this is the update of an existing resource
  #(ngResource does not send PUT for update)
  $httpBackend.whenDELETE(/\/games\/\d+/).respond (method, url, data) ->
    
    # parse the matching URL to pull out the id (/games/:id)
    gameid = url.split("/")[2]
    ServerDataModel.deleteOne gameid
    [
      204
      {}
      {}
    ]

  $httpBackend.whenGET(/templates\//).passThrough()
  return
