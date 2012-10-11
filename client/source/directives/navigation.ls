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

CO2R.directive \map, ->
  (scope, el)->
    do exec = ->
      m = new google.maps.Map el[0],
        center: new google.maps.LatLng 13.1667, -86.6167
        zoom: 15
        background-color: \#FFF
        map-type-id: google.maps.MapTypeId.ROADMAP
      console.log m
      new google.maps.KmlLayer 'http://thievishfilms.s3.amazonaws.com/lccp-2012-en.kml', map: m
