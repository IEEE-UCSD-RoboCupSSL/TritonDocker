FROM ubuntu:20.04 AS build
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    git build-essential cmake pkg-config qt5-default \
    libqt5opengl5-dev libgl1-mesa-dev libglu1-mesa-dev \
    libprotobuf-dev protobuf-compiler libode-dev libboost-dev

WORKDIR /vartypes
RUN git clone https://github.com/jpfeltracco/vartypes.git . && \
    git checkout 2d16e81b7995f25c5ba5e4bc31bf9a514ee4bc42 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# Clone grSim
RUN cd / && git clone https://github.com/RoboCup-SSL/grSim.git
WORKDIR /grSim
COPY Triton.ini config
RUN git reset --hard 0881829e3918a20ff753af72f80f819d5bf7ea4f && \
    sed -i 's/, 11, "Robots Count"/, 6, "Robots Count"/' src/configwidget.cpp && \
    sed -i 's/"Parsian"/"Triton"/' src/configwidget.cpp && \
    sed -i 's/"Division A", "Division"/"Division B", "Division"/' src/configwidget.cpp && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    make && \
    make install

FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive \
    LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib

RUN apt-get update && apt-get install -y \
    qt5-default \
    libqt5opengl5 \
    libode8 \
    libprotobuf17 \
    # virtual display and VNC server
    x11vnc xvfb && \
    apt-get clean -y
COPY --from=build /usr/local /usr/local

RUN useradd -ms /bin/bash default
COPY docker-entry.sh .
RUN chmod 775 /docker-entry.sh

EXPOSE 10300/udp 10301/udp 10302/udp 20011/udp 30011/udp 30012/udp 5900/udp
USER default
WORKDIR /home/default
ENTRYPOINT ["/docker-entry.sh"]
