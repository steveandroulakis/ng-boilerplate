angular.module("ngBoilerplate").factory "ResourceService", ($resource) ->
  #$resource "http://localhost:30000/games/:gameid", #steve todo, change
  $resource "/games/:gameid", #steve todo, change
    gameid: "@gameid"
