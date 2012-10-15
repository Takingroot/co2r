module.exports = ->
  scope:
    items: \=
  restrict:   \AE
  transclude: on
  replace:    on
  template: """
    <ul class="nav" ng-transclude>
      <li class="{{navItem.label | slugify}}" ng-repeat="navItem in items">
        <a href="{{navItem.url}}">{{navItem.label | i18n}}</a>
      </li>
    </ul>
  """
