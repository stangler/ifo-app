.PHONY: login preview deploy

login:
	pnpm exec wrangler login

preview:
	pnpm exec wrangler pages dev dist

deploy:
	pnpm exec wrangler pages deploy dist --project-name ifo-tool