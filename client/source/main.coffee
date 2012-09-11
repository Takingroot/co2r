window.CO2R = angular.module('meteorapp', [])

config_routes()



CO2R.config(['$locationProvider', ($locationProvider)->
  $locationProvider.html5Mode(true)
])

CO2R.run ($rootScope)->
  window.$rootScope = $rootScope

CO2R.factory 'preferencesStorage', ->
  new PreferencesStorage
    show_introduction: yes
