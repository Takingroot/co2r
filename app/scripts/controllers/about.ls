module.exports = ($scope)->

  $scope.addthis-share-config =
    #todo translation
    title: "CO2R, a catalog of carbon responsible products: http://co2r.com"
    url: "http://co2r.com"
    description: \test-description

  $scope.$root.page_title = "About"

  $scope.map-options =
    # coordinates are limay in Nicaragua
    center: new google.maps.LatLng 13.1667, -86.6167
    zoom:   15
    mapTypeId: google.maps.MapTypeId.ROADMAP

  $scope.$watch \treeplantingMap, ->
    new google.maps.KmlLayer app_data.urls.kml-data, map: $scope.treeplanting-map
