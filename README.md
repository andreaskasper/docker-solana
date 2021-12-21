# docker-solana
A docker container for the solana cli and spl-token to easily manage your solana coins and tokens

### Features
- [x] Simple solana cli in a container
- [x] Simple spl-token cli in a container

### Build status:
[![Build Status](https://img.shields.io/github/workflow/status/andreaskasper/docker-solana/Docker%20Image%20CI)](https://hub.docker.com/r/andreaskasper/solana)
![Build Status](https://img.shields.io/docker/image-size/andreaskasper/solana/cli)

### Bugs & Issues:
![Github Issues](https://img.shields.io/github/issues/andreaskasper/docker-solana.svg)

### Stats:
![Activities](https://img.shields.io/github/commit-activity/m/andreaskasper/docker-solana.svg)
![Last Commit](https://img.shields.io/github/last-commit/andreaskasper/docker-solana.svg)
![Code Languages](https://img.shields.io/github/languages/top/andreaskasper/docker-solana.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/andreaskasper/solana.svg)

### Running the container :

Here is an example video, how to create a token/coin:

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/befUVytFC80/0.jpg)](https://www.youtube.com/watch?v=befUVytFC80)


#### Create your Solana Wallet

```sh
$ docker run -it --rm andreaskasper/solana:cli solana-keygen new
```

#### Get your balance (with local wallet file)

```sh
$ docker run -it --rm -v ${PWD}/id.json:/root/.config/solana/id.json:ro andreaskasper/solana:cli solana balance
```

#### Create A Token

```sh
$ docker run -it --rm -v ${PWD}/id.json:/root/.config/solana/id.json:ro andreaskasper/solana:cli spl-token 
```

### Environment Parameters
| Parameter     | Description                                             | Example       |
| ------------- |:-------------------------------------------------------:|:-------------:|



### Folders:
| Folder/File                  | Description               |
| ---------------------------- |:-------------------------:|
| /root/.config/solana/id.json | Your wallet file          |



### Steps
- [x] Build a base test image to test this build process (Travis/Docker)
- [ ] add Enviroment Variables
- [ ] better entrypoint script
- [ ] Build tests
- [ ] Gnomes
- [ ] Profit

### Links
[🐋 Docker Hub](https://hub.docker.com/r/andreaskasper/solana)

### support the projects :hammer_and_wrench:
[![donate via Solana](https://img.shields.io/badge/Solana-CPeKEKhitSeZt21Hir5vfvSnKbH3XCJpAUUfneL3WgZV-green.svg)](solana:CPeKEKhitSeZt21Hir5vfvSnKbH3XCJpAUUfneL3WgZV)
[![donate via Patreon](https://img.shields.io/badge/Donate-Patreon-green.svg)](https://www.patreon.com/AndreasKasper)
[![donate via PayPal](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/AndreasKasper)
