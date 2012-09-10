AppController = ($scope)->
  $scope.app_title = "CO2R"
  $scope.restore_settings = ->
    $scope.$root.settings.show_introduction.current = yes
  #
  # Settings
  # ------------------------------------------------------------------------------------------

  $scope.$root.settings = {}

  $scope.$root.add_setting = (name, default_value)->
    $scope.$root.settings[name] =
      default: default_value
      current: getLocalStorageBool(name) ? default_value

  $scope.$root.update_setting = (name, value)->
    localStorage.setItem name, value
    $scope.$root.settings[name].current = value

  $scope.$root.restore_settings_to_default = ->
    for setting_name, setting of $scope.$root.settings
      $scope.$root.update_setting setting_name, setting.default

  $scope.$root.add_setting 'show_introduction', yes
