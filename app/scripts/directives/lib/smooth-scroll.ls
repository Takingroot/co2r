co2r.directives

#
#  What this directive does:
#
#  When a page anchor link is clicked
#  animate the vertical scrollbar to that location,
#  instead of the browser default which is too jump
#
#  Options
#
#  smooth-scroll attribute can receive animation options
#  object, docs: http://dochub.io/#jquery/animate
#
.directive \smoothScroll, ($location)->
  scope: on
  link: (scope, element, attrs)->

    scope.$watch attrs.smooth-scroll, (animation-config)->
      scope.animation-config = animation-config or {}
      # default options
      scope.animation-config.duration ?= 500
      scope.animation-config.easing   ?= \easeOutExpo
    , true

    element.click ->
      link-target-element = $ attrs.href
      if link-target-element.length
        # selector choice is to fix FF  http://stackoverflow.com/questions/8149155/animate-scrolltop-not-working-in-firefox
        $ 'body, html' .stop!animate {scrollTop: link-target-element.offset!top}, scope.animation-config
