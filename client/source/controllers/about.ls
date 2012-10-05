controller_about = ($scope)->
  $scope.$root.page_title = "About"
  $scope.map_options =
    center: new google.maps.LatLng 35.784, -78.670
    zoom: 15
    mapTypeId: google.maps.MapTypeId.ROADMAP

