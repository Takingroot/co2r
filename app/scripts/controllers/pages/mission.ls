co2r.controllers.controller \mission, ($scope)->

  $scope.$watch \appText.our_mission, (new-val)->
    $scope.$root.page-title = new-val
