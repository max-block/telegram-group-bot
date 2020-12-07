VERSION = $(shell python3 setup.py --version | tr '+' '-')

clean:
	rm -rf .pytest_cache build dist *.egg-info


dist: clean
	python3 setup.py sdist bdist_wheel


upload: dist
	twine upload dist/*
	git tag -a 'v$(VERSION)' -m 'v$(VERSION)'
	git push origin v$(VERSION)

docker_build:
	docker build --build-arg APP_VERSION=$(VERSION) -t telegram-group-bot:$(VERSION) .

docker_upload: docker_build
	docker tag telegram-group-bot:$(VERSION) maxblock/telegram-group-bot:$(VERSION)
	docker push maxblock/telegram-group-bot:$(VERSION)
