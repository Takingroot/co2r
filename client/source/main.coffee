CO2R = angular.module('meteorapp', ['ngSanitize', 'ui'])

config_routes()

CO2R.config(['$locationProvider', ($locationProvider)->
  $locationProvider.html5Mode(true)
])

CO2R.filter "unit", filter_unit
CO2R.filter "to_icon_name", filter_to_icon_name
CO2R.filter "slugify", filter_slugify

CO2R.directive 'spyscrollable', directive_spyscrollable
CO2R.directive 'popover',       directive_popover
CO2R.directive 'anchorable',    directive_anchorable
CO2R.directive 'tooltip',       directive_tooltip
CO2R.directive 'smoothScroll',  directive_smooth_scroll
CO2R.directive 'tab',           directive_tab
CO2R.directive 'carousel',      directive_carousel
CO2R.directive 'carouselItem',  directive_carousel_item
CO2R.directive 'co2Contrasted', directive_co2_contrasted
CO2R.directive 'timelineSlider', ->
  restrict:   "E"
  require:    "^timelineConductor"
  transclude: on
  replace:    on
  template: """
    <div class="timeline-slider-window" style='overflow:hidden'>
      <div class="timeline-slider jar align-center" ng-transclude></div>
    </div>
  """
  link: (scope, el, attrs, timeline)->
    timeline.register_slider el.children('.timeline-slider')


CO2R.directive 'timelineConductor',      ->
  restrict: "E"
  replace: on
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


    attrs.$observe 'columnCount', ->
      #console.log scope.can_move_timeline(2)
      c_index = 0
      #console.log c_index
      scope.move_timeline(c_index)
      auto_shift()


    $(window).resize ->
      # we need to apply because window resizing could potentially change whether or not we need to show navigation arrows
      scope.$apply()
      auto_shift()


    window.auto_shift = ->
      if there_is_enough_room_for_another_column()
        scope.move_timeline('+1')
        auto_shift()
        #console.log('empty width is', empty_width, ' and 1 column width is', attrs.columnWidth)
    #
    # measurement questions
    #

    window.there_is_enough_room_for_another_column = ->
      # 'if' optimization
      # if we are at the beginning of the timeline there simply are no columns to shift over
      if at_timeline_end()
        return no

      slider_width_on_left_side = ->
        (c_index+1) * attrs.columnWidth

      available_width = conductor.width() - slider_width_on_left_side()

      # tell us anser to: enough empty width for 1 column?
      available_width > attrs.columnWidth



    #
    # utilities
    #

    ###
    current_timeline_x = ->
      columns_behind_c_index = attrs.columnCount - c_index
      #console.log 'columns behind current index', columns_behind_c_index
      current_x = columns_behind_c_index * attrs.columnWidth
      current_x
    ###

    #last_column_is_viewable = ->
      #position_for_index(0) >= 0

    #get_el_for_index = (for_index)->
      #scope.slider.first().find(".timeline-item").eq((attrs.columnCount - 1) - for_index)

    last_index = ->
      attrs.columnCount - 1

    at_timeline_start = ->
      c_index is 0

    window.position_for_index = (index)->
      pos_x = -1 * (last_index() - index) * attrs.columnWidth
      #console.log 'pos_x for index', index, 'is', pos_x
      pos_x

    at_timeline_end = ->
      c_index is last_index() #or last_column_is_viewable()

    window.can_move_timeline = scope.can_move_timeline = (to_index)->

      slider_width    = scope.slider.width()
      conductor_width = conductor.width()
      if slider_width < conductor_width
        #console.log 'cannot move because slider width (', slider_width ,') is less than containing width (', conductor_width,')  (thereofe has no need to move...everythig is visible)'
        return no

      index                  = normalize_index(to_index)
      index_is_within_bounds = last_index() >= index >= 0
      #console.log 'trying to go to', to_index, index, 'in state of: current index is ', c_index, 'within a limit of 0 -', attrs.columnCount-1
      index_is_within_bounds



    #
    # actions
    #

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


    window.move_timeline = scope.move_timeline = (to_index)->
      new_index = restrict_index_to_bounds(normalize_index(to_index))
      #console.log 'move to index:', new_index
      c_index   = new_index
      scope.slider.css 'margin-left', position_for_index(new_index) || ''

      #console.log "checking if can move timeline in direction:", direction
      #console.log 'go backward', ' | x before move is: ', current_timeline_x(), ' vs after: ', new_x
      #console.log 'go forward', ' | x before move is: ', current_timeline_x(), ' vs after: ', new_x








CO2R.directive 'barChart',      ->
  restrict: "E"
  replace: on
  template: "<svg class='bar-chart'></svg>"
  link: (scope, el, attrs)->

    data  = [1, 0.5, 5.1, 4, 5, 3.2, 4.5, 3.5, 2.4, 1.1, 3.8, 6, 8, 2.2]
    chart = d3.select(el[0])
      #append("g").attr("transform","translate(10,15)")

    calc_chart_window_width = ->
      el.width()

    calc_chart_width = ->
      combined_bars_width    = data.length * bar_width
      combined_gutters_width = (data.length-1) * gutter
      combined_bars_width + combined_gutters_width

    chart_height = 100
    chart_width  = 780
    ticks_count  = 10
    gutter       = 40
    center_offset = chart.select(".chart-group")

    bar_width    = 100

    y = d3.scale.linear().
      domain([0, d3.max(data)]).
      range([0, chart_height])

    x = d3.scale.ordinal().
      domain(data).
      rangeBands([0, chart_width])

    ###
    chart.selectAll("line").data(x.ticks(ticks_count)).
      enter().append("line").
        attr("x1", x).
        attr("x2", x).
        attr("y1", 0).
        attr("y2", h).
        style("stroke","#ccc")
    ###

    chart.selectAll('rect').data(data).
      attr("height", y).
      attr("width", 100).

      enter().append('rect').
        attr("x", (d,i)-> (bar_width*i) + (gutter*i)).
        attr("y", (d,i)-> chart_height - y(d)  ).
        attr('height', y).
        attr('width', bar_width)
        #attr("y", y).
        #attr('height', y.rangeBand()).
        #attr('width', x)

    chart.selectAll(".bar-amount-label").data(data).
      enter().append("text").attr("class","bar-amount-label").
        attr("x", (d,i)-> x(d) + (gutter*i) + x.rangeBand()/2 ).
        attr("y", (d)-> chart_height).
        attr("text-anchor","middle").
        attr("dy", 20).
        attr("style","fill:black;").
        text(String)

    ###
    chart.selectAll(".rule").data(x.ticks(ticks_count)).
      enter().append("text").
        attr("class", "rule").
        attr("x", x).
        attr("y", 0).
        attr("dy", -3).
        attr("text-anchor", "middle").
        text(String)
    ###
    console.log calc_chart_width()
    console.log calc_chart_window_width()






CO2R.factory 'preferencesStorage', service_preferences_storage

#CO2R.run ($rootScope)->
  #window.$rootScope = $rootScope
