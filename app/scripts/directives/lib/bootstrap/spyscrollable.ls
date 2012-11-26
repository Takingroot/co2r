co2r.directives

.directive \spyscrollable, ($anchorScroll)->
  (scope, el, attrs)->
    attrs.$observe attrs.id, ->
      $anchorScroll!
      $ document.body .scrollspy \refresh
