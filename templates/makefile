include vars.mk

DEST:=../cml-definitions/image-definitions
TAG := $(shell echo $(VERSION) | tr '[:upper:]~' '[:lower:]-')
NTAG:=$(NAME)-$(TAG)
DNT:=$(DEST)/$(NTAG)

.PHONY: all
all: build definitions

.PHONY: clean
clean:
	rm -rf $(DNT)
	docker image ls --format "{{ .ID }}" $(NAME) | uniq | xargs docker image rm -f

.PHONY: build
build: $(DNT)
	docker buildx build . -t $(NAME) --build-arg uid=2000 --build-arg version=$(VERSION)
	docker tag $(NAME):latest $(NTAG)
	docker save $(NAME):latest | gzip - >$(DNT)/$(NTAG).img

.PHONY: definitions
definitions: $(DNT)
	sha256=`docker image inspect -f '{{ index .Id }}' $(NTAG) | cut -d':' -f2)` && \
  date=`date +"%Y%m%d"` && \
	cat ../templates/image-definition | sed \
		-e 's/{{DESCR}}/$(DESCR)/g' \
		-e 's/{{NAME}}/$(NAME)/g' \
		-e 's/{{VERSION}}/$(VERSION)/g' \
		-e 's/{{TAG}}/$(TAG)/g' \
		-e 's/{{NTAG}}/$(NTAG)/g' \
		-e "s/{{SHA256}}/$$sha256/g" \
	  -e "s/{{DATE}}/$$date/" \
	>$(DNT)/$(NTAG).yaml

$(DNT):
	mkdir -p $@
