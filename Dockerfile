FROM gcc

WORKDIR /app
RUN apt-get update && apt-get -y install openssh-server sshpass
RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.6.tar.gz && tar xvf openmpi-4.1.6.tar.gz && cd openmpi-4.1.6 && ./configure --prefix=/app/mpi && make all -j$(nproc)  && make install && ldconfig
RUN apt-get -y install libopenblas-* 
RUN wget https://netlib.org/benchmark/hpl/hpl-2.3.tar.gz && tar xvf hpl-2.3.tar.gz 
COPY Make.Linux_HPC /app/hpl-2.3/Make.Linux_HPC
RUN cd hpl-2.3 && make arch=Linux_HPC && make  arch=Linux_HPC install
RUN echo 'PermitRootLogin=yes'  |  tee -a /etc/ssh/sshd_config
RUN echo 'root:ZJUMPILAB!' | chpasswd
EXPOSE 22
CMD ["service", "ssh", "start", "-D"]
