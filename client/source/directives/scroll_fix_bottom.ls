directive_scroll_fix_bottom = (app)->

  app.directive \scrollFixBottom, ($timeout)->
    (scope, el, attrs)->
      class-name = \scrolled-to
      fix-el     = $ attrs.scrollFixBottom

      # We need to update fix-el's position on numerous occasions

      # first time
      refresh-scrolled-to-state!

      # page change
      scope.$root.$on \$routeChangeSuccess, ->
        # delay execution until program is idle
        $timeout refresh-scrolled-to-state, 0

      $(window).scroll refresh-scrolled-to-state
      $(window).resize refresh-scrolled-to-state


      function refresh-scrolled-to-state
        at-y     = $(window).height! + $(window).scrollTop!
        target-y = el.offset!top

        fix-el.toggleClass class-name, at-y >= target-y
