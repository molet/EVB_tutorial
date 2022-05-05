# EVB Tutorial Installation Guide

This repository includes a guide to download and install all necessary softwares that are used in the EVB lectures.

In order to avoid compilation issues on different architectures and operating systems, we will use [Docker](https://docs.docker.com/get-started/overview/).
Docker provides a lightweight and fast virtual machine on which we can run the corresponding programs (for more information visit the [Docker documentation](https://docs.docker.com/)).

## Install Docker

1. [Download and install Docker](https://docs.docker.com/get-docker/) for your corresponding platform. For [Mac](https://docs.docker.com/desktop/mac/install/) and [Windows](https://docs.docker.com/desktop/windows/install/) it is the Docker Desktop, while for [Linux](https://docs.docker.com/engine/install/) it is the Docker Engine.

2. Start Docker by running the Docker Desktop or on Linux by typing `sudo service docker start` in a terminal. 

3. Verify Docker by typing `sudo docker run hello-world` in a terminal. 

Congratulations, you have Docker on your machine!

## Build the Docker Image

Download the [Dockerfile](https://github.com/molet/EVB_tutorial/blob/main/Dockerfile) provided within this repository. You can either copy the raw content and save it with the same filename on your machine, or use [Git](https://git-scm.com/downloads) and clone the repository: `git clone https://github.com/molet/EVB_tutorial.git`.

Once you have the Dockerfile on your machine, enter to its directory and build the image by typing:

`docker build -t evb_image:latest .`

This will build the virtual machine (Linux Ubuntu 18.04) with the following programs:
- [Python](https://www.python.org/) - efficient high-level programming language
- [Jupyter Notebook](https://jupyter.org/) - server-client application that allows editing and running notebook documents via a web browser
- [Amber/AmberTools](https://ambermd.org/index.php) - biomolecular simulation program package
- [CATs](https://github.com/kulhanek/cats) - conversion and analysis tools for topology and coordinate manipulation
- XdynBP - Empirical Valence Bond molecular dynamics program package

Depending on your machine and internet connection, the image should be built within 15-20 minutes.

## Run a Container over the Docker Image

You can run the image inside of a container by using [`docker run`](https://docs.docker.com/engine/reference/commandline/run/):

`docker run --name=evb --ulimit stack=-1 --publish=9999:9999 --entrypoint /bin/bash --workdir="/home/EVB_tutorial" --rm -it evb_image:latest`

In the above command, with the `--name` flag we name the container (as `evb`), `--ulimit stack=-1` will set the stack unlimited (this is equivalent to run `ulimit -s unlimited` on Linux and required to run XdynBP nicely), `--publish=9999:9999` publishes the port 9999 of the container to the port 9999 of the host (this will be used to access the notebook outside of the container), with `--entrypoint /bin/bash` we use bash, `--workdir="/home/EVB_tutorial"` specifies the directory we enter, `--rm` removes the container if exists and `-it` makes sure we can use the container interactively.

## Useful Docker Commands

Once a container is running, you can run a new command by `docker exec`. For instance, if you already started the container by the above `docker run` command then you enter it interactively from another terminal by typing:

`docker exec `
