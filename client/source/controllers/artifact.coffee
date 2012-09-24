controller_artifact = ($scope, $routeParams)->
  $scope.artifact       = _.find artifacts, (artifact)-> artifact.slug is $routeParams.artifact
  $scope.reports        = _.sortBy($scope.artifact.reports, (item)-> item.year)
  $scope.column_width   = 300
  $scope.timeline_width = $scope.column_width * $scope.artifact.reports.length
  $scope.calc_trees_planted = (report)->
    Math.floor ($scope.count_offsets(report.offset_co2) * app_data.trees_per_offset[report.year])


  $scope.data =
    co2_sources:  _.pluck($scope.reports, "co2_sources")
    co2_per_thing_made: _.sortBy(_.pluck($scope.reports, "co2_per_thing_made"), (item)-> -1*item)
    total_co2_vs_offset:
      total_co2: _.pluck($scope.reports, "total_co2")
      offset_co2: _.pluck($scope.reports, "offset_co2")
