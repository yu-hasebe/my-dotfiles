.PHONY: update-brewfile
update-brewfile:
	brew bundle dump --describe --file=Brewfile --force

.PHONY: install-from-brewfile
install-from-brewfile:
	brew bundle install --file=Brewfile

.PHONY: create-symlinks
create-symlinks:
	./scripts/bin/create-symlinks.sh

.PHONY: create-symlinks-force
create-symlinks-force:
	./scripts/bin/create-symlinks.sh force
