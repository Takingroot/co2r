co2r.directives



# scope: amountUnit | amount | tooltipConfig
.directive \co2Contrasted, ($compile)->

  tooltip-template-string = '
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
      <span tooltip="tooltipConfig">
        {{amount | unit:amountUnit}}
      </span>
    """
    link: (scope, el, attrs)->
      scope.amount         = 0
      scope.tooltip-config = {}
      scope.amount-unit    = \kg

      attrs.$observe \unit, (unit-string)->
        unit = scope.$eval unit-string
        if unit
          scope.amount-unit = unit

      attrs.$observe \amount, (amount-string)->
        amount = scope.$eval amount-string
        if amount
          scope.amount = amount
          scope.tooltip-config =
            trigger: \hover
            title: tooltip-template-string
            placement: \top
            classes: 'co2-contrasted-tooltip'






.directive \keyword, ->
  replace: on
  template: '
    <span style="display:inline-block"
          class="keyword keyword-{{keyword}}"
          ng-bind-html="keywordFormated"
    >
    </span>
  '
  link: (scope, el, attrs)->
    attrs.$observe \keyword, (keyword)->
      scope.keyword = keyword
      scope.keyword-formated = switch keyword
        | \co2  => 'CO<sub>2</sub>'
        | \co2r => 'CO<sub>2</sub>R'



.directive \co2rDefinition, ->
  replace:    on
  transclude: on
  template: '<a class="co2r-definition" popover="popoverConfig" ng-transclude></a>'
  link: (scope, el, attrs)->
    scope.$watch \appVars.defined_terms, (new-defined-terms)->
      # defined term objects have a title: and content: property, which satisfies the popover object structure
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
