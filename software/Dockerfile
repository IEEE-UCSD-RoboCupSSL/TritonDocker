FROM ubuntu:20.04 AS build

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    git cmake libprotobuf-dev protobuf-compiler libode-dev libboost-all-dev \
    maven openjdk-14-jdk libarmadillo-dev clang

# Compilation
RUN git clone https://github.com/IEEE-UCSD-RoboCupSSL/TritonsRCSC-Software-Pack.git && \
    cd TritonsRCSC-Software-Pack && make install && \
    git -C TritonSoccerAI reset --hard d6a4a40eac7fbab1c7ce54bdc6bea77be651576f && \
    git -C TritonBot      reset --hard 09f95a97a5af7a19a0c6f2eaba9143ac232efb3a && \
    sed -i 's/"robot_config.json"/"\/vfirm-config"/' Virtual-Firmware-grSim/main.cpp && \
    make init && make all

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    make git psmisc python3 libprotobuf-dev libode-dev libboost-all-dev libarmadillo-dev openjdk-14-jre && \
    git clone https://github.com/IEEE-UCSD-RoboCupSSL/TritonsRCSC-Software-Pack.git && \
    apt-get purge -y git && apt-get autoremove -y && apt-get clean -y

WORKDIR /TritonsRCSC-Software-Pack
COPY --from=build /TritonsRCSC-Software-Pack/TritonSoccerAI/target/*.jar \
    TritonSoccerAI/target/
COPY --from=build /TritonsRCSC-Software-Pack/TritonBot/build TritonBot/build
COPY --from=build /TritonsRCSC-Software-Pack/Virtual-Firmware-grSim/vfirm.exe \
    Virtual-Firmware-grSim/vfirm.exe

ENTRYPOINT ["python3", "TestScripts/test.py"]

