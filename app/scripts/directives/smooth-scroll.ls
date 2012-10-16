module.exports = ($location)->
  (scope, el, attrs)->

    el.click (e)->
      target-el = $ attrs.href
      console.log target-el
      if target-el.length
        # selector choice is to fix FF  http://stackoverflow.com/questions/8149155/animate-scrolltop-not-working-in-firefox
        $ 'body, html' .animate {scrollTop: target-el.offset!top}, \fast
