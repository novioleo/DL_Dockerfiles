sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.daocloud.io/docker/linux/centos/docker-ce.repo
sudo yum install -y -q --setopt=obsoletes=0 docker-ce  docker-ce-selinux docker-ce-cli
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
# 将当前用户添加到docker组
sudo usermod -a -G docker `whoami`
# 检查是否存在nvidia-docker1，并删除
docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
sudo yum remove nvidia-docker
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.repo | sudo tee /etc/yum.repos.d/nvidia-docker.repo
sudo yum -y install nvidia-docker2
sudo rm -f /etc/docker/daemon.json
sudo tee /etc/docker/daemon.json <<EOF
{"registry-mirrors": ["http://89eddaf0.m.daocloud.io"]}
EOF
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H unix:// --add-runtime=nvidia=/usr/bin/nvidia-container-runtime --default-runtime=nvidia
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl status docker
