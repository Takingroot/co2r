module.exports = ($filter)->
  restrict: \E
  replace:  on
  template: "<svg style='display:block' class='bar-chart'></svg>"
  link: (scope, el, attrs)->
    <- attrs.$observe \data

    box-width    = scope.$eval attrs.columnWidth
    #data         = _.invoke _.map(scope.$eval(attrs.data), (item)-> item*100), \round, 2decimals
    data         = scope.$eval(attrs.data)
    label-height = 0px
    gutter       = 140px
    bar-width    = box-width - gutter
    bar-height   = 200px
    chart-width  = data.length * box-width
    chart-height = bar-height + label-height
    y            = d3.scale.linear!domain([0, d3.max(data)]).range([0, bar-height])

    chart   = d3.select(el[0]).style(\height, chart-height).style(\width, "#{chart-width}px")
    .selectAll(\rect).data(data)

    chart.enter!append \rect
      .attr \class, \graph-bar
      .attr \x, (d,i)-> (box-width*i) + (gutter/2)
      .attr \y, (d,i)-> chart-height - y(d).round!
      .attr \height, (d)-> y(d).round!
      .attr \width, bar-width
