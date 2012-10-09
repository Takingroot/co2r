CO2R.directive 'spyscrollable', ($anchorScroll)->
  (scope, el, attrs)->
    attrs.$observe attrs.id, ->
      $anchorScroll!
      $(document.body).scrollspy \refresh
