co2r.controllers.controller \mission, ($scope)->

  $scope.$watch \appText.our_mission, (new-val)->
    $scope.$root.page-title = new-val

  $scope.map-options =
    # coordinates are limay in Nicaragua
    center: new google.maps.LatLng 13.1667, -86.6167
    zoom:   15
    map-type-id: google.maps.MapTypeId.ROADMAP

  $scope.$watch \treeplantingMap, (new-val)->
    #new google.maps.KmlLayer "http://thievishfilms.s3.amazonaws.com/lccp-2012-#{$scope.locale-id}.kml", map: new-val
