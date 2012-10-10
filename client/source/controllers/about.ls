controller_about = ($scope)->
  $scope.$root.page_title = "About"
  $scope.map_options =
    # coordinates are limay in Nicaragua
    center: new google.maps.LatLng 13.1667, -86.6167
    zoom: 15
    mapTypeId: google.maps.MapTypeId.ROADMAP

