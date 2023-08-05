### build the docker image with build argument
docker build -t helloapp:v3 -f Dockerfile . --build-arg STAGE="DEV"

### get the docker image id
docker images

### run the container with env. argument
docker run -e ACCOUNT="Micky" 6788a79fae4d     