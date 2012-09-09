config_routes = ->
  CO2R.config(['$routeProvider', ($routeProvider)->
    $routeProvider.when('/directory',  {templateUrl: "partials/directory.html",  controller: controllers.directory})
    $routeProvider.when('/about',      {templateUrl: "partials/about.html",      controller: controllers.about})
    $routeProvider.when('/faq',      {templateUrl: "partials/faq.html",      controller: controllers.faq})
    $routeProvider.when('/register-your-product',      {templateUrl: "partials/register.html",      controller: controllers.register})
    $routeProvider.when('/other-things-you-can-do-to-help',      {templateUrl: "partials/other_things.html",      controller: controllers.other_things})
    $routeProvider.otherwise({redirectTo: '/directory'})
  ])
