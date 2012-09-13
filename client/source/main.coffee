window.CO2R = angular.module('meteorapp', ['ngSanitize'])

config_routes()


CO2R.filter "unit", ->
  (input, type)->
    switch type
      when 'kg'
        return "#{input*1000} kg"

CO2R.config(['$locationProvider', ($locationProvider)->
  $locationProvider.html5Mode(true)
])

CO2R.run ($rootScope)->
  window.$rootScope = $rootScope

CO2R.factory 'preferencesStorage', ->
  new PreferencesStorage
    show_introduction: yes
