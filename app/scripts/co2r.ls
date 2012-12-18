window.co2r =
  services:    angular.module \co2r.services, []
  filters:     angular.module \co2r.filters, []
  directives:  angular.module \co2r.directives, []
  controllers: angular.module \co2r.controllers , []
  app:         angular.module \co2r, [
                \ngSanitize
                \ui
                \bindCompile
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
  $route-provider.when '/mission',                           {template-url: partial-path(\mission),        controller: \mission}
  $route-provider.when '/faq',                               {template-url: partial-path(\faq),            controller: \faq, reload-on-search: no}
  $route-provider.when '/register-your-product',             {template-url: partial-path(\register),       controller: \register}
  $route-provider.when '/participate',                       {template-url: partial-path(\participate),    controller: \participate}
  $route-provider.when '/:artifact',                         {template-url: partial-path(\artifact),       controller: \artifact}
