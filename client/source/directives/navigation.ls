CO2R.directive \navList, ->
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



jQuery.fn.combinedWidth = ->
  _.reduce this, ((seed, el)-> seed + $(el).width!), 0
