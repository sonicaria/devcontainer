tag = kevinfocke/sonicaria-third-party:devcontainer

build:
	docker build . --no-cache -t ${tag}

push:
	docker image push ${tag}

run:
	docker run --rm -it ${tag}

pruneDocker:
	docker system prune

neovim:
	apt-get install lazygit neovim ripgrep -y
