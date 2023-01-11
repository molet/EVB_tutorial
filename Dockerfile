# Ubuntu 22.04 LTS
FROM ubuntu:22.04

# Updates & essential
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential

# Install basic programs
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y tree wget vim cmake git
RUN apt-get install -y python3-venv python3-pip python3-dev python3-numpy python3-matplotlib

# Install ipython, jupyter and gdown by pip
RUN pip3 install --upgrade pip
RUN pip3 install ipython
RUN pip3 install jupyter
RUN pip3 install --upgrade --no-cache-dir gdown

# Download the tutorial
WORKDIR /home
RUN mkdir -p /home/EVB_tutorial
WORKDIR /home/EVB_tutorial
RUN gdown 1KcjT9dbaJ-KuP3IiG4IRKxGVrYZk4rQi
RUN tar -xvzf Tutorial_completed.tar.gz
RUN rm -f Tutorial_completed.tar.gz
RUN gdown 1QJrZPHX4gZ33uLk2-M3QUQ7jNA2xeM1m 
RUN tar -xvzf Tutorial.tar.gz
RUN rm -f Tutorial.tar.gz
RUN mkdir -p /home/EVB_tutorial/Programs
WORKDIR /home/EVB_tutorial/Programs

# Install Intel Fortran for XdynBP
#RUN wget https://registrationcenter-download.intel.com/akdlm/irc_nas/19105/l_fortran-compiler_p_2023.0.0.25394.sh
#RUN bash l_fortran-compiler_p_2023.0.0.25394.sh -a -s --eula accept --install-dir=/home/EVB_tutorial/Programs/intel
#ENV PATH $PATH:/home/EVB_tutorial/Programs/intel/mpi/2021.8.0//libfabric/bin:/home/EVB_tutorial/Programs/intel/mpi/2021.8.0//bin:/home/EVB_tutorial/Programs/intel/debugger/2023.0.0/gdb/intel64/bin:/home/EVB_tutorial/Programs/intel/compiler/2023.0.0/linux/bin/intel64:/home/EVB_tutorial/Programs/intel/compiler/2023.0.0/linux/bin
#ENV LD_LIBRARY_PATH /home/EVB_tutorial/Programs/intel/mpi/2021.8.0//libfabric/lib:/home/EVB_tutorial/Programs/intel/mpi/2021.8.0//lib/release:/home/EVB_tutorial/Programs/intel/mpi/2021.8.0//lib:/home/EVB_tutorial/Programs/intel/debugger/2023.0.0/gdb/intel64/lib:/home/EVB_tutorial/Programs/intel/debugger/2023.0.0/libipt/intel64/lib:/home/EVB_tutorial/Programs/intel/debugger/2023.0.0/dep/lib:/home/EVB_tutorial/Programs/intel/compiler/2023.0.0/linux/lib:/home/EVB_tutorial/Programs/intel/compiler/2023.0.0/linux/lib/x64:/home/EVB_tutorial/Programs/intel/compiler/2023.0.0/linux/compiler/lib/intel64_lin
RUN wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list
RUN apt-get update
RUN apt-get install -y intel-oneapi-compiler-fortran-2023.0.0
ENV PATH $PATH:/opt/intel/oneapi/mpi/2021.8.0//libfabric/bin:/opt/intel/oneapi/mpi/2021.8.0//bin:/opt/intel/oneapi/debugger/2023.0.0/gdb/intel64/bin:/opt/intel/oneapi/compiler/2023.0.0/linux/bin/intel64:/opt/intel/oneapi/compiler/2023.0.0/linux/bin
ENV LD_LIBRARY_PATH /opt/intel/oneapi/mpi/2021.8.0//libfabric/lib:/opt/intel/oneapi/mpi/2021.8.0//lib/release:/opt/intel/oneapi/mpi/2021.8.0//lib:/opt/intel/oneapi/debugger/2023.0.0/gdb/intel64/lib:/opt/intel/oneapi/debugger/2023.0.0/libipt/intel64/lib:/opt/intel/oneapi/debugger/2023.0.0/dep/lib:/opt/intel/oneapi/compiler/2023.0.0/linux/lib:/opt/intel/oneapi/compiler/2023.0.0/linux/lib/x64:/opt/intel/oneapi/compiler/2023.0.0/linux/compiler/lib/intel64_lin

# Install Miniconda for Amber
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /home/EVB_tutorial/Programs/miniconda3 
ENV PATH $PATH:/home/EVB_tutorial/Programs/miniconda3/bin
RUN conda update -y -n base -c defaults conda

# Install Amber
RUN conda install -y -c conda-forge ambertools
ENV AMBERHOME /home/EVB_tutorial/Programs/miniconda3

# Install CATs
RUN gdown 1uTkETEarWXRL-2RQnSMhZRrsYDEFa6TX
RUN tar -xvzf cats.tar.gz
ENV PATH $PATH:/home/EVB_tutorial/Programs/cats

# Install XdynBP
RUN gdown 1PXxqPkjSjdFGEaOrAuqWdH07cQBLcb_6
RUN tar -xvzf xdynbp.tar.gz
WORKDIR /home/EVB_tutorial/Programs/xdynbp
RUN make
ENV PATH $PATH:/home/EVB_tutorial/Programs/xdynbp/bin

WORKDIR /home/EVB_tutorial

# Download notebooks & figures
RUN gdown 15XjNX5MGnWDBCKFbNiQH6HLRFf-G_GhR
RUN gdown 1-4ABVORgmbQeJSH1bMCRKJ95ibfoGR3x 
RUN gdown 194JSUItM4bb754rdlA8bMF2HZOPkQvEc
RUN gdown 1sYwrLqC-rMm1mamuZYHOVOHnLNeZ-oWY

RUN mkdir -p figures
WORKDIR figures
RUN gdown 1Sjm0i8UhlfbqhBmqzRGTPds1BIDA6YWr
RUN gdown 16_70iu77LnAAQWFjCCUIV265YK4k3ygv
RUN gdown 134cF0dRJIezDyGJizsWAGMnAVAv4bgnt
RUN gdown 1SzJ38FwBq6JYBhzfouDqkGCBKMFcgf7D

WORKDIR /home/EVB_tutorial
