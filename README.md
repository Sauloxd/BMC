# BMC
An awesome app to track your beach tennis matches!
Create your club, a rank and dispute matches against your friends to decide who is the best or less worst than everyone!

## Why?
The only way to improve is to keep building things.
With this app, I want to try new approaches for common and new problems. For example, 
What it would be like to have an app without any bundler? With no complex over the top frontend framework?
How would you host a Rails app with the lowest cost possible? How about a serverless Rails?

## Technologies
- Vanilla Ruby on Rails (sprockets + importmap + turbo + tailwind)
- Postgresql
- Action Policy
- Devise
- Lamby
- WSL2 (cause I'm tired of linux poor UX quality of life)

## How to develop
This project uses vscode devcontainer to create an image with all OS dependencies for development (vim, git, postgres, ruby, etc).
Easy to just clone this repo and start contributing right away!
More info on how to maintain it in `./devcontainer/README.md`\

## How to deploy
We are using SAM to manage our serveless functions, and for now we deploy from our local machine.
You only need an AWS credential configured in your env (`aws configure`) with proper access, and then you can `./bin/deploy` and the deploy script does the rest!

### Workarounds
It's just the common setup for (Lamby)[https://lamby.cloud/docs/quick-start].
There are a few gotchas when developing from a WSL setup, so just not for myself:
1. For some reason, when running `sam build` it fails to store the docker credentials or something. To workaround, just update `~/.docker/config.json` "credsStore" key to `{ "credsStore": "" }` 
2. When deploying, it will bundle install dependencies from your docker container in dev.
That's why it is important to have devcontainer and prod container in sync (because some gems are built for specific OS).
3. Allow you docker setup to download gems in local `./vendor/bundle` because this is the bundle that will be used in production
4. WSL architecture requires `template.yaml` for SAM to use `x86_64` architeture. 


## FAQ
### Git

If using WSL, vscode devcontainers reuse ssh keys from host.
It doesn't reuse keys from WSL, but from windows host.
Basically, check if windows host has ssh correctly configures (`ssh-add -l`).
If not, you have to configure (and add to startup) the ssh client on windows powershell.
See [why](https://stackoverflow.com/questions/70206554/share-ssh-keys-with-vs-code-devcontainer-running-with-dockers-wsl2-backend) and [how](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement) to configure SSH keys to windows host
Once inside devcontainer, check if keys are there (`ssh-add -l` again). Also check DevContainer build logs (in VSCODE) to see if SSH keys are being properly proxied (and where they are getting your keys from)

