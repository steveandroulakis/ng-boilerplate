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
]).config(myAppConfig = ($stateProvider, $urlRouterProvider) ->
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
).controller "AppCtrl", AppCtrl = ($scope, $location, $state) ->
  $scope.$on "$stateChangeSuccess", \
  (event, toState, toParams, fromState, fromParams) ->
    $scope.pageTitle = toState.data.pageTitle + \
    " | ngBoilerplate"  if angular.isDefined(toState.data.pageTitle)
    return

  # This is simple a demo for UI Boostrap.
  $scope.dropdownDemoItems = [
    "The first choice!"
    "And another choice for you."
    "but wait! A third!"
  ]

  $scope.states = $state.get()
  console.log($state.get())

  return
