module.exports = ->
  restrict: \E
  replace:  on
  template: "<svg style='display:block' class='bar-chart'></svg>"
  link: (scope, el, attrs)->

    box-width    = scope.$eval attrs.column-width
    data         = scope.$eval attrs.data
    console.log data
    chart-height = 200px
    gutter       = 200px
    chart-width  = data.total_co2.length * box-width
    bar-width    = box-width - gutter
    chart        = d3.select(el.0).style(\height, chart-height).style(\width, "#{chart-width}px")

    total-co2-y  = d3.scale.linear!
      .domain([0, d3.max(data.total_co2)])
      .range([0, chart-height])


    chart.selectAll(\.total-co2-bar).data(data.total_co2)
      .enter!append(\rect)
        .attr(\class, "total-co2-bar graph-bar")
        .attr(\x, (d,i)-> Math.round (box-width*i) + (gutter/4.5))
        .attr(\y, (d,i)-> chart-height - total-co2-y(d)  )
        .attr(\height, total-co2-y)
        .attr(\width, bar-width)


    trees-planted-y = d3.scale.linear!
      .domain([0, d3.max(data.trees-planted)])
      .range([0, chart-height])

    chart.selectAll(\.trees-planted-bar).data(data.trees-planted)
      .enter!append(\rect)
      .attr(\class, "trees-planted-bar graph-bar")
      .attr(\x, (d,i)-> Math.round (box-width*i) + (gutter) - (gutter / 4.5) )
      .attr(\y, (d,i)-> chart-height - trees-planted-y(d)  )
      .attr(\height, trees-planted-y)
      .attr(\width, bar-width)
