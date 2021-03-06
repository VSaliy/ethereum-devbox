#!/bin/sh

# update the system
# apt-get update
# apt-get -y upgrade

system_install() {

    ################################################################################
    # Install the mandatory tools
    ################################################################################

    # install utilities
    apt-get -y install vim git zip bzip2 fontconfig curl language-pack-en

    # install Java 8
    apt-get install openjdk-8-jdk

    # install Node.js
    curl -sL https://deb.nodesource.com/setup_8.x | bash -
    apt-get install -y nodejs unzip python g++ build-essential

    # update NPM
    npm install -g npm

    # install Yarn
    npm install -g yarn
    su -c "yarn config set prefix /home/vagrant/.yarn-global" vagrant

    # install Yeoman
    npm install -g yo

    # install JHipster
    #npm install -g generator-jhipster@5.4.2

    # install JHipster UML
    #npm install -g jhipster-uml@2.0.3

    ################################################################################
    # Install Ethereum development environment
    ################################################################################

    # install Ganache
    npm install -g ganache-cli
    #wget https://github-production-release-asset-2e65be.s3.amazonaws.com/79269625/e34e4500-a706-11e8-95cc-c3a914d6b80c?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20181011%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20181011T164450Z&X-Amz-Expires=300&X-Amz-Signature=dba7e041e09eab176e97c9b085b58db256f03e0087329ee653d9e55e1d8d23e8&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3Dganache-1.2.2-x86_64.AppImage&response-content-type=application%2Foctet-stream
    curl -OL https://github.com/trufflesuite/ganache/releases/download/v1.2.2/ganache-1.2.2-x86_64.AppImage
    chmod a+x ganache-1.2.2-x86_64.AppImage
    ./ganache-1.2.2-x86_64.AppImage
    # install Truffle
    npm install -g truffle

    npm install -g ethereumjs-testrpc

    npm install -g webpack
    npm install -g webpack-cli

    ################################################################################
    # Install the graphical environment
    ################################################################################

    # force encoding
    echo 'LANG=en_US.UTF-8' >> /etc/environment
    echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
    echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
    echo 'LC_CTYPE=en_US.UTF-8' >> /etc/environment

    # run GUI as non-privileged user
    echo 'allowed_users=anybody' > /etc/X11/Xwrapper.config

    # install Ubuntu desktop and VirtualBox guest tools
    apt-get install -y xubuntu-desktop virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

    # remove light-locker (see https://github.com/jhipster/jhipster-devbox/issues/54)
    apt-get remove -y light-locker --purge

    # change the default wallpaper
    wget https://raw.githubusercontent.com/VSaliy/ethereum-devbox/master/images/ethereum-wallpaper.png -O /usr/share/xfce4/backdrops/ethereum-wallpaper.png
    sed -i -e 's/xubuntu-wallpaper.png/ethereum-wallpaper.png/' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

    ################################################################################
    # Install the development tools
    ################################################################################

    # install Ubuntu Make - see https://wiki.ubuntu.com/ubuntu-make
    apt-get install -y ubuntu-make

    # install Chromium Browser
    apt-get install -y chromium-browser

    # install MySQL Workbench
    apt-get install -y mysql-workbench

    # install PgAdmin
    apt-get install -y pgadmin3

    # install Heroku toolbelt
    wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

    # install Guake
    apt-get install -y guake
    cp /usr/share/applications/guake.desktop /etc/xdg/autostart/

    # install ethereum-devbox
    git clone git://github.com/VSaliy/ethereum-devbox.git /home/vagrant/ethereum-devbox
    chmod +x /home/vagrant/ethereum-devbox/tools/*.sh

    # install zsh
    apt-get install -y zsh

    # install oh-my-zsh
    git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh
    cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc
    chsh -s /bin/zsh vagrant
    echo 'SHELL=/bin/zsh' >> /etc/environment

    # install jhipster-oh-my-zsh-plugin
    git clone https://github.com/jhipster/jhipster-oh-my-zsh-plugin.git /home/vagrant/.oh-my-zsh/custom/plugins/jhipster
    sed -i -e "s/plugins=(git)/plugins=(git docker docker-compose jhipster)/g" /home/vagrant/.zshrc
    echo 'export PATH="$PATH:/usr/bin:/home/vagrant/.yarn-global/bin:/home/vagrant/.yarn/bin:/home/vagrant/.config/yarn/global/node_modules/.bin"' >> /home/vagrant/.zshrc

    # change user to vagrant
    chown -R vagrant:vagrant /home/vagrant/.zshrc /home/vagrant/.oh-my-zsh

    # install Visual Studio Code
    su -c 'umake ide visual-studio-code /home/vagrant/.local/share/umake/ide/visual-studio-code --accept-license' vagrant

    # fix links (see https://github.com/ubuntu/ubuntu-make/issues/343)
    sed -i -e 's/visual-studio-code\/code/visual-studio-code\/bin\/code/' /home/vagrant/.local/share/applications/visual-studio-code.desktop

    # disable GPU (see https://code.visualstudio.com/docs/supporting/faq#_vs-code-main-window-is-blank)
    sed -i -e 's/"$CLI" "$@"/"$CLI" "--disable-gpu" "$@"/' /home/vagrant/.local/share/umake/ide/visual-studio-code/bin/code

    #install IDEA community edition
    su -c 'umake ide idea /home/vagrant/.local/share/umake/ide/idea' vagrant

    # increase Inotify limit (see https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit)
    echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/60-inotify.conf
    sysctl -p --system

    # install latest Docker
    curl -sL https://get.docker.io/ | sh

    # install latest docker-compose
    curl -L "$(curl -s https://api.github.com/repos/docker/compose/releases | grep browser_download_url | head -n 4 | grep Linux | grep -v sha256 | cut -d '"' -f 4)" > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    # configure docker group (docker commands can be launched without sudo)
    usermod -aG docker vagrant
}

# fix ownership of home
fix_ownership_of_home() {
    chown -R vagrant:vagrant /home/vagrant/
}

# clean the box
clean_the_box() {
    apt-get -y autoclean
    apt-get -y clean
    apt-get -y autoremove
    dd if=/dev/zero of=/EMPTY bs=1M > /dev/null 2>&1
    rm -f /EMPTY
}

# ============================================================================
system_install
fix_ownership_of_home
clean_the_box