# Reference / thanks to
# https://gist.github.com/1203641
co2r.directives.directive "chartCo2Sources", ->
  restrict: "E"
  replace:  on
  template: "<svg style='display:block;' class='pie-chart'></svg>"
  link: (scope, el, attrs)->
    scope.$whenReady ->
      vis_data   = scope.$eval attrs.data

      gutter     = 80
      box_width  = scope.$eval attrs.columnWidth
      box_height = box_width

      vis_width  = box_width - gutter
      vis_height = vis_width
      vis_radius = vis_width/2

      #color = d3.scale.category20c()

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
        attr('fill', (d, i)-> scope.nameColors[d.data.name] ).
        attr('d', arc)

      arcs.append('text').
        classed("pie-label", on).
        attr('transform',(d,i)->
          d.innerRadius = d.outerRadius = 0
          "translate(#{arc.centroid(d)})"
        ).
        attr('text-anchor', 'middle').
        # note: hide 0% values
        text( (d,i)->
          if 0 isnt vis_data[i].percent then (100 * vis_data[i].percent).round(1) + '%' else ''
        )
        #style('fill', 'white')
