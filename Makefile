VERSION=2.28.1
DOCKER_ID?=shoshii
SERVICE_NAME=prometheus
REPO=${DOCKER_ID}/${SERVICE_NAME}-docker

all: build


container:
	@echo "Building ${REPO}:${VERSION}"
	docker build --pull -t ${REPO}:${VERSION} .

build: container

run:
	docker volume create prometheus-data
	docker run --rm --net=host -it --name=${SERVICE_NAME} -v prometheus-data:/var/lib/prometheus ${REPO}:${VERSION}

stop:
	docker ps | grep ${REPO}:${VERSION} | cut -d " " -f 1 | xargs docker stop || echo 'failed to stop'
	docker rm ${SERVICE_NAME}

push:
	docker -- push ${REPO}:${VERSION}

.PHONY: all build run stop push