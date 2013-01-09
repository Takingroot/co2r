co2r.directives



.directive \scrollfix, ($timeout, $window)->
  scope: on
  link: (scope, element, attrs)->

    # TODO
    # - classes for window anchor?
    # - ability to use a calculation instead of an element for bumper-end

    #scroll-position = component \scroll-position
    scroll-over = component \scroll-over
    config = scope.$eval attrs.scrollfix

    # CSS hooks
    css-classes =
      can-scrollfix: \can-scrollfix
      is-scrollfix : \is-scrollfix
      # can-scrollfix-begin-window-anchor-top
      # can-scrollfix-begin-window-anchor-bottom
      # can-scrollfix-end-window-anchor-top
      # can-scrollfix-end-window-anchor-bottom

    # create css hooks
    element.add-class css-classes.can-scrollfix

    # create bumper objects
    bumper-begin = generate-bumper config.begin
    bumper-end   = generate-bumper config.end


    # bind scroll events to nodes

    if bumper-begin.element
      generate-bumper-events bumper-begin, \begin
    else
      # assume begin is 0
      toggle-scrollfix on

    if bumper-end.element
      generate-bumper-events bumper-end, \end
    else
      # do nothing, after begin, never stop



    #  @param  point    'begin' || 'end'
    #
    function generate-bumper-events(bumper, point)
      is-begin = point is \begin
      console.log bumper
      scroll-over bumper.element[0], {window-point:bumper.window-anchor}, (direction)->
        if direction is \inward
          console.log point, \scrollIn, element
          toggle-scrollfix (if is-begin then on  else off)
        else if direction is \outward
          console.log point, \scrollOut
          toggle-scrollfix (if is-begin then off else on)

      /*
      bumper-y = scroll-position bumper.element, {offset:100} #bumper.offset
      bumper-y.on \scrollIn , (e)->
        console.log point, e, \scrollIn
        toggle-scrollfix (if is-begin then on  else off)
      bumper-y.on \scrollOut, (e)->
        console.log point, e, \scrollOut
        toggle-scrollfix (if is-begin then off else on)
      */



    #  @param  to-state    <Boolean>
    #
    function toggle-scrollfix(to-state)
      element.toggle-class css-classes.is-scrollfix, to-state



    #  @param  config
    #
    #    {
    #      [begin: <CSSSelector> || <Bumper>]
    #      [end  : <CSSSelector> || <Bumper>]
    #    }
    #
    #    @Bumper  {element:<CSSSelector>, [offset:#], [window-anchor:'top' || 'botom']}
    #
    function generate-bumper(config)
      if typeof config is \object
        #console.log calc-window-anchor(config.window-anchor)
        # assume config.end.element is selector, convert to node, assign to bumper-end
        element: $(config.element)
        window-anchor: config.window-anchor or \start
      else
        # config is selector, or default
        element: if config then $(config) or null
        window-anchor: \start


    #  @param  anchor-point    'bottom' || 'top' || undefined
    #
    function calc-window-anchor(anchor-point)
      #console.log anchor-point
      switch anchor-point
      when \bottom then $(window).height!
      when \center then $(window).height / 2
      else 0 # top || anything else
