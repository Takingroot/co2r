CO2R.directive 'tooltip', ->
  (scope, el, attrs)->
    # support variables or direct text
    config = maybe-eval attrs.tooltip
    el.tooltip if typeof config is \string then title: config else config

    # save a reference for teardown
    # el isn't available after $destroy
    tooltip = el.data \tooltip

    # teardown
    scope.$on \$destroy, ~> tooltip.destroy!

    function maybe-eval (attr-val)
      scope.$eval attr-val or attr-val
