# Ethereum "development box"

## Introduction

This is a [Vagrant](https://www.vagrantup.com/) configuration to set up a complete, virtualized development environment for Ethereum users.

1. [Usage](#usage)
2. [Installation](#setup)
3. [Customize your virtual machine](#customize)
4. [Configure your new box and install new software](#configure)

## <a name="usage"></a> Usage

The Ethereum "development box" is a complete development environment for Ethereum users.

It requires to have [Vagrant](https://www.vagrantup.com/) installed on your machine.

It is fully based on Open Source software, most importantly:

- Ubuntu
- OpenJDK (Oracle JDK can't be used because of license issues)
- Yarn, NPM, Bower and Gulp
- Docker and Docker Compose
- [Ubuntu Make](https://wiki.ubuntu.com/ubuntu-make) so you can easily install your favorite IDE (type `umake ide idea` for Intellij IDEA or `umake ide eclipse` for Eclipse)
- Chromium and Firefox Web browsers

This "development box" also have all client applications useful for working:

- Ganache-CLI
- Truffle
- EthereumJS-TestRPC

## <a name="setup"></a> Installation

The "Quick installation" provides a pre-build Virtual Machine, and the "Manual installation" let you build your Virtual Machine yourself. We recommend you use the "Quick installation" if you don't know which option to choose.

### Manual installation

This generates a new "development box" directly from this repository.

- Clone this repository: `git clone https://github.com/VSaliy/ethereum-devbox.git`
- Run `vagrant up`

## <a name="customize"></a> Customize your virtual machine

This is very important! Modify your system properties, depending on your host's hardware. We recommend, at least:

- 4 CPUs
- 8 Gb of RAM
- 128 Mb of video RAM

## <a name="configure"></a> Configure your new box and install new software

Start up the new box:

- Login using the `vagrant` user (not the 'Ubuntu' user which is selected by default)
  - Password is `vagrant` (please note that default keyboard layout is US!)
- Configure your keyboard, if you are not using an English keyboard, once you have logged in:
  - Go to `Settings > Keyboard`
  - Open the `Layout` tab
  - Untick the `Use system default` box
  - Use the `+` sign to add your keyboard layout
- Configure your IDE
  - Use [Ubuntu Make](https://wiki.ubuntu.com/ubuntu-make) so you can easily install your favorite IDE:
    - Type `umake ide idea` for Intellij IDEA
    - Type `umake ide eclipse` for Eclipse
- Configure you browser
  - Firefox is installed
  - Chromium, which is the Open-Source version of Google Chrome, is also installed
- Other available tools
  - [Guake](http://guake-project.org/) is installed, hit "F12" to have your terminal
  - The [Visual Studio Code](https://code.visualstudio.com/) code editor is installed
