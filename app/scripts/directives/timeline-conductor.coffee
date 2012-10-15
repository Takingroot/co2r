module.exports = ->
  restrict:   "E"
  replace:    on
  transclude: on
  controller: ($scope)->
    $scope.slider = $()

    @register_slider = (new_slider)->
      #console.log 'adding new slider', new_slider, 'into', $scope.slider
      $scope.slider = $scope.slider.add(new_slider)

  template: "<div class='timeline-conductor' ng-transclude></div>"
  link: (scope, el, attrs)->

    conductor = el
    c_index   = 0
    # declare here to make available in scope
    column_count = undefined
    column_width = undefined

    attrs.$observe 'columnCount', ->
      column_count = scope.$eval attrs.columnCount
      column_width = scope.$eval attrs.columnWidth
      c_index = 0
      scope.move_timeline(c_index)

    $(window).resize ->
      # we need to apply because window resizing could potentially change whether or not we need to show navigation arrows
      scope.$apply()
      auto_shift()



    #
    # actions
    #

    window.move_timeline = scope.move_timeline = (to_index)->
      new_index = visually_restrict_index_to_conductor(restrict_index_to_bounds(normalize_index(to_index)))
      #console.log 'move to index:', new_index
      c_index   = new_index
      scope.slider.css 'margin-left', position_for_index(new_index) || ''

      #console.log "checking if can move timeline in direction:", direction
      #console.log 'go backward', ' | x before move is: ', current_timeline_x(), ' vs after: ', new_x
      #console.log 'go forward', ' | x before move is: ', current_timeline_x(), ' vs after: ', new_x


    # TODO come up with a better function name
    window.auto_shift = ->

      # 'if' optimization
      # if we are at the beginning of the timeline there simply are no columns to shift over
      if not at_timeline_end()
        scope.move_timeline("+#{enough_room_for_how_many_columns()}")


    #
    # utilities
    #

    visually_restrict_index_to_conductor = (to_index)->
      if not is_in_visual_bounds(to_index)
        most_recent_index_that_can_be_seeked()
      else
        to_index


    is_in_index_range = (to_index)->
      #console.log "trying to go to:", to_index, " which must be between or equal 0-", last_index()
      last_index() >= to_index >= 0

    is_in_visual_bounds = (to_index)->
      # the limit is the columns that conductor can fit
      # i.e. if 3, the index can never go below 3
      #console.log "trying to go to:", to_index, " which must be more than", most_recent_index_that_can_be_seeked()
      to_index >= most_recent_index_that_can_be_seeked()


    most_recent_index_that_can_be_seeked = ->
      # how many columns can the conductor fit?
      # - 1 because we are result value must be accurate in terms of array-addressable (0-based)
      re = Math.floor(conductor.width() / column_width) - 1
      #console.log("most_recent_index_that_can_be_seeked:", re)
      re




    window.enough_room_for_how_many_columns = ->
      slider_width_on_left_side = ->
        # we need to add 1 because we're interested in the _count_ of indexes up to and including current index in order to get the full width
        (c_index+1) * column_width

      available_width = conductor.width() - slider_width_on_left_side()

      enough_room_for_columns = if available_width > 0 then Math.floor(available_width / column_width) else 0
      #console.log 'enough room for', enough_room_for_columns, 'column(s)'
      enough_room_for_columns


    last_index = ->
      column_count - 1


    at_timeline_start = ->
      c_index is 0


    window.position_for_index = (index)->
      pos_x = -1 * (last_index() - index) * column_width
      #console.log 'pos_x for index', index, 'is', pos_x
      pos_x


    at_timeline_end = ->
      c_index is last_index() #or last_column_is_viewable()


    window.can_move_timeline = scope.can_move_timeline = (to_index_)->

      slider_width    = scope.slider.width()
      conductor_width = conductor.width()
      if slider_width < conductor_width
        #console.log 'cannot move because slider width (', slider_width ,') is less than containing width (', conductor_width,')  (thereofe has no need to move...everythig is visible)'
        return no

      to_index = normalize_index(to_index_)
      #console.log 'trying to go to', to_index, index, 'in state of: current index is ', c_index, 'within a limit of 0 -', column_count-1
      is_in_visual_bounds(to_index) and is_in_index_range(to_index)


    restrict_index_to_bounds = (index)->
      if index < 0
        return 0
      if index > last_index()
        return last_index()
      else
        return index


    normalize_index = (direction_)->
      if angular.isString direction_
        direction   = direction_[0]
        delta_index = parseInt(direction_.substring(1))
        #console.log 'for', direction_, 'direction is', direction, 'delta_index is', delta_index

        switch direction
          when "-"
            return c_index - delta_index
          when "+"
            return c_index + delta_index
          else
            # todo error invalid direction
      else
        # passthrough because direction is absolute
        direction_
