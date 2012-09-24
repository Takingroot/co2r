directive_co2_contrasted = ->
  restrict:   "E"
  transclude: on
  replace:    on
  scope:      on
  template: """
    <span class="co2-keyword co2-contrasted" popover="{content_src: 'partials/list_co2_comparisons.html', trigger: 'hover'}">{{amount | unit:amount_unit}}</span>
  """
  link: (scope, el, attrs)->
    # @unit
    if attrs.hasOwnProperty 'unit'
      attrs.$observe 'unit', -> scope.amount_unit = attrs.unit
    else
      scope.amount_unit = app_data.defaults.co2_per_thing_made_unit

    # @amount
    scope.amount = scope.$eval attrs.amount
