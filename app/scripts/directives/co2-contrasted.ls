
# scope: amountUnit / amount / popoverContentPartialPath

module.exports = (partial-path)->
  restrict:   "E"
  transclude: on
  replace:    on
  scope:      on
  template: """
    <span class="co2-keyword co2-contrasted" popover="{contentSrc: popoverContentPartialPath, trigger: 'hover'}">
      {{amount | unit:amountUnit}}
    </span>
  """
  link: (scope, el, attrs)->
    scope.popover-content-partial-path = partial-path \list-co2-comparisons
    scope.amount-unit = if \unit of attrs then scope.$eval attrs.unit else \kg
    scope.amount      = scope.$eval attrs.amount
