CO2R = angular.module('meteorapp', ['ngSanitize', 'ui'])

config_routes()

CO2R.config(['$locationProvider', ($locationProvider)->
  $locationProvider.html5Mode(true)
])

CO2R.filter "unit", filter_unit
CO2R.filter "to_icon_name", filter_to_icon_name
CO2R.filter "slugify", filter_to_icon_name
CO2R.directive 'spyscrollable', directive_spyscrollable
CO2R.directive 'popover',       directive_popover
CO2R.directive 'anchorable',    directive_anchorable
CO2R.directive 'tooltip',       directive_tooltip
CO2R.directive 'smoothScroll',  directive_smooth_scroll
CO2R.directive 'tab',           directive_tab
CO2R.directive 'co2Contrasted',           ($interpolate)->
  restrict: "E"
  transclude: on
  replace: on
  template: """
    <span class="aligns-middle co2-contrasted" popover="{content_src: 'partials/list_co2_comparisons.html', trigger: 'hover'}">
      {{amount | unit:amount_unit}}
      <i class="icon-cloud"></i>
    </span>
  """
  link: (scope, el, attrs)->
    # @unit
    if attrs.hasOwnProperty 'unit'
      attrs.$observe 'unit', -> scope.amount_unit = attrs.unit
    else
      scope.amount_unit = data.defaults.co2_per_unit_unit

    # @amount
    attrs.$observe 'amount', ->
      scope.amount = attrs.amount



CO2R.factory 'preferencesStorage', service_preferences_storage

#CO2R.run ($rootScope)->
  #window.$rootScope = $rootScope
