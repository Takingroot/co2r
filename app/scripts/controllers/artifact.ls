co2r.controllers.controller \artifact, ($scope, $routeParams, co2r-api, twitter-api, $location, $http)->
  $scope.$prepare-for-ready!

  co2r-api.get "artifact/#{$routeParams.artifact}", {cache:on}
  .then (res)->

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

      $scope.artifact.offset-since       = $scope.reports.0.year

      $scope.latest-report  = $scope.reports[*-1]
      $scope.column_width   = 300
      $scope.timeline_width = $scope.column_width * $scope.reports.length

      # for the browser title bar
      $scope.$root.page-title = $scope.artifact.name

      # data collected across artifacts for comparison in charts
      # --------------------------------------------------------------------------------------------------
      /*
      $scope.data2 = {}
      _.each (_.pluck $scope.reports, \year), (year)->
        $scope.data2[year] =
          co2-sources:  _.filter (_.map $scope.reports, \carbon_sources_list), -> it.length
      */

      $scope.data =
        co2-sources:  _.filter (_.pluck $scope.reports, \carbon_sources_list), -> it.length
        co2-per-thing-made: _.sortBy(_.pluck($scope.reports, \co2_per_unit), -> -1*it)
        total-co2-vs-offset:
          total_co2:  _.pluck $scope.reports, \total_tons_produced
          offset_co2: _.pluck $scope.reports, \total_offset_tons
          trees-planted: _.pluck $scope.reports, \trees_planted


      # data for co2 source categories associated with colors
      # --------------------------------------------------------------------------------------------------
      names = _.uniq _.flatten _.map $scope.data.co2-sources, -> _.pluck it, \name
      # colors.length MUST be longer than names.length
      # colors based on https://files.podio.com/23920019
      # first set of colors are less saturated
      # TODO the upper-case color codes are not from the mockups, old and ugly
      colors = _.map <[92dde6 74b7c5 8eb375 ffd943 c7db7f F6A975 F9EF8A 715353]>, -> "##it"
      name-colors = {}
      _.each names, (name, i)-> name-colors[name] = colors[i]

      #console.log colors2, name-colors
      $scope.name-colors = name-colors


      # discover if the artifact *ever* did any other eco actions
      # --------------------------------------------------------------------------------------------------
      # with this information we can know if we need to render the other-eco-actions section
      $scope.has-other-actions = (_.filter (_.pluck $scope.reports, \other_actions), -> it.length).length > 0



    twitter-user-name = _($scope.artifact.organization.contact_infos)
    .select(-> it.name.to-lower-case! is \twitter).0?.link

    if twitter-user-name
      twitter-api.get-user-timeline(screen_name:twitter-user-name, count:4)
      .success (data, status, headers, config)->
        $scope.organization-tweets = data
        console.log data

    $scope.$on-ready!
