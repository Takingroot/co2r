
# scope: unit | amount

directive_co2_contrasted = ->
  restrict:   "E"
  transclude: on
  replace:    on
  scope:      on
  template: """
    <span class="co2-keyword co2-contrasted" popover="{content_src: 'partials/list_co2_comparisons.html', trigger: 'hover'}">{{amount | unit:amountUnit}}</span>
  """
  link: (scope, el, attrs)->

    scope.amountUnit = if \unit of attrs then scope.$eval attrs.unit else app_data.defaults.co2_per_thing_made_unit
    scope.amount     = scope.$eval attrs.amount