co2r.directives

.directive \tooltip, ($compile)->
  (scope, el, attrs)->

    config = {}

    # TODO is this version needed at all???
    attrs.$observe \tooltipContent, ->
      config.title = attrs.tooltip-content
      el.tooltip \destroy
      el.tooltip config
      prepare-teardown!

    attrs.$observe \tooltip, (tooltip-config)->
      scope.$watch tooltip-config, (new-config)->
        config <<< scope.$eval tooltip-config
        if config.titleToCompile?
          config.title = $compile(config.titleToCompile)(scope)
        el.tooltip \destroy
        el.tooltip config
        prepare-teardown!

    function prepare-teardown
      # save a reference for teardown
      # el isn't available after $destroy
      tooltip = el.data \tooltip

      # teardown
      scope.$on \$destroy, ~>
        tooltip.destroy!
