all:
	grunt

components:
	component install
	component build -s component -o ./app/assets/components/ -p '/components'
	brunch build

build:
	grunt build

demo:
	git push demo master

.PHONY: components
