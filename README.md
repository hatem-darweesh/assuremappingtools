![Assure logo](https://user-images.githubusercontent.com/20182801/61394821-fb224f00-a8fe-11e9-82d5-6e008df6710e.png)
![banner](https://user-images.githubusercontent.com/20182801/61394945-3e7cbd80-a8ff-11e9-8930-f827ef2cfd69.png)
# ASSURE maping tools
Desktop based tool for viewing, editing and saving road network maps for autonomous vehicle platforms such as Autoware.

### Operating System

- Ubuntu 16.04

### Prerequisites libraries: 

- tinyxml, glut, glew, pcl

### GPU acceleration 
- The editor works faster with GPU accelerator specially for large maps

### Supported Roadnetwork Map formates 
- [OpenPlanner](https://gitlab.com/autowarefoundation/autoware.ai/core_planning) map format .kml 
- Signle path file .csv 
- Vector Map, collection of .csv files composing the map
- [OpenDRIVE](http://www.opendrive.org/), is open file format for the logical description of road networks .xodr
- [Lanelet](https://github.com/fzi-forschungszentrum-informatik/Lanelet2), _comming soon_

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
