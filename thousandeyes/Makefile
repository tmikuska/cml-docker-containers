.PHONY: all
all: build definitions

# the name of our package
PKG := refplat-images-docker
export PKG

include vars.mk
include ../templates/definitions.mk

.PHONY: clean
clean:
	rm -rf $(DNT)
	docker image ls --format "{{ .ID }}" $(NAME) | uniq | xargs docker image rm -f

IMG := te-ea.tgz

.PHONY: build
build: $(DNT) $(NDEF)
	docker pull thousandeyes/enterprise-agent:latest-agent
	docker tag  thousandeyes/enterprise-agent:latest-agent $(NAME):$(TAG)
	docker save $(NAME):$(TAG) | gzip - >$(IMG)
	mv -f $(IMG) $(DNT)/$(NTAG).tar.gz
