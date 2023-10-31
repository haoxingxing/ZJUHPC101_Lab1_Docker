FROM gcc:bookworm

WORKDIR /app
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && apt-get update && apt-get -y install openssh-server sshpass libopenblas-*
RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.6.tar.gz && tar xvf openmpi-4.1.6.tar.gz && rm openmpi-4.1.6.tar.gz &&\
    wget https://netlib.org/benchmark/hpl/hpl-2.3.tar.gz                          && tar xvf hpl-2.3.tar.gz       && rm hpl-2.3.tar.gz &&\
    cd openmpi-4.1.6 &&\
    ./configure --prefix=/app/mpi &&\
    make all -j$(nproc) &&\
    make install && ldconfig
COPY Make.Linux_HPC /app/hpl-2.3/Make.Linux_HPC
RUN cd hpl-2.3 && make arch=Linux_HPC && make arch=Linux_HPC install

RUN echo 'PermitRootLogin=yes'  |  tee -a /etc/ssh/sshd_config &&\
    echo 'root:ZJUMPILAB!' | chpasswd

CMD ["service", "ssh", "start", "-D"]
