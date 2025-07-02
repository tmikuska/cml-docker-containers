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

XRD := xrd-control-plane-container-x86.$(VERSION).tgz
IMG := xrd-control-plane-container-x64.dockerv1.tgz

.PHONY: build
build: $(DNT) $(NDEF)
	@if ! [ -f "$(XRD)" ]; then \
	  echo "required file missing, see README"; \
		exit 1; \
	fi
	tar zxvf $(XRD) ./$(IMG)
	gunzip --stdout $(IMG) | docker load
	# docker image tag ios-xr/xrd-control-plane:$(VERSION) ios-xr/xrd-control-plane:latest
	rm -f $(DNT)/$(NTAG).tar.gz
	mv $(IMG) $(DNT)/$(NTAG).tar.gz
	# docker buildx build . -t $(NAME) --build-arg uid=2000 --build-arg version=$(VERSION)
	# docker tag $(NAME):latest $(NTAG)
	# docker tag $(NAME):latest $(NAME):$(TAG)
	# docker save $(NAME):latest | gzip - >$(DNT)/$(NTAG).tar.gz
	# rm -f $(IMG)
