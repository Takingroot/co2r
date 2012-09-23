AppController = ($scope, preferencesStorage, $rootScope, $location)->
  #TODO depricate .data version
  $scope.$root.data        = app_data
  $scope.$root.app_data    = app_data
  $scope.$root.app_title   = "CO2R"
  $scope.$root.preferences = preferencesStorage
  $scope.$root.count_offsets = (co2_amount)->
    # assumes amount is given in tons
    co2_amount / app_data.offsets_per_co2_ton

  $scope.$root.$on "$routeChangeSuccess", (e, route, previous_route)->
    $scope.$root.appCssClasses = _.union _.keys(route.pathParams), _.values(route.pathParams), _.str.cssClassify($location.path()).split(" ")
