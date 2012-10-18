all:
	brunch watch --server

build:
	brunch build

compressed-build:
	brunch build
	# We need --no-mangle to not screw up angularjs
	uglifyjs --overwrite --no-copyright --verbose --no-mangle .public/javascripts/app.js 
	uglifyjs --overwrite --no-copyright --verbose .public/javascripts/vendor.js

demo:
	git push demo master

local-demo:
	node .launch-production-server
