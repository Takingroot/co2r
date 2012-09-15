directive_spyscrollable = ($anchorScroll)->
  (scope, el, attrs)->
    attrs.$observe attrs.id, ->
      $anchorScroll()
      $('body').scrollspy('refresh')
