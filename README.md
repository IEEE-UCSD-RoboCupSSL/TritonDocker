# TritonsRCSC Docker Settings

## Building Images

It is recommended to build Docker on Ubuntu 20.04 for stability and faster speed.

```bash
docker build --rm -t tritonsrcsc/grsim:<version> -t tritonsrcsc/grsim .
docker build --rm -t tritonsrcsc/software .
```



## Pulling Images

```bash
docker pull tritonsrcsc/grsim
docker pull tritonsrcsc/software
```



## Running Docker Images

### With Network Isolation

```bash
docker-compose run -d --service-ports grsim vnc
docker-compose run software
```

The commands would, by default, run grSim in background and open up a bash for entering testing commands (e.g., `make test`). The two containers are under the same subset `173.18.0.0/16` with different IP addresses. The VFirms, TritonBots, and AI talk to each other under the same IP address. 

The network namespace is isolated from host's namespace, except the VNC port is mapped to `6900` on host's machine. The host can access grSim GUI by accessing `VNC://localhost:6900`. The default password is `vnc`. 

Remove `-d` (and run the second command in a new window) to also see grSim's output. Remove `vnc` to run grSim in headless's mode. After each test, use

```bash
docker-compose rm -fsv
```

to stop and remove all containers. The commands are validated on both macOS Mojave and Ubuntu 20.04.



### Without Network Isolation (not supported on non-Linux)

```bash
docker run --rm --network host --entrypoint bash -it -v $(pwd)/robot_config.json:/vfirm-config  tritonsrcsc/software
docker run --rm --network host -eVNC_PASSWORD=vnc -eVNC_GEOMETRY=1920x1080 tritonsrcsc/grsim vnc
```

The commands would run in the host machine's network namespace. It enables the user to, for example, run the grSim compiled on the host machine outside the container and control it using the software in the container. 

> Docker Desktop for Mac uses HyperKit instead of Virtual Box. Hyperkit is a lightweight macOS virtualization solution built on top of Hypervisor.framework in macOS 10.10 Yosemite and higher.

However, there is no docker0 bridge on macOS / Windows (https://docs.docker.com/network/host/) as the containers run on lightweight VMs. It is always recommended to run docker images on Ubuntu (even CentOS is not recommended) as it delivers the best performance by not virtualizing too much.

