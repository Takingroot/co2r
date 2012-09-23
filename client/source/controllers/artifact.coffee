controller_artifact = ($scope, $routeParams)->
  $scope.artifact       = _.find artifacts, (artifact)-> artifact.slug is $routeParams.artifact
  $scope.column_width   = 300
  $scope.timeline_width = $scope.column_width * $scope.artifact.reports.length
  $scope.calc_trees_planted = (offset_co2, year)->
    trees_planted = $scope.count_offsets(offset_co2) * app_data.trees_per_offset[year]
    Math.floor trees_planted


  $scope.data =
    co2_sources:  _.pluck($scope.artifact.reports, "co2_sources")
    co2_per_unit: _.sortBy(_.pluck($scope.artifact.reports, "co2_per_unit"), (item)-> -1*item)
    total_co2_vs_offset:
      total_co2: _.pluck($scope.artifact.reports, "total_co2")
      offset_co2: _.pluck($scope.artifact.reports, "offset_co2")
