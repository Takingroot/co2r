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

production:
	ssh ubuntu@takingroot.org "cd /sites/co2r && git pull origin master && npm install --production"

.PHONY: components
