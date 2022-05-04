# EVB Tutorial Installation Guide

This repository includes a guide to download and install all necessary softwares that are used in the EVB lectures.

In order to avoid compilation issues on different architectures and operating systems, we will use [Docker](https://docs.docker.com/get-started/overview/).
Essentially, Docker provides a lightweight and fast virtual machine on which we can run the corresponding programs (for more visit the [Docker documentation](https://docs.docker.com/)).

1. [Download and install Docker](https://docs.docker.com/get-docker/) for your corresponding platform. For [Mac](https://docs.docker.com/desktop/mac/install/) and [Windows](https://docs.docker.com/desktop/windows/install/) it is the Docker Desktop, while for [Linux](https://docs.docker.com/engine/install/) it is the Docker Engine.

2. Start Docker by running the Docker Desktop or on Linux by typing `sudo service docker start` in a terminal. 

3. Verify Docker by typing `sudo docker run hello-world` in a terminal. 

Congratulations, you have now Docker on your machine!
