CO2R.directive 'chartCo2PerUnit', ->
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


CO2R.directive 'chartTotalCo2VsOffset', ->
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

CO2R.directive 'chartCo2SourcesLegend', ->
  restrict: "E"
  replace:  on
  template: "<div class='row h-gutters-2'></div>"
  #template: "<svg style='display:block' class='pie-chart'></svg>"
  link: (scope, el, attrs)->
    attrs.$observe 'data', ->
      vis_data   = scope.$eval attrs.data
      color = d3.scale.category20c()
      vis = d3.select(el[0]).data([vis_data])
      pie = d3.layout.pie().value((d,i)-> d.percent)

      vis.selectAll('.slice-label').data(pie).enter().
        append('div').
          attr('class', (d,i)-> "slice-label label-for-data-#{_.str.slugify(vis_data[i].name)}").
          text( (d,i)-> vis_data[i].name ).
          style('text-transform','capitalize').
          append('div').
            classed('pull-left', on).
            style('background-color', (d,i)-> color(i) ).
            style('width', "10px").
            style('height', "10px").
            style('margin-right', "5px").
            style('margin-top', "6px")

# Reference / thanks to
# https://gist.github.com/1203641
CO2R.directive 'chartCo2Sources', ->
  restrict: "E"
  replace:  on
  template: "<svg style='display:block;' class='pie-chart'></svg>"
  link: (scope, el, attrs)->
    attrs.$observe 'data', ->
      vis_data   = scope.$eval attrs.data

      gutter     = 80
      box_width  = scope.$eval attrs.columnWidth
      box_height = box_width

      vis_width  = box_width - gutter
      vis_height = vis_width
      vis_radius = vis_width/2

      color = d3.scale.category20c()

      vis = d3.select(el[0]).data([vis_data]).
        style('width', "#{box_width}px").style('height', "#{box_height}px").style('margin','0 auto').
        append('g').
          attr('transform',"translate(#{vis_radius + gutter/2},#{vis_radius})")

      arc = d3.svg.arc().outerRadius(vis_radius)

      pie = d3.layout.pie().value((d,i)-> d.percent)

      arcs = vis.selectAll('.slice').data(pie).
        enter().
          append('g').
          attr('class', 'slice').
          attr('class', (d,i)-> "slice-for-data-#{_.str.slugify(vis_data[i].name)}")

      arcs.append('path').
        attr('fill', (d,i)-> color(i) ).
        attr('d', arc)

      arcs.append('text').
        attr('transform',(d,i)->
          d.innerRadius = d.outerRadius = 0
          "translate(#{arc.centroid(d)})"
        ).
        attr('text-anchor', 'middle').
        # note: hide 0% values
        text( (d,i)-> vis_data[i].percent + '%' or '' ).
        style('fill', 'white')
