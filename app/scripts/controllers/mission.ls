co2r.controllers.controller \about, ($scope)->

  $scope.addthis-share-config =
    #todo translation
    title: "CO2R, a catalog of carbon responsible products: http://co2r.com"
    url: "http://co2r.com"
    description: \test-description

  $scope.$watch \appText.our_mission, (new-val)->
    $scope.$root.page-title = new-val

  $scope.map-options =
    # coordinates are limay in Nicaragua
    center: new google.maps.LatLng 13.1667, -86.6167
    zoom:   15
    mapTypeId: google.maps.MapTypeId.ROADMAP

  $scope.$watch \treeplantingMap, ->
    new google.maps.KmlLayer "http://thievishfilms.s3.amazonaws.com/lccp-2012-#{$scope.locale-id}.kml", map: $scope.treeplanting-map
