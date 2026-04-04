.PHONY: login preview deploy

login:
	wrangler login

preview:
	wrangler pages dev dist

deploy:
	wrangler pages deploy dist --project-name ifo-tool
