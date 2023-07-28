SHELL := '/bin/bash'

GIT_LAST_COMMIT_HASH := $(shell git rev-parse --short HEAD)
CURRENT_DATE_GMT := $(shell date +"%Y-%m-%dT%H:%M:%S_GMT%Z")

develop:
	@echo "Building tag 'dev'"
	docker build \
		--build-arg BUILD_VERSION=dev \
		--no-cache \
		-t devdrops/staticcheck:dev .

latest:
	@echo "Building tags '$(STATICCHECK_TAG)' and 'latest'"
	docker build \
		--build-arg VCS_REF=$(GIT_LAST_COMMIT_HASH) \
		--build-arg BUILD_DATE=$(CURRENT_DATE_GMT) \
		--build-arg BUILD_VERSION=$(GIT_LAST_COMMIT_HASH) \
		--no-cache \
		-t devdrops/staticcheck:$(STATICCHECK_TAG) \
		-t devdrops/staticcheck:latest .

push:
	@echo "Pushing tags '$(STATICCHECK_TAG)' and 'latest'"
	docker push devdrops/staticcheck:$(STATICCHECK_TAG)
	docker push devdrops/staticcheck:latest


.PHONY: develop latest push
