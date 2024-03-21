# Reproducible Development Environment

To minimize onboarding time per project, a development environment must be
quickly fully-ready. We use VSCode Devcontainers in combination with Docker
images to achieve this purpose.

The devcontainer image tag can be found at this link:
https://github.com/sonicaria/devcontainer/blob/main/Makefile

Instructions for sharing your git credentials:
https://code.visualstudio.com/remote/advancedcontainers/sharing-git-credentials

If your project needs additional services, add them to `docker-compose.yml`.

If your project needs additional dependencies, add them to `package.json` or
`cargo.toml`. Furthermore, it's important to add a script called `onboarding` to
the `package.json` and include instructions in the `README`. That way a user can
`npm run onboarding` within the devcontainer and be fully-ready.
Notably, you must enable git hooks by running `husky` which is globally available in the devcontainer.

If your project needs additional tools, build a new image using the Sonicaria
devcontainer as the base image.
