FROM ros:melodic

# Update ROS GPG Key
RUN \
 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654

# Disable interactive mode
ARG DEBIAN_FRONTEND=noninteractive

# Switch to Japanese server for installation speed
RUN sed -i 's|http://archive.|http://jp.archive.|g' /etc/apt/sources.list

# Install Docker GUI support
RUN \
  apt-get update && \
  apt-get -y install libgl1-mesa-glx libgl1-mesa-dri libgtk-3-dev libcanberra-gtk-module libcanberra-gtk3-module \
  mesa-utils xserver-xorg-video-all software-properties-common module-init-tools && \
  rm -rf /var/lib/apt/lists/*

# Install assuremappingtools required libraries
RUN \
  apt-get update && \
  apt-get -y install freeglut3 libglew2.0 libgeographic17 libtinyxml2-6 libpugixml1v5 \
  ros-melodic-pcl-ros libopencv-dev ros-melodic-cv-bridge ros-melodic-lanelet2* && \
  rm -rf /var/lib/apt/lists/*

# Add assuremappingtools binaries into the image
COPY ./bin /assuremappingtools

# Update OpenGL Library
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
  /usr/local/lib/x86_64-linux-gnu \
  /usr/local/lib/x86_64-linux-gnu

COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
  /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json \
  /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json

RUN echo '/usr/local/lib/x86_64-linux-gnu' >> /etc/ld.so.conf.d/glvnd.conf && \
    ldconfig && \
    echo '/usr/local/$LIB/libGL.so.1' >> /etc/ld.so.preload && \
    echo '/usr/local/$LIB/libEGL.so.1' >> /etc/ld.so.preload

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# Setup the enviroment and startup commands
ENV LD_LIBRARY_PATH=/assuremappingtools/libs:$LD_LIBRARY_PATH
ENV PATH=/assuremappingtools:$PATH
WORKDIR /assuremappingtools
CMD assure_map_editor
