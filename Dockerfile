FROM ros:melodic

# Disable interactive mode
ARG DEBIAN_FRONTEND=noninteractive

# Switch to Japanese server for installation speed
RUN sed -i 's|http://archive.|http://jp.archive.|g' /etc/apt/sources.list

# Install prerequisite libraries
RUN \
  apt-get update && \
  apt-get -y install libgl1-mesa-glx libgl1-mesa-dri libgtk-3-dev libcanberra-gtk-module libcanberra-gtk3-module mesa-utils xserver-xorg-video-all software-properties-common \
  binutils build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev \
  libpng-dev libtiff-dev libdc1394-22-dev libtinyxml-dev freeglut3 libglew-dev libpcl1 libpugixml-dev libgeographic-dev libplib-dev libglm-dev module-init-tools \
  ros-melodic-pcl-ros libopencv-dev ros-melodic-cv-bridge && \
  rm -rf /var/lib/apt/lists/*

# Adding Nvidia Support
ADD NVIDIA-DRIVER.run /tmp/NVIDIA-DRIVER.run
RUN sh /tmp/NVIDIA-DRIVER.run -a -N --ui=none --no-kernel-module
RUN rm /tmp/NVIDIA-DRIVER.run

# Setup the enviroment and startup commands
ENV LD_LIBRARY_PATH=/data/libs:$LD_LIBRARY_PATH
ENV PATH=/data:$PATH
WORKDIR /data
CMD assure_map_editor
