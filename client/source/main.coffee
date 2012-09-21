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
CO2R.directive 'timelineSlider',directive_timeline_slider
CO2R.directive 'timelineConductor',directive_timeline_conductor
report_directives(CO2R)
CO2R.directive 'barChart',      ->
  restrict: "E"
  replace: on
  template: "<svg style='display:block' class='bar-chart'></svg>"
  link: (scope, el, attrs)->
    attrs.$observe 'data', ->

      data         = _.invoke(_.map(scope.$eval(attrs.data), (item)-> item*100), 'round', 2)
      chart_height = 200
      chart_width  = data.length * attrs.columnWidth
      column_width = chart_width / data.length
      gutter       = 140
      bar_width    = column_width - gutter
      ticks_count  = 10


      y = d3.scale.linear().
        domain([0, d3.max(data)]).
        range([0, chart_height])

      x = d3.scale.ordinal().
        domain(data).
        rangeBands([0, chart_width])

      chart = d3.select(el[0]).
        style('width', chart_width).
        style('height', chart_height)
        #append("g").attr("transform","translate(10,-25)")

      ###
      chart.selectAll("line").data(x.ticks(ticks_count)).
        enter().append("line").
          attr("x1", x).
          attr("x2", x).
          attr("y1", 0).
          attr("y2", h).
          style("stroke","#ccc")
      ###

      bar_x_pos = (d, i)->
        (column_width*i) + (gutter/2)

      chart.selectAll('rect').data(data).
        attr("height", y).
        attr("width", bar_width).

        enter().append('rect').
          attr("x", bar_x_pos).
          attr("y", (d,i)-> chart_height - y(d)  ).
          attr('height', y).
          attr('width', bar_width)
          #attr("y", y).
          #attr('height', y.rangeBand()).
          #attr('width', x)

      ###
      chart.selectAll(".bar-amount-label").data(data).
        enter().append("text").attr("class","bar-amount-label").
          attr("x", (d,i)-> (column_width*i) + column_width/2 ).
          attr("y", (d)-> chart_height).
          attr("text-anchor","middle").
          attr("dy", 20).
          attr("style","fill:black;").
          text(String)
      ###


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






CO2R.factory 'preferencesStorage', service_preferences_storage

#CO2R.run ($rootScope)->
  #window.$rootScope = $rootScope
