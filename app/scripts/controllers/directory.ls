co2r.controllers.controller \directory, ($scope, co2r-api, preferences-storage)->

  $scope.$root.page-title = ''

  $scope.introduction-state  = -> preferences-storage.get \showIntroduction
  $scope.toggle-introduction = ->
    preferences-storage.set \showIntroduction, !preferences-storage.get('showIntroduction')

  co2r-api.get \artifacts, {cache: yes}
  .then (res)->
    $scope.artifacts = res.data.artifacts
