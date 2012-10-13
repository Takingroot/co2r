
# scope: unit | amount

CO2R.directive 'co2Contrasted', ->
  restrict:   "E"
  transclude: on
  replace:    on
  scope:      on
  template: """
    <span class="co2-keyword co2-contrasted" popover="{content_src: app_data.partial-path('list_co2_comparisons'), trigger: 'hover'}">{{amount | unit:amountUnit}}</span>
  """
  link: (scope, el, attrs)->

    scope.amountUnit = if \unit of attrs then scope.$eval attrs.unit else app_data.defaults.co2_per_thing_made_unit
    scope.amount     = scope.$eval attrs.amount
