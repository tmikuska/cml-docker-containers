# list of subdirectories containing a Dockerfile
SUBDIRS := $(shell find . -type f -name Dockerfile -exec dirname {} \;)

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

# build:
# 	for dir in $(SUBDIRS); do \
# 			$(MAKE) -C $$dir build; \
# 	done

clean:
	# for dir in $(SUBDIRS); do \
	# 		$(MAKE) -C $$dir clean; \
	# done
	# rm -rf debian/refplat-images-docker
	# dh_clean

.PHONY: all build clean $(SUBDIRS)

deb:
	cd BUILD && dpkg-buildpackage --build=binary --no-sign --no-check-builddeps
	# dpkg-buildpackage --build=binary --no-sign --no-check-builddeps
	# cd BUILD; dpkg-deb --build -Znone refplat-images-docker_all

definitions:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir definitions; \
	done
