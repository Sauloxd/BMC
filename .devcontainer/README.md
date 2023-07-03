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

### features

On top of our dev image container, the key `features` in `devcontainer,json` also adds utilities when running the images, like: node, aws-cli and others, that is related to `tools needed for building app for deploy`, rather than tools needed for development. That's why they are not listed inside `.devcontainer/Dockerfile`.

## FAQ
### Git

If using WSL, vscode devcontainers reuse ssh keys from host.
It doesn't reuse keys from WSL, but from windows host.
Basically, check if windows host has ssh correctly configures (`ssh-add -l`).
If not, you have to configure (and add to startup) the ssh client on windows powershell.
See [why](https://stackoverflow.com/questions/70206554/share-ssh-keys-with-vs-code-devcontainer-running-with-dockers-wsl2-backend) and [how](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement) to configure SSH keys to windows host
Once inside devcontainer, check if keys are there (`ssh-add -l` again). Also check DevContainer build logs (in VSCODE) to see if SSH keys are being properly proxied (and where they are getting your keys from)
