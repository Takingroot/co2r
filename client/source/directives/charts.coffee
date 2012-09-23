directive_bar_chart = (app)->
  app.directive 'chartCo2PerUnit', ->
    restrict: "E"
    replace:  on
    template: "<svg style='display:block' class='bar-chart'></svg>"
    link: (scope, el, attrs)->
      attrs.$observe 'data', ->

        box_width    = scope.$eval attrs.columnWidth
        data         = _.invoke(_.map(scope.$eval(attrs.data), (item)-> item*100), 'round', 2)
        chart_height = 200
        gutter       = 140
        chart_width  = data.length * box_width
        bar_width    = box_width - gutter
        y            = d3.scale.linear().domain([0, d3.max(data)]).range([0, chart_height])

        chart   = d3.select(el[0]).style('height', chart_height).style('width', chart_width).
        selectAll('rect').data(data).
          enter().append('rect').
            attr("x", (d,i)-> (box_width*i) + (gutter/2)).
            attr("y", (d,i)-> chart_height - y(d)  ).
            attr('height', y).
            attr('width', bar_width)


  app.directive 'chartTotalCo2VsOffset', ->
    restrict: "E"
    replace:  on
    template: "<svg style='display:block' class='bar-chart'></svg>"
    link: (scope, el, attrs)->
      attrs.$observe 'data', ->

        box_width    = scope.$eval attrs.columnWidth
        data         = scope.$eval(attrs.data)
        chart_height = 200
        gutter       = 200
        chart_width  = data.total_co2.length * box_width
        bar_width    = box_width - gutter
        chart        = d3.select(el[0]).style('height', chart_height).style('width', chart_width)

        total_co2_y  = d3.scale.linear().
          domain([0, d3.max(data.total_co2)]).
          range([0, chart_height])


        chart.selectAll('.total-co2-bar').data(data.total_co2).
          enter().append('rect').
            classed('total-co2-bar', on).
            attr("x", (d,i)-> (box_width*i) + (gutter/4.5)).
            attr("y", (d,i)-> chart_height - total_co2_y(d)  ).
            attr('height', total_co2_y).
            attr('width', bar_width)


        offset_co2_y = d3.scale.linear().
          domain([0, d3.max(data.offset_co2)]).
          range([0, chart_height])

        chart.selectAll('.offset-co2-bar').data(data.offset_co2).
          enter().append('rect').
            classed('offset-co2-bar', on).
            attr("x", (d,i)-> (box_width*i) + (gutter) - (gutter / 4.5) ).
            attr("y", (d,i)-> 0 ).
            attr('height', offset_co2_y).
            attr('width', bar_width)

  app.directive 'chartCo2Sources', ->
    restrict: "E"
    replace:  on
    template: "<svg style='display:block' class='pie-chart'></svg>"
    link: (scope, el, attrs)->
      attrs.$observe 'data', ->
        vis_data   = scope.$eval attrs.data

        gutter     = 80
        box_width  = scope.$eval attrs.columnWidth
        box_height = box_width

        vis_width  = box_width - gutter
        vis_height = box_height
        vis_radius = vis_width/2

        color = d3.scale.category20c()

        vis = d3.select(el[0]).data([vis_data]).
          style('width', box_width).style('height', box_height).style('margin','0 auto').
          append('g').
            attr('transform',"translate(#{vis_radius + gutter/2},#{vis_radius})")

        arc = d3.svg.arc().outerRadius(vis_radius)

        pie = d3.layout.pie().value((d,i)-> d.percentage)

        arcs = vis.selectAll('.slice').data(pie).
          enter().
            append('g').
            attr('class', 'slice').
            attr('class', (d,i)-> "slice-for-data-#{_.str.slugify(vis_data[i].label)}")

        arcs.append('path').
          attr('fill', (d,i)-> color(i) ).
          attr('d', arc)
