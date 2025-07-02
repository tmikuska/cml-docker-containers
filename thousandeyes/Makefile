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
	docker save thousandeyes/enterprise-agent:latest-agent | gzip - >$(IMG)
	@if ! [ -f $(IMG) ]; then \
	  echo "required file missing, see README"; \
		exit 1; \
	fi
	rm -f $(DNT)/$(NTAG).tar.gz
	mv $(IMG) $(DNT)/$(NTAG).tar.gz
