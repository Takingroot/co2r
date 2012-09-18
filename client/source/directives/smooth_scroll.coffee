directive_smooth_scroll = ($location)->
  (scope, el, attrs)->
    $body = $ document.body
    attrs.$observe 'href', ->
      el.click (e)->
        position_top = $(attrs.href).offset()?.top
        if position_top?
          $body.animate({scrollTop: position_top}, "fast")
          #scope.apply -> $location.hash attrs.id
          off
