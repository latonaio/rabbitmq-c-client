# Self-Documented Makefile
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


key-copy: ## bitbucket に push するための SSH key をコピーする
	cp ~/.ssh/id_rsa ./.key/id_rsa || \
	echo "ssh鍵が '~./ssh/id_rsa' にありませんでした。bitbucketで使用している ssh鍵 を、'.key/id_rsa' にコピーしてください。"


docker-run: ## container 起動
	docker compose up --no-recreate

build-cpp: ## cpp ファイルをビルド
	docker-compose exec dev g++ -std=c++11 $(f) -lamqpcpp -lpthread -luv