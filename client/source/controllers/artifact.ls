controller_artifact = ($scope, $routeParams, $http)->

  $http.get("http://co2r-data-staging.herokuapp.com/api/artifact/#{$routeParams.artifact}").success (data)->
    $scope.artifact       = data.artifact
    $scope.reports        = _.sortBy $scope.artifact.footprints, (.year)
    $scope.column_width   = 300
    $scope.timeline_width = $scope.column_width * $scope.reports.length

    _.each $scope.reports, (report)->
      vars-for-year = _.first _.select app_data.offset_variables, -> it.year is report.year
      offset-count  = report.total_offset_tons * vars-for-year.offsets_per_co2_ton
      trees-planted = offset-count * vars-for-year.trees_per_offset

      report.trees_planted = trees-planted.floor!


    # data collected across artifacts for comparison
    $scope.data =
      co2_sources:  _.pluck $scope.reports, \carbon_sources_list
      co2_per_thing_made: _.sortBy(_.pluck($scope.reports, \co2_per_unit), -> -1*it)
      total_co2_vs_offset:
        total_co2:  _.pluck $scope.reports, \total_tons_produced
        offset_co2: _.pluck $scope.reports, \total_offset_tons