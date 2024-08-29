<img src="https://user-images.githubusercontent.com/20182801/61394945-3e7cbd80-a8ff-11e9-8930-f827ef2cfd69.png"> 
<p align="center">
<a href="https://zatitech.com" target="_blank"> <img  src="https://user-images.githubusercontent.com/20182801/93010360-b52a4f00-f5c6-11ea-8649-ecec117e5f7f.png" class="center" width="300"> </a>
</p>
<img  src="https://user-images.githubusercontent.com/20182801/61394821-fb224f00-a8fe-11e9-82d5-6e008df6710e.png" width="200" >


# ASSURE mapping tools
Desktop based tool for viewing, editing and saving road network maps for autonomous vehicle platforms such as Autoware.

### Operating System (Validated)
- Ubuntu 18.04
- Ubuntu 22.04 
- Windows 10 with Docker and WSL

### Docker installation (Ubuntu)
On the host: 
1. Install [Docker](https://docs.docker.com/desktop/install/ubuntu/#install-docker-desktop).
2. Test docker works by following the helloworld tutorial. 
3. Install [nvidia container toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/1.14.5/install-guide.html). 
4. Test that you have access to nvidia from docker by running either (glxgears or nvidia-smi)
5. You might need to install the following on the host:
```
sudo apt install mesa-utils
```

### Docker installation (Windows 10)
On the host: 
1. Install PowerShell from Microsoft Store. Will be used to run Docker command in the following steps.
2. Install [Docker](https://docs.docker.com/desktop/install/windows-install/).
3. Start Docker Desktop from the start menu. 
3. Test docker works by following the helloworld tutorial. 

### Before Docker Build 
Set your data folders by modifying the followiing in the docker compose yaml file
```
- /home/user/data:/root/data
```
### Important for Windows: 
On Windows you need to make sure the "ros_entrypoint.sh" End of Line Sequence is actually "LF" not "CRLF". Can be modified from VSCode. Change CRLF to LF then save the file. 


### Build Docker Image (Ubuntu): 
```
docker compose -f docker-compose-linux-app-nvidia.yaml build
```

### Build Docker Image (Windows): 
```
docker compose -f docker-compose-windows-wsl-app.yaml build
```

### Start ASSURE SMT (Ubuntu): 
```
xhost + local:
docker compose -f docker-compose-linux-app-nvidia.yaml up
```

### Start ASSURE SMT (Windows): 
```
docker compose -f docker-compose-windows-wsl-app.yaml up
```

### Supported Roadnetwork Map formates (Load)
- [OpenPlanner](https://gitlab.com/autowarefoundation/autoware.ai/core_planning) map format .kml 
- Signle path file .csv 
- Vector Map, collection of .csv files composing the map
- [OpenDRIVE](http://www.opendrive.org/), is open file format for the logical description of road networks .xodr
- [Lanelet2](https://github.com/fzi-forschungszentrum-informatik/Lanelet2), map format .osm, with autoware extention

### Supported Roadnetwork Map formates (Save)
- [OpenPlanner](https://gitlab.com/autowarefoundation/autoware.ai/core_planning) map format .kml 
- Google Earth .kml format, if only the loaded vector map has GPS information.
- [Lanelet2](https://github.com/fzi-forschungszentrum-informatik/Lanelet2), map format .osm

### Supported Pointcloud data
- pointcloud map .pcd files
- rosbag of (LIDAR, Camera, Pose) .bag files _comming soon_

### Supported Map Semantics
- Lanes
- Waypoints
- Road lines
- Traffic Lights
- Stop Lines
- Traffic Sign 
- Road Boundaries
- Crossings 

### Tutorials
- [Video Tutorials V0.5](https://youtu.be/lignj-gVGVg)
- [Video Tutorials V0.2](https://youtu.be/PXcE7XMSKck)
- [Older Video Tutorials](https://www.youtube.com/watch?v=p_4HwJvu084&list=PLVAImlqqGbr4G8GXMsqp6dMhbKxTCEnrh&index=1)

## New features
- New OpenDRIVE parser
- ASSURE map editor save the projection data with the .kml and .osm files to be use when the map is loaded. 
- Accurate conversion from vector map to lanelet2 is available. use should find the projection string for the ptoj library online. 
- This [website](https://spatialreference.org/ref/epsg/2449/) provides prepared projection string, if you select [Proj4js format](https://spatialreference.org/ref/epsg/2449/proj4js/). you will get this string which represent central Japan area.
- Documentation document is uploaded

### Known Issues
- No support for multi-storey parking maps yet.
- Exporting traffic lights and signs to lanelet2 require connection all Ids correctly between light-lane-stopline. 
