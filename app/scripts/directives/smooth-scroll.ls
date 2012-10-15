module.exports = ($location)->
  (scope, el, attrs)->
    $body = $ document.body
    attrs.$observe \href, ->
      el.click (e)->
        y-pos = $(attrs.href).offset!?top
        if y-pos?
          $body.animate {scrollTop: y-pos}, \fast
          #scope.apply -> $location.hash attrs.id
          off
