/*
template = '
<ul class="unstyled">
  <li ng-repeat="co2Comparison in appVars.co2_artifact_comparisons">
    {{co2Comparison.phrase}}
    {{(amount / co2Comparison.co2_amount).floor(2)}} {{co2Comparison.co2_amount_unit}}
  </li>
</ul>'
*/

# scope: amountUnit | amount | popoverConfig

module.exports = (partial-path)->
  restrict:   "C"
  transclude: on
  replace:    on
  scope:      on
  template: """
    <span
      class="co2-keyword"
      popover="popoverConfig"
      ng-bind="amount | unit:amountUnit">
    </span>
  """
  link: (scope, el, attrs)->
    scope.amount      = undefined
    scope.amount-unit = if \unit of attrs then scope.$eval attrs.unit else \kg
    scope.popover-config =
      trigger: \hover
      content-src: partial-path \list-co2-comparisons

    attrs.$observe \amount, (new-amount)->
      scope.amount = parseFloat new-amount
