m = angular.module \co2r.services, []

.factory 'preferencesStorage', require './preferences-storage'

# make this a constant so we can use it even in <module>.config blocks
# it's a pure function so we don't need a factory version
.constant 'partialPath',       require './partial-path'
