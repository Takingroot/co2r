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
CO2R.directive 'co2Contrasted',           ->
  restrict: "E"
  transclude: on
  replace: on
  scope:
    amount: "@"
  template: """
    <span class="aligns-middle co2-contrasted" popover="{content: '{{comparisons}}', trigger: 'hover'}">
      {{amount | unit:'kg'}}
      <i class="icon-cloud"></i>
    </span>
    """
  link: (scope, el, attrs)->

    compare_per_unit_co2 = (vs_item, subject_item)->
      (subject_item / vs_item).floor(2)

    per_unit_co2 =
      driving_car: 0.001
      eating_steak: 0.009
      flushing_toilet: 0.00005

    attrs.$observe 'amount', ->
      scope.comparisons = """
        <ul class="unstyled">
          <li>Driving #{compare_per_unit_co2(per_unit_co2.driving_car, scope.amount)}km</li>
          <li>Eating #{compare_per_unit_co2(per_unit_co2.eating_steak, scope.amount)} Steaks</li>
          <li>Flushing your toilet #{compare_per_unit_co2(per_unit_co2.flushing_toilet, scope.amount)} times</li>
        </ul>
      """

CO2R.factory 'preferencesStorage', service_preferences_storage

#CO2R.run ($rootScope)->
  #window.$rootScope = $rootScope
