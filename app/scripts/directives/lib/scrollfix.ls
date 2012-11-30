co2r.directives



.directive \scrollfix, ($timeout, $window)->
  link: (scope, el, attrs)->
    scrollfix = scope.$eval attrs.scrollfix
    scrollfix.window-anchor ?= \top
    scrollfix.padding ?= 0
    # todo make part of the config object
    scrollfix-direction = \from

    if scrollfix.until?
      proxy-el = $ scrollfix.until
      scrollfix-direction = \until
    else if scrollfix.from?
      proxy-el = $ scrollfix.from
      scrollfix-direction = \from
    else
      throw 'scrollfix without from or until is undefined'

    classes =
      can-scrollfix: "can-scrollfix can-scrollfix-#{scrollfix.window-anchor}"
      is-scrollfixed: \is-scrollfixed

    el.add-class classes.can-scrollfix



    #
    # We need to update proxy-el's position on numerous occasions
    #

    # first time
    # Big, unstable, hack
    # 2 second timeout so that even on page load this
    # directive will correctly position elements
    #
    # There must be a better way to get this working
    # on page load?
    $timeout refresh-scrolled-to-state, 2000

    # page change
    scope.$root.$on \$routeChangeSuccess, ->
      # delay execution until program is idle
      $timeout refresh-scrolled-to-state, 0

    $(window).scroll refresh-scrolled-to-state
    $(window).resize refresh-scrolled-to-state


    function refresh-scrolled-to-state
      scrollfix-state = calc-scrollfix-state $($window), proxy-el
      #console.log 'scrollfix-state', scrollfix-state
      el.toggleClass classes.is-scrollfixed, scrollfix-state

    # return the element's scrollfix state
    # when window-crosses-proxy
    function calc-scrollfix-state(window-el, proxy-el)
      window-y = window-el.scrollTop! - scrollfix.padding
      if scrollfix.window-anchor is \bottom
        window-y += window-el.height!


      proxy-y  = proxy-el.offset!top

      is-window-above-proxy = window-y <= proxy-y
      #console.log 'is-window-above-proxy', is-window-above-proxy, 'window-y', window-y, 'proxy-y', proxy-y

      if is-window-above-proxy
        switch scrollfix-direction
          | \from  => off
          | \until => on
      else # window is moving upward
        switch scrollfix-direction
          | \from  => on
          | \until => off
