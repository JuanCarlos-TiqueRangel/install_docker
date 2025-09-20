#!/usr/bin/env bash
set -euo pipefail

echo ">>> Step 1: Update apt and install prerequisites"
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo ">>> Step 2: Add Docker's official GPG key (.asc format)"
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo ">>> Step 3: Add Docker repository to Apt sources"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo \"${UBUNTU_CODENAME:-$VERSION_CODENAME}\") stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo ">>> Step 4: Update apt index after adding Docker repo"
sudo apt-get update

echo ">>> Step 5: Install Docker packages (explicit install line included)"
# This line is intentionally repeated for clarity and to match your request.
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo ">>> Step 6: Add current user to the docker group (run docker without sudo)"
sudo usermod -aG docker "$USER"

echo
echo " ✔️ Docker installation completed!"
echo "   - You may need to log out/in or run: newgrp docker"
echo "   - Test installation with: docker run hello-world"
