module.exports = (m)->
  m.directive \chartCo2PerUnit,       require './chart-co2-per-unit'
  m.directive \chartTotalCo2VsOffset, require './chart-total-co2'
  m.directive \chartCo2Sources,       require './chart-co2-sources'
  m.directive \chartCo2SourcesLegend, require './chart-co2-sources-legend'
