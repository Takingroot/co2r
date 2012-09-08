path_client        = ./public/client
path_public        = ./public
path_local_bin     = /usr/local/bin
dir_name_styles		 = styles
dir_name_templates = templates
dir_name_source    = source


client: css html jsugly

stylus_command	       = ${path_local_bin}/stylus --out ${path_public}/${dir_name_styles} ${path_client}/${dir_name_styles}/main.styl

css:
	${stylus_command}

css_watch:
	${stylus_command} --watch

html:
	${path_local_bin}/jade ${path_client}/${dir_name_templates}     --out ${path_public}/${dir_name_templates}
	${path_local_bin}/jade ${path_client}/angular.jade								--out ${path_public}

html_watch:
	${path_local_bin}/jade ${path_client}/${dir_name_templates}   --out ${path_public}/${dir_name_templates} --watch
	${path_local_bin}/jade ${path_client}/angular.jade						  --out ${path_public} --watch

jsugly: js
	${path_local_bin}/uglifyjs --overwrite --no-copyright --no-mangle --verbose ${path_public}/${dir_name_source}/main.js

js:
	${path_local_bin}/browserify --entry  ${path_client}/${dir_name_source}/main.coffee --outfile ${path_public}/${dir_name_source}/main.js

server:
	mrt
