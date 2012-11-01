nl-template =   """
    <ul class="nav nav-list" ng-transclude>
      <li ng-class="{'current-view':isCurrentView(navItem.url)}" class="nav-item {{navItem.label | slugify}}" ng-repeat="navItem in items">
        <a class="nav-link" href="{{navItem.url}}">{{textFunction({item:navItem.label})}}</a>
      </li>
    </ul>
  """

module.exports = (m)->

  m.directive \navList, ($location)->
    scope:
      items: \=
      text-function: "&"
    restrict:   \AE
    transclude: on
    replace:    on
    template: nl-template
    controller: ($scope)->
      $scope.is-current-view = (test-url)->
        #console.log test-url, $location.path!, test-url is $location.path!
        test-url is $location.path!

    link: (scope, el, attrs)->

      # noop function if no custom action defined
      scope.textFunction ?= -> it.item
