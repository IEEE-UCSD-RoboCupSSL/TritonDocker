# TritonsRCSC Docker Settings

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