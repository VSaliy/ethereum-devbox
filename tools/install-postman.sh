#!/bin/bash
cd /tmp || exit
install_postman() {
    echo "Downloading Postman ..."
    wget -q https://dl.pstmn.io/download/latest/linux?arch=64 -O postman.tar.gz
    tar -xzf postman.tar.gz
    rm postman.tar.gz

    echo "Installing to opt..."
    if [ -d "/opt/Postman" ];then
        sudo rm -rf /opt/Postman
    fi
    sudo mv Postman /opt/Postman

    echo "Creating symbolic link..."
    if [ -L "/usr/bin/postman" ];then
        sudo rm -f /usr/bin/postman
    fi
    sudo ln -s /opt/Postman/Postman /usr/bin/postman

    cat << EOF >> Postman.desktop
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Exec=postman
Name=Postman
Comment=Postman
Icon=/opt/Postman/resources/app/assets/icon.png
Categories=Development;
EOF

    chmod +x Postman.desktop
    sudo cp Postman.desktop /usr/share/applications
    cp Postman.desktop ~/.local/share/applications/

}

# ============================================================================
install_postman
echo "Postman installation completed successfully."
echo "You can use Postman!"
