co2r.directive(\limayMap, [\$parse, ($parse)->
  restrict: \C
  link: (scope, element, attrs)->

    #  coordinates are limay in Nicaragua
    google-map-options  =
      center: new google.maps.LatLng 13.1667, -86.6167
      zoom:   15
      scrollwheel: false
      map-type-id: google.maps.MapTypeId.ROADMAP

    google-map = new google.maps.Map element[0], google-map-options

    kml-file-url = "http://www.takingroot.org/wp-content/uploads/LCCP_2012_en.kml"
    new google.maps.KmlLayer kml-file-url, map: google-map
])
