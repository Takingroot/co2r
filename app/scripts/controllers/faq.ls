co2r.controllers.controller \faq, ($scope, co2r-api)->

  $scope.$watch \appText.faq, ->
    $scope.$root.page-title = $scope.app-text.faq

  co2r-api.get \faqs, {cache: on}
  .then (res)->
     $scope.faqs = res.data.faqs
