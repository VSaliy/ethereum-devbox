#!/bin/bash
cd /tmp || exit
install_DBeaver() {
    echo "Downloading DBeaver Community latest ..."
    DBeaver_VERSION=$(curl -s https://api.github.com/repos/dbeaver/dbeaver/releases/latest | grep 'tag_name' | cut -d\" -f4)
    wget -q "https://dbeaver.io/files/${DBeaver_VERSION}/dbeaver-ce_${DBeaver_VERSION}_amd64.deb" -O dbeaver.deb

    echo "Installing ..."
    sudo dpkg -i dbeaver.deb
    sudo apt install -f
    rm -rf dbeaver.deb
}

# ============================================================================
install_DBeaver
echo "DBeaver installation completed successfully."
echo "You can use DBeaver!"