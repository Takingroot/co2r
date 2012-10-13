# organized by order-of-execution
$ ->
  admined-app-data <- $.getJSON('http://co2r-data-staging.herokuapp.com/api/app').success

  app_data <<< admined-app-data
  console.log app_data

  angular.bootstrap document.document-element, [\co2r]



CO2R.config([\$locationProvider, ($location-provider)->
  $location-provider.html5Mode(true)
])



CO2R.run ($root-scope, preferences-storage, $location, $locale, $http)->

  nav-items =

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

  $root-scope.navs =
    primary: do -> _.filter nav-items, (nav_item)-> _.contains(['co2r', 'our_mission', 'faq'], nav_item.label)
    callout: do -> _.filter nav-items, (nav_item)-> _.contains(['register_your_product', 'other_things_you_can_do'], nav_item.label)
    footer: nav-items

  $root-scope.app_title     = "CO2R"
  $root-scope.preferences   = preferences-storage
  $root-scope.count_offsets = (co2_amount)->
    # assumes amount is given in tons
    co2_amount / app_data.calculation_variables.offsets_per_co2_ton

  # App data
  $root-scope.app_data = app_data
  $root-scope.$on "$routeChangeSuccess", (e, route, previous_route)->

    # resolve homepage edgecase wherein no class info can be inferred from url
    get_url = ->
      path = $location.path()
      if path is "/" then 'directory' else path

    $root-scope.appCssClasses = _.union _.keys(route.pathParams), _.values(route.pathParams), _.str.cssClassify(get_url()).split(" ")

  $root-scope.e = (key)->
    app_data.expansions[key]
