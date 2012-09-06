require './vendor'
require './controllers'

window.CO2R = angular.module('co2r', [])

# must be required after CO2R is defined as a global
require('./routes')

CO2R.config(['$locationProvider', ($locationProvider)->
  $locationProvider.html5Mode(true)
])
