all: watch

test:
	@npm run test

clean:
	@npm run clean
	@echo "Removing './node_modules' dir"
	@rm -rf "./node_modules"
	@echo "Removing './tmp' dir"
	@rm -rf "./tmp"

build:
	@NODE_ENV=production npm run build

install:
	@npm install

update:
	@npm update

deploy:
	git push git@app.example.com:~/express-boilerplate master

.PHONY: all test clean build watch install update deploy
