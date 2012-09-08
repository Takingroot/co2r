path_client        = ./public/client
path_public        = ./public
# TODO these are not local but until we need other front-end devs on this project I don't want to deal with 
# littering project root with node_modules, package.json, etc.
path_local_bin     = /usr/local/bin
dir_name_templates = partials

html:
	${path_local_bin}/jade ${path_client}/${dir_name_templates}     --out ${path_public}/${dir_name_templates}
	${path_local_bin}/jade ${path_client}/angular.jade							--out ${path_public}

html_watch:
	${path_local_bin}/jade ${path_client}/${dir_name_templates}   --out ${path_public}/${dir_name_templates} --watch
	${path_local_bin}/jade ${path_client}/angular.jade					  --out ${path_public} --watch

server:
	mrt
