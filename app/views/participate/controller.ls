


co2r.controllers.controller \participate, ($scope)->

  $scope.$watch \appText.participate, (new-val)->
    $scope.$root.page-title = new-val


  $scope.$watch \appText.other_things_you_can_do, (nv)->
    $scope.$root.page-title = nv





co2r.controllers.controller \formFeedbackController, ($scope, $http, co2r-api)->
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
