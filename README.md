# Breakable Toy
The most vanilla RailsApp possible.

## Technologies

- Action Policy

## How to develop

Use vscode devcontainer to create a image with all OS dependencies for development (vim, git, postgres, ruby, etc)
And remotely conect vscode to it so vscode terminal is inside this image.
Download extensions in `.vscode` and that's it! Ready to run!

## FAQ
### Git

If using WSL, vscode devcontainers reuse ssh keys from host.
It doesn't reuse keys from WSL, but from windows host.
Basically, check if windows host has ssh correctly configures (`ssh-add -l`).
If not, you have to configure (and add to startup) the ssh client on windows powershell.
See [why](https://stackoverflow.com/questions/70206554/share-ssh-keys-with-vs-code-devcontainer-running-with-dockers-wsl2-backend) and [how](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement) to configure SSH keys to windows host
Once inside devcontainer, check if keys are there (`ssh-add -l` again). Also check DevContainer build logs (in VSCODE) to see if SSH keys are being properly proxied (and where they are getting your keys from)

