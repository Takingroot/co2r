co2r.directives



# scope: amountUnit | amount | popoverConfig
.directive \co2Contrasted, ($compile)->

  popover-template-string = '
    <ul class="unstyled">
      <li class="{{co2_comparison.type | slugify}}" ng-repeat="co2_comparison in appVars.co2_artifact_comparisons">
        {{co2_comparison.phrase}} {{(amount / co2_comparison.co2_amount).floor(2)}} {{co2_comparison.co2_amount_unit}}
      </li>
    </ul>
    '
  return
    restrict:   \C
    transclude: on
    replace:    on
    scope:      on
    template: """
      <span class="co2-keyword" popover="{{popoverConfig}}">
        {{amount | unit:amountUnit}}
      </span>
    """
    link: (scope, el, attrs)->
      scope.amount         = 0
      scope.popover-config = {}
      scope.amount-unit    = \kg

      attrs.$observe \amountUnit, (amount-unit-string)->
        amount-unit = scope.$eval amount-unit-string
        if amount-unit
          scope.amount-unit = amount-unit

      attrs.$observe \amount, (amount-string)->
        amount = scope.$eval amount-string
        if amount
          scope.amount = amount
          scope.popover-config =
            trigger: \hover
            contentToCompile: popover-template-string
            # Not using title
            #title:






.directive \co2, ->
  restrict: \E
  replace: yes
  template: '
    <span class="co2-keyword">
      CO<sub>2</sub>
    </span>'




.directive \co2rDefinition, ->
  replace:    on
  transclude: on
  template: '<a class="co2r-definition" popover="popoverConfig" ng-transclude></a>'
  link: (scope, el, attrs)->
    scope.popoverConfig = {}
    scope.$watch \app-vars.defined_terms, (new-defined-terms)->
      scope.popover-config = _.find new-defined-terms, -> it.term_name is el.text!




.directive \co2rBind, ($compile)->
  (scope, el, attrs)->
    # content might have html or angular directives
    scope.$watch attrs.co2r-bind, (content)->
      # if content is undefined then maybe there is an error
      # in the content within co2r-bind?
      if content?
        if content[0] is '<' and content[*-1] is '>'
          el.html $compile(content)(scope)
        else if not (_.str.include content, '<' or _.str.include content, '>')
          el.text content
        else
          if (el.prop \tagName) is \SPAN
            wrapper = $ "<span></span>"
          else
            wrapper = $ "<div></div>"
          # We have to wrap because leading/trailing text in html strings is trimmed...
          # quote: When passing HTML to jQuery(), please also note that text nodes are not treated as DOM elements. With the exception of a few methods (such as .content()), they are generally otherwise ignored or removed. E.g:
          # http://api.jquery.com/jQuery/
          wrapped-content = wrapper.html content
          el.html $compile(wrapped-content)(scope)
