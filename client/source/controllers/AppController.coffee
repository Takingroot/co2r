AppController = ($scope, preferencesStorage, $rootScope, $location)->
  $scope.$root.app_title   = "CO2R"
  $scope.$root.preferences = preferencesStorage
  $scope.$root.$on "$routeChangeSuccess", (e, route, previous_route)->
    $scope.$root.appCssClasses = _.union _.keys(route.pathParams), _.values(route.pathParams), _.str.cssClassify($location.path()).split(" ")
