from novio/dev_base:0.1
MAINTAINER novio<nsnovio@gmail.com>
WORKDIR /opt
RUN git clone https://github.com/baidu-research/warp-ctc.git
RUN apt-get install -y cmake
RUN cd warp-ctc && mkdir build && cd build && cmake .. && make -j4
RUN ln -sf /opt/warp-ctc/build/libwarpctc.so /usr/lib/x86_64-linux-gnu/
WORKDIR /opt
RUN git clone --recursive https://github.com/apache/incubator-mxnet
WORKDIR incubator-mxnet
COPY config.mk ./config.mk
RUN make -j $(($(nproc)-1))
RUN cd python && /root/anaconda3/bin/pip install --upgrade pip && /root/anaconda3/bin/pip install -e .
WORKDIR /run
