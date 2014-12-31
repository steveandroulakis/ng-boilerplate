angular.module("ngBoilerplate", [
  "templates-app"
  "templates-common"
  "ngBoilerplate.home"
  "ngBoilerplate.about"
  "ui.router"
]).config(myAppConfig = ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise "/home"
  return
).run(run = ->
).controller "AppCtrl", AppCtrl = ($scope, $location) ->
  $scope.$on "$stateChangeSuccess", \
  (event, toState, toParams, fromState, fromParams) ->
    $scope.pageTitle = toState.data.pageTitle + \
    " | ngBoilerplate"  if angular.isDefined(toState.data.pageTitle)
    return

  return
