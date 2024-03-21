# Reproducible Development Environment

To minimize onboarding time per project, a development environment must be
fully-ready with a single command. We use VSCode Devcontainers in combination
with Docker images to achieve this purpose.

The devcontainer image tag can be found at this link:
https://github.com/sonicaria/devcontainer/blob/main/Makefile

Instructions for sharing your git credentials:
https://code.visualstudio.com/remote/advancedcontainers/sharing-git-credentials

If your project needs additional services, add them to `docker-compose.yml`.

If your project needs additional tools or dependencies, build a new image using
the Sonicaria devcontainer as the base image.
