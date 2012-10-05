AppController = ($scope, preferencesStorage, $rootScope, $location, $locale, $http)->

  nav_items =

    * label: "co2r"
      url: "directory"

    * label: "our_mission"
      url: "about"

    * label: "faq"
      url: "faq"

    * label: "register_your_product"
      url: "/register-your-product"

    * label: "other_things_you_can_do"
      url: "/other-things-you-can-do-to-help"

  $scope.navs =
    primary: do -> _.filter nav_items, (nav_item)-> _.contains(['co2r', 'our_mission', 'faq'], nav_item.label)
    callout: do -> _.filter nav_items, (nav_item)-> _.contains(['register_your_product', 'other_things_you_can_do'], nav_item.label)
    footer: nav_items

  # App data
  $scope.$root.app_data      = app_data
  $http.get('http://co2r-data-staging.herokuapp.com/api/app').success (adminable-app-data)->
    $scope.app_data <<< adminable-app-data

  $scope.$root.app_title     = "CO2R"
  $scope.$root.preferences   = preferencesStorage
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
