# Boilerplate
p := $(p).x
dirstack_$(p) := $(d)
d := $(dir)

ifndef NODE_VERSION
$(error NODE_VERSION is undefined)
endif

DOCKER_IMAGE_$(d) := vincentbesanceney/node
DOCKER_TAG_$(d) := $(NODE_VERSION)

BUILD := $(BUILD) build_$(d)
PUSH := $(PUSH) push_$(d)

build_$(d): DOCKER_IMAGE := $(DOCKER_IMAGE_$(d))
build_$(d): DOCKER_TAG := $(DOCKER_TAG_$(d))
build_$(d): DOCKER_CONTEXT := $(d)
build_$(d): $(d)/Dockerfile
	docker build \
		--build-arg NODE_VERSION="$(NODE_VERSION)" \
		-t "$(DOCKER_IMAGE):$(DOCKER_TAG)" "$(DOCKER_CONTEXT)"

push_$(d): DOCKER_IMAGE := $(DOCKER_IMAGE_$(d))
push_$(d): DOCKER_TAG := $(DOCKER_TAG_$(d))
push_$(d):
	docker push "$(DOCKER_IMAGE):$(DOCKER_TAG)"

# Boilerplate
d := $(dirstack_$(p))
p := $(basename $(p))
