m = angular.module \co2r.directives, []

.directive \anchorable,        require './anchorable'
.directive \co2Contrasted,     require './co2-contrasted'
.directive \co2rBind,          require './co2r-bind'
.directive \co2rDefinition,    require './co2r-definition'
.directive \scrollFixBottom,   require './scroll-fix-bottom'
.directive \smoothScroll,      require './smooth-scroll'
.directive \timelineConductor, require './timeline-conductor'
.directive \timelineSlider,    require './timeline-slider'
.directive \anchorable,        require './anchorable'

require('./navigation')(m)
require('./bootstrap')(m)
require('./charts')(m)
require('./reports')(m)
require('./addthis')(m)
require('./co2')(m)
