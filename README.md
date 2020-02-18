![Assure logo](https://user-images.githubusercontent.com/20182801/61394821-fb224f00-a8fe-11e9-82d5-6e008df6710e.png)
![banner](https://user-images.githubusercontent.com/20182801/61394945-3e7cbd80-a8ff-11e9-8930-f827ef2cfd69.png)
# ASSURE maping tools
Desktop based tool for viewing, editing and saving road network maps for autonomous vehicle platforms such as Autoware.

### Operating System

- Ubuntu 16.04
- [Ununtu 18.04](https://github.com/hatem-darweesh/assuremapingtools/wiki)

### Prerequisites libraries: 

- tinyxml, glut, glew, pcl, 
- for lanelet2 extention: libpugixml, libgeographic

### GPU acceleration 
- The editor works faster with GPU accelerator specially for large maps

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
- [Video Tutorials](https://www.youtube.com/watch?v=p_4HwJvu084&list=PLVAImlqqGbr4G8GXMsqp6dMhbKxTCEnrh&index=1)
- [Video Tutorials V0.2](https://youtu.be/PXcE7XMSKck)

### Known Issues
- Lanelet2 loading and saving, only UTM projection is used with GPS lat/lon origin. 
- Projection string is not utilized yet.
- No support for multi-storey parking maps yet.
