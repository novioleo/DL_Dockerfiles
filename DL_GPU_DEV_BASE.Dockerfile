from nvidia/cuda:9.1-cudnn7-devel-ubuntu16.04
MAINTAINER novio<nsnovio@gmail.com>
WORKDIR /run
COPY sources.list /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential git
# must install opencv first,otherwise the dbus module will corrupt with anaconda3~
RUN apt-get install -y libopencv-dev
# you can dowload OpenBlas by yourself
# ADD http://github.com/xianyi/OpenBLAS/archive/v0.2.20.tar.gz ./openblas
ADD OpenBLAS-0.2.20.tar.gz ./openblas
WORKDIR openblas/OpenBLAS-0.2.20
RUN apt-get install -y gfortran
RUN make FC=gfortran -j $(($(nproc)-1)) && make install
RUN apt-get install -y liblapack-dev
WORKDIR /run
# you can download by yourself
# ADD https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-4.2.0-Linux-x86_64.sh ./
ADD Anaconda3.sh ./
RUN bash Anaconda3.sh -b -p /root/anaconda3
ENV PATH="root/anaconda3/bin:${PATH}"
RUN rm -f Anaconda3.sh
