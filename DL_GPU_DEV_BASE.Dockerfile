# choose the source image with your cuda version.
from nvidia/cuda:9.1-cudnn7-devel-ubuntu16.04
MAINTAINER novio<nsnovio@gmail.com>
WORKDIR /run
COPY sources.list /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential git
# must install opencv first,otherwise the dbus module will corrupt with anaconda3~
RUN apt-get install -y libopencv-dev
# libatlas-base will provide the cblas
RUN apt-get install -y libopenblas-dev libatlas-base-dev
RUN apt-get install -y liblapack-dev
WORKDIR /run
# you can download by yourself
# ADD https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-4.2.0-Linux-x86_64.sh ./
ADD Anaconda3.sh ./
RUN bash Anaconda3.sh -b -p /root/anaconda3
ENV PATH="root/anaconda3/bin:${PATH}"
RUN rm -f Anaconda3.sh
