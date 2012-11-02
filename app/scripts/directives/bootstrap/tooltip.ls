module.exports = (m)->
  m.directive \tooltip, ->
    (scope, el, attrs)->
      config = {}

      attrs.$observe \tooltipContent, ->
        config.title = attrs.tooltip-content
        el.tooltip \destroy
        el.tooltip config

      attrs.$observe \tooltip, ->
        config <<< scope.$eval attrs.tooltip
        el.tooltip \destroy
        el.tooltip config

      # save a reference for teardown
      # el isn't available after $destroy
      tooltip = el.data \tooltip

      # teardown
      scope.$on \$destroy, ~> tooltip.destroy!
