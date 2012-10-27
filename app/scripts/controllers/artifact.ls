module.exports = ($scope, $routeParams, co2r-api, $location)->

  res <- co2r-api.get "artifact/#{$routeParams.artifact}", {cache:on}

  $scope.artifact       = res.data.artifact
  $scope.reports        = _.sortBy $scope.artifact.footprints, (.year)

  # Variable for default twitter message
  # --------------------------------------------------------------------------------------------------
  # Since we can only update addthis.toolbox once (!) we need to make sure any variables are available as 
  # one config so that when $watch is triggered it receives the completed config
  $scope.addthis-share-config =
    title: "#{$scope.artifact.organization.name} offsets their co2. See their emissions report at: #{$location.abs-url!}"
    description: \test-description



  # report data
  # --------------------------------------------------------------------------------------------------
  if $scope.reports.length

    $scope.artifact.offset-since       = $scope.reports[*-1].year

    $scope.latest-report  = $scope.reports[*-1]
    $scope.column_width   = 300
    $scope.timeline_width = $scope.column_width * $scope.reports.length

    # for the browser title
    $scope.$root.page_title = $scope.artifact.name

    # data collected across artifacts for comparison in charts
    # --------------------------------------------------------------------------------------------------
    $scope.data =
      co2_sources:  _.filter (_.pluck $scope.reports, \carbon_sources_list), -> it.length
      co2_per_thing_made: _.sortBy(_.pluck($scope.reports, \co2_per_unit), -> -1*it)
      total_co2_vs_offset:
        total_co2:  _.pluck $scope.reports, \total_tons_produced
        offset_co2: _.pluck $scope.reports, \total_offset_tons
        trees-planted: _.pluck $scope.reports, \trees_planted


    # data for co2 source categories associated with colors
    # --------------------------------------------------------------------------------------------------
    names = _.uniq _.flatten _.map $scope.data.co2_sources, -> _.pluck it, \name
    # colors.length MUST be longer than names.length
    # colors based on https://files.podio.com/23920019
    # first set of colors are less saturated
    #colors = _.map <[DAE7B1 BED5EC AAA7D3 EBACA4 BDD5C0 FAC7A3 FBF5B6 9A8383]>, -> "##it"
    colors = _.map <[C7DA84 99C0E1 817DBB E07F79 6BAB82 F6A975 F9EF8A 715353]>, -> "##it"
    name-colors = {}
    _.each names, (name, i)-> name-colors[name] = colors[i]

    #console.log colors2, name-colors
    $scope.name-colors = name-colors


    # discover if the artifact *ever* did any other eco actions
    # --------------------------------------------------------------------------------------------------
    # with this information we can know if we need to render the other-eco-actions section
    $scope.has-other-actions = (_.filter (_.pluck $scope.reports, \other_actions), -> it.length).length > 0


