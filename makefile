all:
	grunt

components:
	component install --out ./.components/
	component build --standalone ./.component --out ./app/assets/components/ --prefix '/components'
	grunt build

build:
	grunt build

demo:
	git push demo master

.PHONY: components
