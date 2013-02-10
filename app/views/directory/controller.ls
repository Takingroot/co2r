


function directory-controller(artifactsRes, $scope, preferencesStorage)

  $scope.$root.page-title = ''

  directory =
    artifacts: artifactsRes.data.artifacts

    introductionState: ->
      preferences-storage.get \showIntroduction

    toggleIntroduction: ->
      preferences-storage.set \showIntroduction, !preferences-storage.get('showIntroduction')

    actionSteps:
      * title: \directory_action_title_one
        body:  \directory_action_body_one
        icon:  \leaf
        link:  "/mission"

      * title: \directory_action_title_two
        body:  \directory_action_body_two
        icon:  \edit
        link:  "/register-your-product"

      * title: \directory_action_title_three
        body:  \directory_action_body_three
        icon:  \heart
        link:  "/participate"

  window.directoryCtrl = $scope.directory = directory



co2r.controllers.controller \directory, [\artifactsRes, \$scope, \preferencesStorage, directory-controller]
