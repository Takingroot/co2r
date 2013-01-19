co2r.controllers.controller \faq, ($scope, co2r-api)->

  $scope.$watch \appText.faq, (new-val)->
    $scope.$root.page-title = new-val

  co2r-api.get \faqs, {cache: on}
  .then (res)->
     $scope.faqs = res.data.faqs
