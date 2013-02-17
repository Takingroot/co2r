all:
	grunt

components:
	component install --out ./.components/
	component build --standalone require --out ./app/assets/components/ --prefix '/components'
	grunt build
	rm -fr ./.components

components-clean:
	rm -fr ./.components

build:
	grunt build

demo:
	git push demo master

.PHONY: components
