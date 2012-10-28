require './services'
require './filters'
require './controllers'
require './directives'

app = angular.module \co2r, [
  \ngSanitize
  \ui
  \co2r.services
  \co2r.filters
  \co2r.controllers
  \co2r.directives
]

app.config ($routeProvider, partialPath)->
  $routeProvider.when '/',                                  {templateUrl: partial-path(\directory),      controller: \directory}
  $routeProvider.when '/directory',                         {templateUrl: partial-path(\directory),      controller: \directory}
  $routeProvider.when '/about',                             {templateUrl: partial-path(\about),          controller: \about}
  $routeProvider.when '/faq',                               {templateUrl: partial-path(\faq),            controller: \faq, reload-on-search: no}
  $routeProvider.when '/register-your-product',             {templateUrl: partial-path(\register),       controller: \register}
  $routeProvider.when '/other-things-you-can-do-to-help',   {templateUrl: partial-path(\other-things),   controller: \other-things}
  $routeProvider.when '/test',                              {templateUrl: partial-path(\test),           controller: \test}
  $routeProvider.when '/:artifact',                         {templateUrl: partial-path(\artifact),       controller: \artifact}

app.config [\$locationProvider, ($location-provider)->
  $location-provider.html5Mode on
]
