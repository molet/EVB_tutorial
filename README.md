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

Download the [Dockerfile](https://github.com/molet/EVB_tutorial/blob/main/Dockerfile) provided within this repository. You can either copy the raw content and save it with the same filename on your machine, or use [Git](https://git-scm.com/downloads) and clone the repository:

```
git clone https://github.com/molet/EVB_tutorial.git
```

You can update the contents of the repository on you machine by typing `git pull` after entering `EVB_tutorial`.

Once you have the Dockerfile on your machine, enter to its directory and build the image by typing:

```
docker build -t evb_image:latest .
```

This will build the virtual machine `evb_image` with the tag `latest`. It is a Linux Ubuntu 18.04 operating system with the following programs:
- [Python](https://www.python.org/) - efficient high-level programming language
- [Jupyter Notebook](https://jupyter.org/) - server-client application that allows editing and running notebook documents via a web browser
- [Amber/AmberTools](https://ambermd.org/index.php) - biomolecular simulation program package
- [CATs](https://github.com/kulhanek/cats) - conversion and analysis tools for topology and coordinate manipulation
- XdynBP - Empirical Valence Bond molecular dynamics program package

Depending on your machine and internet connection, the image should be built within 15-20 minutes.

## Run a Container over the Docker Image

You can run the image inside of a container by using [`docker run`](https://docs.docker.com/engine/reference/commandline/run/):

```
docker run --name=evb_container --ulimit stack=-1 --publish=9999:9999 --entrypoint /bin/bash --workdir="/home/EVB_tutorial" --rm -it evb_image:latest
```

In the above command, with the `--name` flag we name the container (as `evb_container`), `--ulimit stack=-1` will set the stack space unlimited (this is equivalent to run `ulimit -s unlimited` on Linux and required to run XdynBP nicely), `--publish=9999:9999` publishes the port 9999 of the container to the port 9999 of the host (this will be used to access the notebook outside of the container), with `--entrypoint /bin/bash` we use the bash shell, `--workdir="/home/EVB_tutorial"` specifies the directory we enter, `--rm` removes the container if exists and `-it` makes sure we can use the container interactively.

## Useful Docker Commands

Use [`docker images`](https://docs.docker.com/engine/reference/commandline/images/) and [`docker ps`](https://docs.docker.com/engine/reference/commandline/ps/) to list images and containers on your machine.

Once a container is running, you can run a new command by [`docker exec`](https://docs.docker.com/engine/reference/commandline/exec/). For instance, if you already started the container by the above `docker run` command then you can enter it interactively from another terminal by typing:

```
docker exec -it evb_container /bin/bash
```

It is important to note that once you finish running a command (e.g. stop and exit the container) then all data and changes you made in the container will be lost. In order to save your changes, you can create a new image from the container by the [`docker commit`](https://docs.docker.com/engine/reference/commandline/commit/) command:

```
docker commit evb_container evb_images:new
```

We cannot directly access the files and folders in a container from our local filesystem. However, if required, files and folders can be copied between the container and local filesystem by the [`docker cp`](https://docs.docker.com/engine/reference/commandline/cp/) command. For example, if you run the `evb_container` then the starting PDB file can copied to your local folder by typing:

```
docker cp evb_container:/home/EVB_tutorial/Tutorial/01.Preparation/KE07_R7_B__DE_1.pdb .
```

## Running Jupyter Notebook from a Docker Container

We will use the [Jupyter Notebook](https://jupyter.org/) to run and analyze our simulations interactively from a Docker container. Once you are running a container as described above, you can start a notebook in the working directory (`/home/EVB_tutorial`):

```
ipython notebook --no-browser --ip=0.0.0.0 --port=9999 --allow-root
```

After the server started, it should print out something like this:

```
    To access the notebook, open this file in a browser:
        file:///root/.local/share/jupyter/runtime/nbserver-92-open.html
    Or copy and paste one of these URLs:
        http://01109c22e8b6:9999/?token=a14df6b6eef9000f985dda1997336767fb0ef184bdd1a31c
     or http://127.0.0.1:9999/?token=a14df6b6eef9000f985dda1997336767fb0ef184bdd1a31c
```

If you copy and paste any of these URLs in your browser (your actual URLs will be different from the above example), you should have access to the notebooks in the container.

## Content of the Working Directory

The working directory (`/home/EVB_tutorial`) contains the followings:
- `Programs` subdirectory includes the installed softwares.
- `Tutorial` subdirectory includes the input files for the EVB simulations. You can play with preparing inputs, running simulations and analyzing outputs here.
- `Tutorial_completed` subdirectory includes the input and output files for the EVB simulations. Some steps of the simulations may take longer time so you will not need to run everything but can access all the results here.
- `figures` subdirectory includes some figures for the jupyter notebooks.
- Notebooks:
	- `0-Introduction.ipynb`
	- `1-Preparation.ipynb`
	- `2-Equilibration.ipynb`
	- `3-Reaction.ipynb`

## Visualizing the MD Results

For visualization of the system and trajectories the [VMD](https://www.ks.uiuc.edu/Research/vmd/) program is recommended. It is free and you can download it from [here](https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD).
