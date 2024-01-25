#Dockerfile vars
POST_IMAGE_VER=1.0
COMMENT_IMAGE_VER=1.0
UI_IMAGE_VER=1.0
PROM_IMAGE_VER=1.0
BLACKBOX_IMAGE_VER=1.0
BASE_IMAGE_REPO_DIR=src
PROM_IMAGE_REPO_DIR=monitoring

#vars
USER_NAME=sergio21sem

.PHONY: help build push all

help:
	    @echo "Makefile arguments:"
	    @echo ""
	    @echo "alpver - Alpine Version"
	    @echo "kctlver - kubectl version"
	    @echo ""
	    @echo "Makefile commands:"
	    @echo "build"
	    @echo "push"
	    @echo "all"

.DEFAULT_GOAL := all

build:
	    @docker build -t ${USER_NAME}/comment:${COMMENT_IMAGE_VER} ./${BASE_IMAGE_REPO_DIR}/comment
		@docker build -t ${USER_NAME}/post:${POST_IMAGE_VER} ./${BASE_IMAGE_REPO_DIR}/post-py
		@docker build -t ${USER_NAME}/ui:${UI_IMAGE_VER} ./${BASE_IMAGE_REPO_DIR}/ui
		@docker build -t ${USER_NAME}/prometheus:${PROM_IMAGE_VER} ./${PROM_IMAGE_REPO_DIR}/prometheus
		@docker build -t ${USER_NAME}/blackbox_exporter:${BLACKBOX_IMAGE_VER} ./${PROM_IMAGE_REPO_DIR}/blackbox_exporter

build-comment:
	    @docker build -t ${USER_NAME}/comment:${COMMENT_IMAGE_VER} ./${BASE_IMAGE_REPO_DIR}/comment
build-post:
		@docker build -t ${USER_NAME}/post:${POST_IMAGE_VER} ./${BASE_IMAGE_REPO_DIR}/post-py
build-ui:
		@docker build -t ${USER_NAME}/ui:${UI_IMAGE_VER} ./${BASE_IMAGE_REPO_DIR}/ui
build-prom:
		@docker build -t ${USER_NAME}/prometheus:${PROM_IMAGE_VER} ./${PROM_IMAGE_REPO_DIR}/prometheus
build-blackbox:
		@docker build -t ${USER_NAME}/blackbox_exporter:${BLACKBOX_IMAGE_VER} ./${PROM_IMAGE_REPO_DIR}/blackbox_exporter

push:
	    @docker push ${USER_NAME}/comment:${COMMENT_IMAGE_VER}
		@docker push ${USER_NAME}/post:${POST_IMAGE_VER}
		@docker push ${USER_NAME}/ui:${UI_IMAGE_VER}
		@docker push ${USER_NAME}/prometheus:${PROM_IMAGE_VER}
		@docker push ${USER_NAME}/blackbox_exporter:${BLACKBOX_IMAGE_VER}

all: build push
