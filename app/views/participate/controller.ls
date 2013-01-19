co2r.controllers.controller \participate, ($scope, template-partial)->

  $scope.$watch \appText.participate, (new-val)->
    $scope.$root.page-title = new-val

  $scope.template-partial = template-partial

  $scope.other-things-you-can-do =
    \feedback
    \sponsor-co2r
    \recruit-company
    \spread-word

  $scope.$watch \appText.other_things_you_can_do, (nv)->
    $scope.$root.page-title = nv


window.form-feedback-controller = ($scope, $http, co2r-api)->
  $scope.default-form-values = {}

  $scope.send-form = ->

    email =
      subject: "CO2R Form - Feedback"
      message: $scope.feedback.message

    co2r-api.post 'email', {data: email}
    .success (res)->
      #console.log \success!
      $scope.feedback = angular.copy $scope.default-form-values
      $('.message-to-user-after-send').modal!
    .failure (res)->
      #console.log \failure!

