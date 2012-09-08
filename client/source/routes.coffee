config_routes = ->
  CO2R.config(['$routeProvider', ($routeProvider)->
    $routeProvider.when('/directory',  {templateUrl: "partials/directory.html",  controller: controllers.directory})
    $routeProvider.when('/about',      {templateUrl: "partials/about.html",      controller: controllers.about})
    $routeProvider.otherwise({redirectTo: '/directory'})
  ])
