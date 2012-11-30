co2r.directives.directive \timelineSliderWindow, ->
  restrict:   \C
  require:    \^timelineConductor
  transclude: on
  replace:    on
  scope:      on
  template: '
    <div>
      <div class="timeline-slider align-center" style="position:relative;" ng-transclude></div>
    </div>
  '
  link: (scope, el, attrs, conductor)->
    #console.log 'register a slider', el
    conductor.register-slider el.children \.timeline-slider



co2r.directives.directive \timelineConductor, ($window)->
  restrict:   \C
  scope:      on
  controller: ($scope, $element)->
    $scope.slider = $!
    #$scope.sliders = []

    @register-slider = (new-slider-el)->
      $scope.slider = $scope.slider.add new-slider-el
      #console.log 'adding new slider', new-slider-el, 'into', $scope.slider
      #$scope.sliders.push new-slider-el

  link: (scope, el, attrs)->
    conductor    = el
    # declare here to make available in function scope
    c-index      = null
    column-count = null
    column-width = null

    # privately (for now) configurable settings
    settings =
      center-slider-on-current-column: yes

    init = ->
      column-count := scope.$eval attrs.column-count
      column-width := scope.$eval attrs.column-width

      scope.move-timeline column-count
      fit-timeline-toward-first!

    scope.$watch \slider, (new-slider)->
      refresh-timeline-position!

    $($window).resize ->
      # we need to apply because window resizing could potentially change whether or not we need to show navigation arrows
      scope.$apply!
      refresh-timeline-position!



    scope.move-timeline = (to-column)->
      new-index = keep-index-within-column-range  column-to-index  to-column
      #console.log 'move to index:', new-index
      c-index   := new-index
      refresh-timeline-position!



    /*
     * Ask if timeline
     * 1. can move at all
     * 2. can move to argument x position
    */
    scope.can-move-timeline = (to-column)->
      if not slider-fits-within-conductor!
        if to-column?
          # the slider might be able to move to the specified index
          #console.log 'trying to go to', to-index, 'in state of: current index is ', c-index, 'within a limit of 0 -', column-count-1
          to-index = column-to-index to-column
          can-move-slider-to-index = (to-index isnt c-index) and index-is-within-column-range(to-index)

          #console.log 'slider can move to index', to-index, '?', can-move-slider-to-index
          can-move-slider-to-index
        else
          # the slider can generally move
          #console.log 'slider can generally move'
          yes
      else
        # logically the slider does not have to move (and cannot move) if it fits the container
        #console.log 'cannot move because slider width is less than conductor width'
        no

    scope.$when-ready init



    function refresh-timeline-position
      base-xpos   = if slider-fits-within-conductor! then 0 else index-to-xpos(c-index)
      offset-xpos = if not settings.center-slider-on-current-column  then 0 else calc-timeline-centering-offset!
      final-xpos  = base-xpos + offset-xpos
      #console.log scope.slider, base-xpos, offset-xpos, final-xpos
      scope.slider.css \left, final-xpos

    # move the timeline as far back toward first column as possible
    # without making last column move beyond right

    function calc-timeline-centering-offset
      conductor-width = conductor.width!
      slider-width    = calc-slider-width!
      if slider-width < conductor-width then return 0
      (conductor-width - column-width) / 2


    function fit-timeline-toward-first
      empty-column-count = count-empty-columns!
      if false and empty-column-count > 0
        scope.move-timeline "-#{empty-column-count}"


    /*
     * introspect slider space dynamics
    */

    # NOTE: this can return a negative value! : TODO is that error-prone?
    function calc-slider-width-beyond-screen-right(against-a-c-index-of=c-index)
      items-right-width                = count-items-right(against-a-c-index-of) * column-width
      slider-width-beyond-screen-right = items-right-width - conductor.width!
      #console.log 'against-a-c-index-of:', against-a-c-index-of, '| calc-slider-width-beyond-screen-right', slider-width-beyond-screen-right, ' | items-right-width', items-right-width, ' | conductor.width', conductor.width!
      slider-width-beyond-screen-right

    function visible-empty-space
      empty-space = -1 * calc-slider-width-beyond-screen-right!
      # negative space don't make sense, "empty space" is 0 or more
      empty-space = 0 if empty-space < 0
      #console.log 'empty-space:', empty-space
      empty-space



    /*
     * introspect column and item counts
    */

    function count-empty-columns
      # how many items can visibly fit in the conductor at once
      # take into account that centering on current column alters the available empty columns
      sub-divide-conductor = if settings.center-slider-on-current-column then 2 else 1
      visible-columns = Math.floor((conductor.width! / sub-divide-conductor) / column-width)

      # how many ore items could fit on the screen?
      empty-columns = visible-columns - count-items-right!
      # negative values don't make sense, "items that can fit" is 0 or more
      empty-columns = 0 if empty-columns < 0
      #console.log 'empty columns:', empty-columns, ' | visible-columns:', visible-columns, ' | items-right:', count-items-right!, ' | c-index: ', c-index, ' | column-count:', column-count
      empty-columns

    # how many items are on the screen's left edge (or "beyond" the screen, from its right-edge onward)
    # @param against-a-c-index-of
    #   - allows us to count items-right for an index other than current
    function count-items-right(against-a-c-index-of=c-index)
      # c-index represents how many items are @left of screen
      items-left  = against-a-c-index-of
      items-right = column-count - items-left















    function slider-fits-within-conductor
      return no if not scope.slider.length
      conductor-width = conductor.width!
      #if not angular.isNumber slider-width then throw "slider-width is not a number, #{slider-width}"
      #if not angular.isNumber conductor-width then throw "conductor-width is not a number, #{conductor-width}"
      #console.log 'slider-width', slider-width, 'vs', conductor-width, 'conductor-width'
      calc-slider-width! < conductor-width



    /*
     * logic for column bounds
    */

    function index-is-within-column-range(to-index)
      #console.log "trying index:", to-index, " which must be within (or equal) 0-", last-index!
      last-index! >= to-index >= 0

    function keep-index-within-column-range(index)
      if      index < 0           then 0
      else if index > last-index! then last-index!
      else                        then index





    /*
     * index transformations
    */

    function index-to-xpos(index)
      xpos = -1 * (index * column-width)
      #console.log "#index * #column-width = ", 'xpos', xpos
      xpos


    function column-to-index(column)
      if typeof column is \number
        return column - 1
      else
        return relative-to-absolute column


      function relative-to-absolute(relative-number)
        # passthrough because direction is absolute (1,2,3,..etc) not relative '+1', '-2', etc
        #return direction_ if typeof direction_ isnt \string

        # + or -
        direction = relative-number.0
        number    = parseInt relative-number.substring 1
        #console.log 'for', direction_, 'direction is', direction, 'delta-index is', delta-index

        switch direction
          when \- then return c-index - number
          when \+ then return c-index + number
          else         throw "The given direction #direction is not allowed (must be '-' or '+')"





    function last-index
      column-count - 1

    function calc-slider-width
      column-count * column-width
