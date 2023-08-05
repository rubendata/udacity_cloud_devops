### build the docker image with build argument
docker build -t helloapp:v3 -f Dockerfile . --build-arg STAGE="DEV"

### get the docker image id
docker images

### run the container with env. argument
docker run -e ACCOUNT="Micky" 6788a79fae4d     



### login to ECR AWS
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 006712159429.dkr.ecr.us-east-1.amazonaws.com
