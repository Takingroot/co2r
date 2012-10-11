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

CO2R.directive \isotope, ->


  controller: ($element)->
    @items = []
    @reg = (item-el)->
      @items.push item-el
      /*
      $element.isotope \addItems, item-el
      console.log 'add item', item-el
      $element.isotope \reLayout
      */

    exec = ->
      $element.removeClass \hidden
      $element.isotope do
        layout-mode: \masonry
      #$element.isotope(\addItems, @items)

    setTimeout exec, 1500
    #setTimeout $element.isotope(\reLayout), 1500

  link: (scope, el)->

    scope.isotopeFilterByName = (name='')->
      #console.log \filter, name
      #console.log el.children "[data-name*='#name']"

      el.isotope filter: "[data-name*='#{name.toLowerCase!}']"




CO2R.directive \isotopeItem, ->
  require: \^isotope
  link: (scope, el, attrs, container-el)->
    container-el.reg el
