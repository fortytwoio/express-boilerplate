test:
	@echo "Start testing"
	npm run test

install:
	npm install

update:
	@echo "Makefile: Updating Express Template App"
	npm install

deploy_production:
	@echo "Deploy to production"
	git push git@app.example.com:~/express-app master
