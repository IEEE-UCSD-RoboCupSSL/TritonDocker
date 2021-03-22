FROM tritonsrcsc/software

RUN sed -i 's/"127.0.0.1"/"172.18.0.2"/' Virtual-Firmware-grSim/robot_config.json