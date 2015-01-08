angular.module("ngBoilerplate", [
  "ngMockE2E" # steve todo this enables/disables intercepts
  "ngResource"
  "templates-app"
  "templates-common"
  "ngBoilerplate.home"
  "ngBoilerplate.about"
  "ngBoilerplate.portal"
  "ngBoilerplate"
  "ui.router"
  "ngMaterial"
]).config( \
myAppConfig = \
($stateProvider, $urlRouterProvider, $mdThemingProvider) ->

  $mdThemingProvider.theme('light-green')

  $urlRouterProvider.otherwise "/home"
  $stateProvider.state("app",
    controller: "AppCtrl"
    templateUrl: "app.tpl.html"
  ).state("app.home",
    url: "/home"
    views:
      main:
        controller: "HomeCtrl"
        templateUrl: "home/home.tpl.html"
    data:
      pageTitle: "Home"
  ).state("app.about",
    url: "/about"
    views:
      main:
        controller: "AboutCtrl"
        templateUrl: "about/about.tpl.html"
    data:
      pageTitle: "About"
  ).state("app.portal",
    url: "/portal"
    views:
      main:
        controller: "PortalCtrl"
        templateUrl: "portal/get.tpl.html"
    data:
      pageTitle: "Portal"
  )
  return
).run(run = ->
).controller("AppCtrl", AppCtrl = \
($scope, $location, $state, $timeout, $mdSidenav, $log) ->
  $scope.$on "$stateChangeSuccess", \
  (event, toState, toParams, fromState, fromParams) ->
    $scope.pageTitle = toState.data.pageTitle \
      if angular.isDefined(toState.data.pageTitle)
    return

  $scope.states = $state.get()

  # compliments ui-sref='{{state.name}}' in tpl
  # to close navbar if mobile view
  $scope.navgo = ($name) ->
    $mdSidenav("left").close()

  $scope.toggleLeft = ->
    $mdSidenav("left").toggle().then ->
      $log.debug "toggle left is done"
      return

  $scope.close = ->
    $mdSidenav("left").close().then ->
      $log.debug "close LEFT is done"
      return

  return
)