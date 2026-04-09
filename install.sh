#!/bin/bash

error_exit() {
    echo "500"
    echo "Error: $1" >&2
    exit 1
}

# Определение пакетного менеджера (оставляем без изменений)
if medical_check=$(which apt-get 2>/dev/null); then
    pm=$medical_check
    silent_inst="-yq install"
    check_pkgs="-yq update"
    dist="debian"
elif medical_check=$(which dnf 2>/dev/null); then
    pm=$medical_check
    silent_inst="-yq install"
    check_pkgs="-yq check-update"
    dist="fedora"
elif medical_check=$(which yum 2>/dev/null); then
    pm=$medical_check
    silent_inst="-y -q install"
    check_pkgs="-y -q check-update"
    dist="centos"
elif medical_check=$(which zypper 2>/dev/null); then
    pm=$medical_check
    silent_inst="-nq install"
    check_pkgs="-nq refresh"
    dist="opensuse"
elif medical_check=$(which pacman 2>/dev/null); then
    pm=$medical_check
    silent_inst="-Sy --noconfirm --noprogressbar --quiet"
    check_pkgs="-Sup"
    dist="archlinux"
else
    error_exit "Package manager not found"
fi

echo "Dist: $dist, Packet manager: $pm"

if [ "$dist" = "debian" ]; then export DEBIAN_FRONTEND=noninteractive; fi

# Установка зависимостей (убрали git, так как он больше не нужен для клонирования)
if ! command -v sudo > /dev/null 2>&1; then
    $pm $check_pkgs || error_exit "Failed to update repositories";
    $pm $silent_inst sudo || error_exit "Failed to install sudo";
fi
if ! command -v wget > /dev/null 2>&1; then
    sudo $pm $check_pkgs || error_exit "Failed to update repositories";
    sudo $pm $silent_inst wget || error_exit "Failed to install wget";
fi

# Установка Docker и Docker Compose (оставляем без изменений)
if ! command -v docker &> /dev/null; then
    wget -qO- https://raw.githubusercontent.com/amnezia-vpn/amnezia-client/refs/heads/dev/client/server_scripts/install_docker.sh | sh || error_exit "Failed to install Docker"
    sudo usermod -aG docker $USER || error_exit "Failed to add user to docker group"
fi

if ! command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE_VERSION="v2.27.0"
    sudo wget -O /usr/local/bin/docker-compose \
        "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-linux=$(uname -m)" || error_exit "Failed to download Docker Compose"
    sudo chmod +x /usr/local/bin/docker-compose || error_exit "Failed to make Docker Compose executable"
fi

# Запуск Docker
if ! command -v systemctl &> /dev/null; then
    sudo dockerd &> /dev/null &
else
    sudo systemctl start docker || error_exit "Failed to start Docker"
    sudo systemctl enable docker || error_exit "Failed to enable Docker"
fi

# --- ИЗМЕНЕННЫЙ БЛОК: Локальное копирование вместо Git ---

TARGET_DIR="/opt/mcSAD"
# Определяем путь к папке, где лежит сам скрипт
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Copying files from $SOURCE_DIR to $TARGET_DIR..."

sudo rm -rf "$TARGET_DIR" 2>/dev/null
sudo mkdir -p "$TARGET_DIR"
# Копируем всё содержимое локальной папки в /opt/mcSAD
sudo cp -r "$SOURCE_DIR/." "$TARGET_DIR/" || error_exit "Failed to copy local files"

# Удаляем блок с 'git reset', так как в локальной копии может не быть .git
# ---------------------------------------------------------

# Развертывание
cd "$TARGET_DIR/webApp" || error_exit "Failed to enter project directory"
sudo docker-compose down || error_exit "Failed to stop existing containers"
sudo docker-compose up -d --build --force-recreate || error_exit "Failed to run docker-compose"

# Определение IP (оставляем без изменений)
SERVER_IP=$(ip route get 8.8.8.8 2>/dev/null | grep -oP 'src \K[\d.]+')
if [ -z "$SERVER_IP" ]; then
    SERVER_IP=$(hostname -I | awk '{print $1}')
fi
[ -z "$SERVER_IP" ] && SERVER_IP="localhost"

echo "200"
echo "Done! Local deployment successful."
echo "Admin panel: http://${SERVER_IP}:8080"
exit 0
