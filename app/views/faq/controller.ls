


function faq-controller(faqRes, $scope)

  $scope.$watch \appText.faq, (new-val)->
    $scope.$root.page-title = new-val

  faqs = faqRes.data.faqs

  window.faqsCtrl = $scope.faqs = faqs



co2r.controllers.controller \faq, [\faqRes, \$scope, faq-controller]
