angular.module \co2r.controllers, []

.controller \about,        require './about'
.controller \artifact,     require './artifact'
.controller \directory,    require './directory'
.controller \faq,          require './faq'
.controller \other-things, require './other-things'
.controller \register,     require './register'
.controller \test,         require './test'

window.app-controller = require './app'
