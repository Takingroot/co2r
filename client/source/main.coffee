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
CO2R.directive 'timeline',      ($window)->
  restrict: "E"
  replace: on
  transclude: on
  template: "
    <div class='timeline-window' style='overflow:hidden'>
      <div class='timeline jar align-center' ng-transclude></div>
    </div>
  "
  link: (scope, el, attrs)->

    tl = el.children('.timeline')
    ci = 1

    #
    # measurement questions
    #
    there_is_enough_room_for_another_column = ->

      # 'if' optimization
      # if we are at the beginning of the timeline there simply are no columns to shift over
      if ci is 1
        return no

      empty_width = el.width() - remaining_timline_width_in_tl_window()

      # tell us anser to: enough empty width for 1 column?
      empty_width > attrs.columnWidth

    last_column_is_within_timeline_window = ->
      is_last_column_within_window = remaining_timline_width_in_tl_window() < el.width()
      #console.log('is last column within timeline-window?', 'remaining width is', remaining_timline_width_in_tl_window() , ' | tl-window width is', el.width(), 'therefore:', is_last_column_within_window)
      is_last_column_within_window

    remaining_timline_width_in_tl_window = ->
      remaining_columns = parseInt(attrs.columnCount) - (ci-1)
      remaining_width   = remaining_columns * parseInt(attrs.columnWidth)


    current_timeline_x = ->
      parseInt(tl.css('margin-left'))

    #
    # high-level questions
    #
    at_timeline_start = ->
      ci is 1

    at_timeline_end = ->
      ci is parseInt(attrs.columnCount) or last_column_is_within_timeline_window()

    scope.can_move_timeline = (direction)->

      #console.log 'timeline width is ', tl.width() ,'| timeline-window width is ', el.width(), 'therefore could the timeline move?', not (tl.width() < el.width())
      if tl.width() < el.width()
        return no

      #console.log 'current index is ', ci, 'within a limit of ', parseInt(attrs.columnCount)
      if direction is 'prev'
        return not at_timeline_start()

      if direction is 'next'
        return not at_timeline_end()


    #
    # actions
    #
    scope.timeline_move = (direction)->
      if direction is 'prev'
        new_x = current_timeline_x() + parseInt(attrs.columnWidth)
        #console.log 'go backward', ' | x before move is: ', current_timeline_x(), ' vs after: ', new_x
        tl.css 'margin-left', new_x || ''
        ci -= 1
      else
        new_x = current_timeline_x() - parseInt(attrs.columnWidth)
        #console.log 'go forward', ' | x before move is: ', current_timeline_x(), ' vs after: ', new_x
        tl.css 'margin-left', new_x
        ci += 1


    $(window).resize ->
      # we need to apply because window resizing could potentially change whether or not we need to show navigation arrows
      scope.$apply()
      if there_is_enough_room_for_another_column()
        scope.timeline_move('prev')
        #console.log('empty width is', empty_width, ' and 1 column width is', attrs.columnWidth)






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
