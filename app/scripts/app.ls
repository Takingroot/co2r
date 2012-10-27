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

require './routes'

CO2R.run ($root-scope, $location, $locale, $filter, app-vars)->

  # App data
  $root-scope.app_data = app_data
  $root-scope.app-vars = app-vars

  # update app location css classes
  $root-scope.$on "$routeChangeSuccess", (e, route, previous_route)->

    # resolve homepage edgecase wherein no class info can be inferred from url
    get_url = ->
      path = $location.path!
      if path is "/" then \directory else path

    $root-scope.appCssClasses = _.union _.keys(route.pathParams), _.values(route.pathParams), _.str.cssClassify(get_url()).split(" ")

  # this is to aid in the language switcher functionality
  $root-scope.reload-page = -> window.location.reload!
  $root-scope.other-language = $filter(\altLanguage)(app_data.user-language)


  # responsive design via conditional class application
  $root-scope.w-mobile = no

  enquire.register "screen and (max-width:980px)",
    match:   ->
      #console.log \match
      $root-scope.$apply -> $root-scope.w-mobile = yes
    unmatch: ->
      #console.log \unmatch
      $root-scope.$apply -> $root-scope.w-mobile = no

  # wait until first idle, i.e after angular gets one pass-through
  # if we don't delay, the $apply above causes a bug (ng-view never loads, no error message)
  _.delay (-> enquire.listen(50)), 0
