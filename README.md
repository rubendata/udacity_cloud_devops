### Project Title - Deploy a high-availability web app using CloudFormation
This project contains the code how to deploy a high available, fault tolerant, secure and scalable web application.


#### network.yml
Contains the code for deploying the network with Cloudformation.

#### network-parameters.json
Contains parameters for the network vpc and subnet cidrs

#### udagram.yml
Contains the code for deploying the web application

#### udagram-params.json
Contains parameters for s3

#### How to deploy the application

./run.sh deploy us-east-1 network network.yml network-params.json
./run.sh deploy us-east-1 udagram udagram.yml udagram-params.json

#### How to access the application
http://udagr-loadb-hv2kj4cixjec-2108116464.us-east-2.elb.amazonaws.com/
it should return "Udacity Demo Web Server Up and Running!"