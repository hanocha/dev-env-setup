# dev-env-setup

setting up development environment on Ubuntu using MItamae.


## requirements

- Ubuntu 18.04 "Bionic"

## usage

### 1. Download MItamae binaly

```
$ wget -o mitamae https://github.com/k0kubun/mitamae/releases/download/v1.5.6/mitamae-x86_64-linux
$ chmod 700 mitamae
```

### 2. Create node.json

```node.json
{
  "user": {
    "name": "hanocha"
  }
}
```


### 3. Run MItamae

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
