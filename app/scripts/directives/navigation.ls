template =   """
    <ul class="nav" ng-transclude>
      <li class="{{navItem.label | slugify}}" ng-repeat="navItem in items">
        <a href="{{navItem.url}}">{{textFunction({item:navItem.label})}}</a>
      </li>
    </ul>
  """

module.exports = ->
  scope:
    items: \=
    text-function: "&"
  restrict:   \AE
  transclude: on
  replace:    on
  template: template
  link: (scope, el, attrs)->
    # pass through if no custom action defined
    scope.textFunction ?= -> it.item
