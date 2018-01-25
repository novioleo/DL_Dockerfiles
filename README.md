# DL_Dockerfiles
there are dockerfiles provide me a independent deeplearning environment.all uploaded are tested,fell free to use it.

**YOU NEED INSTALL CUDA,NVIDIA-DRIVER,NVIDIA-DOCKER2 FIRST**

## how to use nvidia docker in pycharm

1. install nvidia-docker2 with official manual.
2. create override.conf in /etc/systemd/system/docker.service.d with sudo permission.
```bash
sudo tee < EOF > /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --host=fd:// --add-runtime=nvidia=/usr/bin/nvidia-container-runtime --default-runtime=nvidia
EOF
```
3. reload the docker daemon `sudo systemctl daemon-reload`
4. restart docker `sudo systemctl restart docker`
5. just use the intepreter in the image in pycharm,please follow the jetbarins official tutourial.
