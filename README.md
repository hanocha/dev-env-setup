# dev-env-setup

setting up development environment on Ubuntu using MItamae.


## requirements

- Ubuntu 18.04 "Bionic"
- Ubuntu 20.04 "Focal"

## usage

### 1. Download MItamae binary

```
$ wget https://github.com/k0kubun/mitamae/releases/download/v1.11.7/mitamae-x86_64-linux; mv mitamae-x86_64-linux mitamae; chmod 700 mitamae;
```

### 2. Run mitamae

```
# ./mitamae local -j node.json main.rb
```


## Packages to be installed

See also: `main.rb`

- curl
- Powerline fonts
- fish, fisherman, bobthefish theme
- go, ghq, peco
- neovim
- ruby with rbenv
- python
- docker
