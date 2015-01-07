angular.module("ngBoilerplate").factory "HttpService", ($http) ->
  service =
    query: ->
      $http.get "/games"

    get: (id) ->
      $http.get "/games/" + id

    
    # making save dual-function like default
    # ngResource behavior (no separate update w/PUT)
    save: (data) ->
      if angular.isDefined(data.gameid)
        $http.post "/games/" + data.gameid, data
      else
        $http.post "/games", data

    delete: (id) ->
      $http.delete_one "/games/" + id

  service
