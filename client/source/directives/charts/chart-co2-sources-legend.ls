CO2R.directive \chartCo2SourcesLegend, ->
  restrict: \E
  replace:  on
  template: "<div class='row h-gutters-2'></div>"
  link: (scope, el, attrs)->
    attrs.$observe \data, ->
      vis_data = scope.$eval attrs.data
      color    = d3.scale.category20c!
      vis      = d3.select(el.0).data([vis_data])
      pie      = d3.layout.pie!value((d,i)-> d.percent)

      vis.selectAll('.slice-label').data(pie).enter!
        .append \div
          ..attr \class, (d,i)-> "row h-gutters-5 slice-label label-for-data-#{_.str.slugify vis_data[i].name}"
          ..append \div
            .style \background-color, (d,i)-> color(i)
            .style \width, \10px
            .style 'height', \10px
            .style \margin-right, \5px
            .style \margin-top, \6px
          ..append \div
            .text (d, i)-> vis_data[i].name
            .style \text-transform, \capitalize
