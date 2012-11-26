co2r.directives.directive \anchorable, ($anchorScroll)->
  (scope, el, attrs)->
    attrs.$observe attrs.id, ->
      $anchorScroll!
