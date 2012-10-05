directive_scroll_fix_bottom = (app)->
  app.directive 'scrollFixBottom', ($timeout)->
    (scope, el, attrs)->

      class_name = 'scrolled-to'
      fix_el     = $(attrs.scrollFixBottom)

      refresh_scrolled_to_state = ->
        at_y     = $(window).height() + $(window).scrollTop()
        target_y = el.offset().top

        if at_y >= target_y
          fix_el.addClass class_name
        else
          fix_el.removeClass class_name

      refresh_scrolled_to_state()
      scope.$root.$on "$routeChangeSuccess", ->
        $timeout ( -> refresh_scrolled_to_state() ), 100

      $(window).scroll refresh_scrolled_to_state
      $(window).resize refresh_scrolled_to_state
