all:
	make server

server:
	mrt

deploy:
	# we use debug because otherwise uglifyjs ruins our angular app
	# https://github.com/lvbreda/Meteor_angularjs/issues/5
	mrt deploy co2r --debug
