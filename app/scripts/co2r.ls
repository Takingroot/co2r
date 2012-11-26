window.co2r =
  services:    angular.module \co2r.services, []
  filters:     angular.module \co2r.filters, []
  directives:  angular.module \co2r.directives, []
  controllers: angular.module \co2r.controllers , []
  app:         angular.module \co2r, [
                \ngSanitize
                \ui
                \Scope.onReady
                \co2r.services
                \co2r.filters
                \co2r.controllers
                \co2r.directives
                ]

co2r.app.config ($route-provider, partialPath, $location-provider)->
  $location-provider.html5-mode on

  $route-provider.when '/',                                  {redirect-to: '/directory'}
  $route-provider.when '/directory',                         {template-url: partial-path(\directory),      controller: \directory}
  $route-provider.when '/about',                             {template-url: partial-path(\about),          controller: \about}
  $route-provider.when '/faq',                               {template-url: partial-path(\faq),            controller: \faq, reload-on-search: no}
  $route-provider.when '/register-your-product',             {template-url: partial-path(\register),       controller: \register}
  $route-provider.when '/other-things-you-can-do-to-help',   {template-url: partial-path(\other-things),   controller: \other-things}
  $route-provider.when '/:artifact',                         {template-url: partial-path(\artifact),       controller: \artifact}
