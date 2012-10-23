module.exports = ($timeout)->
  (scope, el, attrs)->
    config = scope.$eval attrs.scroll-fix-bottom

    until-el  = $ config.until

    classes =
      can-scrollfix: "can-scrollfix can-scrollfix-bottom"
      is-scrollfixed: \is-scrollfixed


    el.add-class classes.can-scrollfix

    # We need to update until-el's position on numerous occasions

    # first time
    refresh-scrolled-to-state!

    # page change
    scope.$root.$on \$routeChangeSuccess, ->
      # delay execution until program is idle
      $timeout refresh-scrolled-to-state, 0

    $(window).scroll refresh-scrolled-to-state
    $(window).resize refresh-scrolled-to-state


    function refresh-scrolled-to-state
      bumper-y = until-el.offset!top
      window-y  = $(window).height! + $(window).scrollTop!

      to-state = window-y <= bumper-y

      el.toggleClass classes.is-scrollfixed, to-state
