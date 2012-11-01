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

app.config ($route-provider, partialPath, $location-provider)->
  $location-provider.html5Mode on

  $route-provider.when '/',                                  {template-url: partial-path(\directory),      controller: \directory}
  $route-provider.when '/directory',                         {template-url: partial-path(\directory),      controller: \directory}
  $route-provider.when '/about',                             {template-url: partial-path(\about),          controller: \about}
  $route-provider.when '/faq',                               {template-url: partial-path(\faq),            controller: \faq, reload-on-search: no}
  $route-provider.when '/register-your-product',             {template-url: partial-path(\register),       controller: \register}
  $route-provider.when '/other-things-you-can-do-to-help',   {template-url: partial-path(\other-things),   controller: \other-things}
  $route-provider.when '/test',                              {template-url: partial-path(\test),           controller: \test}
  $route-provider.when '/:artifact',                         {template-url: partial-path(\artifact),       controller: \artifact}

