nl-template =   """
  <ul class="nav nav-list" ng-transclude>
    <li ng-class="{'current-view':isCurrentView(navItem.url)}"
    class="nav-item {{navItem.label | slugify}}"
    tooltip="{title:'Discover products that offset their carbon footprint.', placement:'bottom', classes: 'nav-item'}"
    ng-repeat="navItem in items">
      <a class="nav-link" href="{{navItem.url}}">
        <i class="icon-{{navItem.icon}}"></i> {{textFunction({item:navItem.label})}}
      </a>
    </li>
  </ul>
  """

co2r.directives.directive \navList, ($location)->
  scope:
    items: \=
    text-function: "&"
  restrict:   \AE
  transclude: on
  replace:    on
  template: nl-template
  link: (scope, el, attrs)->
    # noop function if no custom action defined
    scope.textFunction ?= -> it.item
    scope.is-current-view = (test-url)->
      #console.log test-url, $location.path!, test-url is $location.path!
      test-url is $location.path!
