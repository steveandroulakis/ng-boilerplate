angular.module("ngBoilerplate.about", [
  "ui.router"
]).controller "AboutCtrl", AboutCtrl = ($scope) ->
  
  # This is simple a demo for UI Boostrap.
  $scope.dropdownDemoItems = [
    "The first choice!"
    "And another choice for you."
    "but wait! A third!"
  ]
  return
