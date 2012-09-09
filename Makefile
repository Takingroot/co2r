path_client        = ./client
path_public        = ./public
# TODO these are not local but until we need other front-end devs on this project I don't want to deal with 
# littering project root with node_modules, package.json, etc.
path_local_bin     = /usr/local/bin
dir_name_templates = templates

html_once:
	${path_local_bin}/jade ${path_client}/${dir_name_templates}/partials       --out ${path_public}/partials
	${path_local_bin}/jade ${path_client}/${dir_name_templates}/angular.jade	 --out ${path_public}

html:
	watchdir --dir ${path_client}/${dir_name_templates} --command "make html_once"

server:
	mrt
