FROM gcc

WORKDIR /app
RUN apt-get update && apt-get -y install libopenblas-dev openssh-server sshpass
RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.6.tar.gz && tar xvf openmpi-4.1.6.tar.gz && cd openmpi-4.1.6 && ./configure && make -j$(nproc) && make install && ldconfig
RUN wget https://netlib.org/benchmark/hpl/hpl-2.3.tar.gz && tar xvf hpl-2.3.tar.gz && cd hpl-2.3 && ./configure && make arch=Linux_PII_CBLAS && make install
RUN echo 'PermitRootLogin=yes'  |  tee -a /etc/ssh/sshd_config
RUN echo 'root:ZJUMPILAB!' | chpasswd
EXPOSE 22
CMD ["service", "ssh", "start", "-D"]