.PHONY: clean clean-images clean-dnt

# public target used by sub-Makefiles
clean: clean-dnt clean-images

clean-dnt:
	@rm -rf $(DNT)

clean-images:
	@IMAGE_IDS=$$(docker image ls --format "{{ .ID }}" $(NAME) | uniq); \
	if [ -n "$$IMAGE_IDS" ]; then \
		echo "Removing Docker images: $$IMAGE_IDS"; \
		echo "$$IMAGE_IDS" | xargs docker image rm -f; \
	else \
		echo "No Docker images found matching $(NAME) to remove."; \
	fi
