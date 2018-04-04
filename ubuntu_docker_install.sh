sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.daocloud.io/docker/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=$(dpkg --print-architecture)] https://download.daocloud.io/docker/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y -q docker-ce=17.09.1*
sudo service docker start
sudo service docker status

# Add the package repositories
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update

# Install nvidia-docker2 and reload the Docker daemon configuration
sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd

sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --host=fd:// --add-runtime=nvidia=/usr/bin/nvidia-container-runtime --default-runtime=nvidia
EOF
sudo rm -f /etc/docker/daemon.json
sudo tee /etc/docker/daemon.json <<EOF
{"registry-mirrors": ["http://89eddaf0.m.daocloud.io"]}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
