all:
	brunch watch --server

components:
	component install
	component build -s component -o ./app/assets/components/ -p '/components'
	brunch build

build:
	brunch build

compressed-build:
	brunch build
	# We need --no-mangle to not screw up angularjs
	uglifyjs --overwrite --no-copyright --verbose --no-mangle .public/javascripts/app.js
	uglifyjs --overwrite --no-copyright --verbose .public/javascripts/vendor.js

demo:
	git push demo master

local-verbose-demo:
	rm -R .public
	rm -R node_modules
	npm install
	node .launch-production-server


.PHONY: components
