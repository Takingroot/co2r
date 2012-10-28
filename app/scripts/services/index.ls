angular.module \co2r.services, []

.factory \preferencesStorage, require './preferences-storage'
.service \routeCssClasses,    require './route-css-classes'
.service \co2rApi,            require './co2r-api'

# make this a constant so we can use it even in <module>.config blocks
# it's a pure function so we don't need a factory version
.constant \partialPath,   require './partial-path'
