from nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
run rm -f /etc/apt/sources.list.d/cuda.list
copy sources.list.18.04 /etc/apt/sources.list
copy jupyterhub_config.py /
copy Anaconda3-5.2.0-Linux-x86_64.sh /tmp/anaconda.sh
run chmod +x /tmp/anaconda.sh&& bash /tmp/anaconda.sh -bfp /opt/anaconda
env PATH=$PATH:/opt/anaconda/bin
run pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U
run pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
run pip install nodejs jupyterlab jupyterhub jupyter_contrib_nbextensions ipywidgets && jupyter nbextension enable --py widgetsnbextension
run rm -fr /etc/apt/sources.list.d/*
run apt-get update
run apt-get install -y npm vim
run npm install -g configurable-http-proxy
run useradd -m -s /bin/bash -p $(openssl passwd -crypt 'admin') admin
# manager
run jupyter labextension install @jupyter-widgets/jupyterlab-manager
# video widget
#run pip install Jupyter-Video-Widget && \
#	jupyter nbextension install --py --sys-prefix jpy_video && \
#	jupyter nbextension enable  --py --sys-prefix jpy_video && \
#	jupyter labextension install jupyter-video
run pip install -U jupyterlab
# voyager
#run jupyter labextension install jupyterlab_voyager
# toc
#run jupyter labextension install @jupyterlab/toc
# go_to_definition
#run jupyter labextension install @krassowski/jupyterlab_go_to_definition
workdir /
run usermod -aG root admin
cmd ["jupyterhub","-f","jupyterhub_config.py"]

