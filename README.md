# techo-jenkins
Dockerized jenkins tool


#### How to build a new image 

- Checkout repo and cd to its dir
- Build the Image :  

`Docker build -t jenkins .`
   
   
#### Create a new Jenkins Container on a Docker Host

- Container creation
    - create named volume for container: `docker volume create --name YOURVOLUMENAME`
    - create container: 
        `docker create -p YOURLOCALPORT:8080 -p SLAVEPORT:50000 --name CONTAINERNAME -v YOURVOLUMENAME:/opt/jenkins IMAGENAME`
    - start container: `docker start CONTAINERNAME`
    - Open the Browser console : http://HOSTNAME:8080
