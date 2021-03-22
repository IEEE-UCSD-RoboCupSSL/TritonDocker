# TritonsRCSC Docker Settings

## Linux

```
docker build --rm -t tritonsrcsc/grsim:2.3 -t tritonsrcsc/grsim .
docker build --rm -t tritonsrcsc/software .

docker run --rm --network host tritonsrcsc/software
docker run --rm --network host --entrypoint bash -it tritonsrcsc/software

docker run --rm --network host tritonsrcsc/grsim
docker run --rm --network host -eVNC_PASSWORD=vnc -eVNC_GEOMETRY=1920x1080 tritonsrcsc/grsim vnc

docker exec -it [container-id] bash
docker run -d
docker run --rm -it --entrypoint bash [image-name]
```



## Mac

```bash
docker pull tritonsrcsc/grsim
docker pull tritonsrcsc/software

docker network create --subnet=172.18.0.0/16 robocup
docker run --rm --network robocup --ip 172.18.0.2 -eVNC_PASSWORD=vnc -eVNC_GEOMETRY=1920x1080 -p 6900:5900 --name grsim tritonsrcsc/grsim vnc
docker run --rm --network robocup --ip 172.18.0.3 --entrypoint bash -it --name software tritonsrcsc/software
```

