# How to maintain .devcontainer

Dockerfile + Docker Compose were inspired in [Evil Martian's config](https://evilmartians.com/chronicles/ruby-on-whales-docker-for-ruby-rails-development).
The workflow is:
- F1 > Dev Container: Rebuild Container
- If fails: F1 > Dev Containers Developer: Show all logs
- See error logs for Dockerfile, DockerCompose, SSH errors, etc
- If fails: F1 > Dev Containers: Reopen folder in WSL

## The devcontainer.json

This file configures the dev container environment, and should be properly configured to use Dockerfile or Docker Compose.
See there for more: https://code.visualstudio.com/docs/devcontainers/create-dev-container