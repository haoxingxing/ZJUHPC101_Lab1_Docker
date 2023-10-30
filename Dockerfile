FROM gcc

WORKDIR /app
RUN apt-get update && apt-get -y install openssh-server sshpass
RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.6.tar.gz && tar xvf openmpi-4.1.6.tar.gz && cd openmpi-4.1.6 && ./configure --prefix=/app/mpi && make all -j$(nproc)  && make install && ldconfig
RUN wget http://www.netlib.org/blas/blas-3.11.0.tgz && tar xvf blas-3.11.0.tgz && cd BLAS-3.11.0 && make  -j$(nproc) 
RUN wget http://www.netlib.org/blas/blast-forum/cblas.tgz && tar xvf cblas.tgz
COPY Makefile /app/CBLAS/Makefile.in
RUN cd CBLAS && make  -j$(nproc) 
RUN wget https://netlib.org/benchmark/hpl/hpl-2.3.tar.gz && tar xvf hpl-2.3.tar.gz 
COPY Make.Linux_HPC /app/hpl-2.3/Make.Linux_HPC
COPY Make.top /app/hpl-2.3/Make.top
RUN cd hpl-2.3 && make arch=test && make install
RUN echo 'PermitRootLogin=yes'  |  tee -a /etc/ssh/sshd_config
RUN echo 'root:ZJUMPILAB!' | chpasswd
EXPOSE 22
CMD ["service", "ssh", "start", "-D"]
