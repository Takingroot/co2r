#require './controllers'

window.CO2R = angular.module('meteorapp', [])

# must be required after CO2R is defined as a global
#require('./routes')
do_routes()

CO2R.config(['$locationProvider', ($locationProvider)->
  $locationProvider.html5Mode(true)
])
