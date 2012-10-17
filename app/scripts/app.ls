require './services'
require './filters'
require './controllers'
require './directives'


window.CO2R = angular.module \co2r, [
  \ngSanitize
  \ui
  \co2r.services
  \co2r.filters
  \co2r.controllers
  \co2r.directives
]


CO2R.config([\$locationProvider, ($location-provider)->
  $location-provider.html5Mode on
])
require './routes'

CO2R.run ($root-scope, preferences-storage, $location, $locale, $http, partial-path, $filter)->
  $root-scope.other-language = $filter(\altLanguage)(app_data.user-language)

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

  $root-scope.partial-path = partial-path
  $root-scope.navs =
    primary: do -> _.filter nav-items, -> _.contains([\co2r \our_mission \faq], it.label)
    callout: do -> _.filter nav-items, -> _.contains([\register_your_product \other_things_you_can_do], it.label)
    footer: nav-items

  $root-scope.app_title     = "CO2R"
  $root-scope.preferences   = preferences-storage
  $root-scope.count_offsets = (co2_amount)->
    # assumes amount is given in tons
    co2_amount / app_data.calculation_variables.offsets_per_co2_ton

  # App data
  $root-scope.app_data = app_data
  $root-scope.app-text = app-text
  $root-scope.$on "$routeChangeSuccess", (e, route, previous_route)->

    # resolve homepage edgecase wherein no class info can be inferred from url
    get_url = ->
      path = $location.path!
      if path is "/" then \directory else path

    $root-scope.appCssClasses = _.union _.keys(route.pathParams), _.values(route.pathParams), _.str.cssClassify(get_url()).split(" ")

  $root-scope.e = (key)->
    app_data.expansions[key]

  $root-scope.reloadPage = -> window.location.reload!

