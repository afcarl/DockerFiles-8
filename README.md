# Docker file to create image for GET training


## Install docker

Instructions here: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
You may need to reboot your system after installation

## Install nvidia-docker

Instructions here: https://github.com/NVIDIA/nvidia-docker


## For nvidia docker to work, make sure you have nvidia drivers

To check your driver versions:

	cat /proc/driver/nvidia/version

To install nvidia drivers:

	http://www.linuxandubuntu.com/home/how-to-install-latest-nvidia-drivers-in-linux


## Create image

	docker build -t <image_name> .

## Docker cheatsheet

Stop / remove all containers

	docker stop $(docker ps -a -q)
	docker rm $(docker ps -a -q)

Access container with jupyter

	docker run -p 6006:6006 -p 8888:8888 -v /home/stuff/:/home/stuff jupyter notebook --ip 0.0.0.0 --allow-root

Find out existing images

	docker images

Find out running containers

	docker ps -a -f status=running

Create new image from existing one

	docker commit --message "Extra python packages" <existing IMAGE ID> <new_image_name>


Run and jump to interactive seesion

	docker run -it <image name>

Delete container upon exit

	docker run -it --rm <image_name>

Mount local folder to docker image

	docker run -it -v <path_on_local_system>:<path_on_local_image> <image name>


To run with GPU enabled:

	nvidia-docker run XXX