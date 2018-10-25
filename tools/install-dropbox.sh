#!/bin/bash
cd /tmp || exit
install_dropbox() {
    wget https://linux.dropbox.com/packages/ubuntu/dropbox_2015.10.28_amd64.deb
    sudo dpkg -i dropbox_*.deb
    sudo apt-get install -f -y
    rm -rf dropbox_*.deb
    /usr/bin/dropbox start -i
}

# ============================================================================
install_dropbox
echo "Dropbox installation completed successfully."
echo "You can use Dropbox!"