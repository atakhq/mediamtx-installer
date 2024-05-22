#!/bin/bash

# Dependencies required for the script
REQUIRED_DEPENDENCIES=(wget tar)

# Check if dependencies are installed
for dep in "${REQUIRED_DEPENDENCIES[@]}"; do
    if ! command -v "$dep" &> /dev/null; then
        echo "$dep is not installed. Installing..."
        sudo apt-get install -y "$dep"
    fi
done

# Define the URL and target directory
MEDIA_MTX_URL="https://github.com/bluenviron/mediamtx/releases/download/v1.5.1/mediamtx_v1.5.1_linux_amd64.tar.gz"
TARGET_DIR="/tmp/mediamtx"

# Create the target directory if it doesn't exist
sudo mkdir -p "$TARGET_DIR"

# Download the file
wget "$MEDIA_MTX_URL" -O /tmp/mediamtx.tar.gz

# Extract the tar.gz file to the target directory
sudo tar -xzf /tmp/mediamtx.tar.gz -C "$TARGET_DIR"

sudo mv /tmp/mediamtx/mediamtx /usr/local/bin/
sudo mv /tmp/mediamtx/mediamtx.yml /usr/local/etc/

#Create systemd service
sudo tee /etc/systemd/system/mediamtx.service >/dev/null << EOF
[Unit]
Wants=network.target
[Service]
ExecStart=/usr/local/bin/mediamtx /usr/local/etc/mediamtx.yml
[Install]
WantedBy=multi-user.target
EOF


sudo systemctl daemon-reload
sudo systemctl enable mediamtx
sudo systemctl start mediamtx
sudo journalctl -u mediamtx
