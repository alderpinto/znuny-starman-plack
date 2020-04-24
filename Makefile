.PHONY: build
build:
	@echo "Build docker image..."
	docker build --tag miketonks/plack-server .
