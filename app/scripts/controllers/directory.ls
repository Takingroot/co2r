co2r.controllers.controller \directory, ($scope, co2r-api, preferences-storage)->

  $scope.$root.page-title = ''

  $scope.introduction-state  = -> preferences-storage.get \showIntroduction
  $scope.toggle-introduction = ->
    preferences-storage.set \showIntroduction, !preferences-storage.get('showIntroduction')

  $scope.action-steps =
    * title: \directory_action_title_one
      body:  \directory_action_body_one
      icon:  \leaf
      link:  "/mission"
    * title: \directory_action_title_two
      body:  \directory_action_body_two
      icon:  \edit
      link:  "/register-your-product"
    * title: \directory_action_title_three
      body:  \directory_action_body_three
      icon:  \heart
      link:  "/participate"

  co2r-api.get \artifacts, {cache: yes}
  .then (res)->
    $scope.artifacts = res.data.artifacts
