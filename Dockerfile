FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu18.04

# Core System 
RUN apt-get update && \
  apt-get -y install mesa-common-dev mesa-utils freeglut3-dev \
  curl locales lsb-release && \
  rm -rf /var/lib/apt/lists/*

ARG DEBIAN_FRONTEND=noninteractive

RUN dpkg-reconfigure locales

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

RUN apt update && \
  apt -y install ros-melodic-desktop-full  && \  
  rm -rf /var/lib/apt/lists/*

RUN apt update && \
  apt -y install python-catkin-pkg python-rosdep ros-melodic-catkin python-rosinstall \
  python-rosinstall-generator python-wstool build-essential  && \  
  rm -rf /var/lib/apt/lists/*

RUN rosdep init && \
  rosdep fix-permissions &&\
  rosdep update 

ENV ROS_DISTRO melodic
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

# ROS entry point
COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
RUN ["chmod", "+x", "/ros_entrypoint.sh"]

# Basic libraries for SMT 
RUN apt update && \ 
    apt -y install libgl1-mesa-glx libgl1-mesa-dri libgtk-3-dev \
    libcanberra-gtk-module libcanberra-gtk3-module default-jre \ 
    module-init-tools software-properties-common  nano \
    libglew-dev libgeographic17 libtinyxml2-6 libpugixml1v5 \
    libopencv-dev  liblas-dev libsoil-dev libglm-dev liblas-c-dev && \
    rm -rf /var/lib/apt/lists/*

RUN apt update && apt-get -y upgrade && \     
    apt -y install python3-pip ros-melodic-pcl-ros ros-melodic-cv-bridge \
    python3-colcon-common-extensions python3-setuptools python3-vcstool \     
    ros-melodic-lanelet2* && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip && pip3 install -U setuptools

# Autoware ROS dependencies 
RUN apt update && \
    apt -y install ros-melodic-nmea-msgs ros-melodic-velodyne* ros-melodic-jsk-visualization\    
    ros-melodic-automotive-* ros-melodic-grid-map-ros \
    ros-melodic-gps-common ros-melodic-lgsvl-msgs ros-melodic-geodesy \
    ros-melodic-rosbridge-server ros-melodic-velocity-controllers ros-melodic-imu-tools \ 
    ros-melodic-qpoases-vendor ros-melodic-uvc-camera ros-melodic-effort-controllers \
    ros-melodic-gscam ros-melodic-nmea-navsat-driver ros-melodic-vector-map* && \
    rm -rf /var/lib/apt/lists/*

# Setup the enviroment and startup commands for the ASSURE Mapping Tools binaries 
# Add assuremappingtools binaries into the image
COPY limited_ver/bin /assuremappingtools
ENV LD_LIBRARY_PATH=/assuremappingtools/libs:$LD_LIBRARY_PATH
ENV PATH=/assuremappingtools:$PATH
WORKDIR /assuremappingtools
CMD assure_map_editor