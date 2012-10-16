module.exports = ->
  restrict: \E
  replace:  on
  template: "<svg style='display:block' class='bar-chart'></svg>"
  link: (scope, el, attrs)->
    <- attrs.$observe \data

    box-width    = scope.$eval attrs.columnWidth
    data         = _.invoke _.map(scope.$eval(attrs.data), (item)-> item*100), \round, 2decimals
    chart-height = 200px
    gutter       = 140px
    chart-width  = data.length * box-width
    bar-width    = box-width - gutter
    y            = d3.scale.linear!domain([0, d3.max(data)]).range([0, chart-height])

    chart   = d3.select(el[0]).style(\height, chart-height).style(\width, "#{chart-width}px")
    .selectAll(\rect).data(data)
    .enter!append(\rect)
      .attr(\class, "graph-bar")
      .attr(\x, (d,i)-> (box-width*i) + (gutter/2))
      .attr(\y, (d,i)-> chart-height - y(d).round!  )
      .attr(\height, (d)-> y(d).round!)
      .attr(\width, bar-width)
