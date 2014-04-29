test:
	@echo "Start testing"
	npm run test

install:
	@echo "Installing all dependencies"
	npm install

update:
	@echo "Makefile: Updating Express Boilerplate App"
	npm update

deploy_production:
	@echo "Deploy to production"
	git push git@app.example.com:~/express-boilerplate master
