AppController = ($scope, preferencesStorage, $rootScope, $location, $locale)->
  $scope.$root.app_data    = app_data
  $scope.$root.app_title   = "CO2R"
  $scope.$root.preferences = preferencesStorage
  $scope.$root.count_offsets = (co2_amount)->
    # assumes amount is given in tons
    co2_amount / app_data.calculation_variables.offsets_per_co2_ton

  $scope.$root.$on "$routeChangeSuccess", (e, route, previous_route)->

    # resolve homepage edgecase wherein no class info can be inferred from url
    get_url = ->
      path = $location.path()
      if path is "/"
        'directory'
      else
        path

    $scope.$root.appCssClasses = _.union _.keys(route.pathParams), _.values(route.pathParams), _.str.cssClassify(get_url()).split(" ")

  $scope.$root.e = (key)->
    app_data.expansions[key]
