# Define the list of subdirectories containing a Dockerfile
SUBDIRS := $(shell find . -type f -name Dockerfile -exec dirname {} \;)

# Target to build all projects
all: $(SUBDIRS)

# Rule to build each subdirectory
$(SUBDIRS):
	$(MAKE) -C $@

# Clean target to clean all subdirectories
clean:
	for dir in $(SUBDIRS); do \
			$(MAKE) -C $$dir clean; \
	done

.PHONY: all clean $(SUBDIRS)

deb:
	cd BUILD; dpkg-deb --build -Znone refplat-images-docker_all
