Docker build for DSE cassandra

There are three ways in which dse cassandra can be installed using this docker build.

- Copy dse.tar.gz from local folder

- Download dse.tar.gz from a host webserver

- Download dse.tar.gz from datastax download

Build dse cassandra using the Dockerfile
```
docker build -t skhatri/dse-cassandra .
```

To run an instance of dse cassandra 

```
docker run -d -p 9160:9160 -t skhatri/dse-cassandra 
```

Set port forwarding for VirtualBox for environments using boot2docker

```
VBoxManage modifyvm "boot2docker-vm" --natpf1 "dse-node1,tcp,127.0.0.1,9260,,9160"

```
The above creates a port forwarding rule so that the host listens on 9260 forwarding to a docker instance running on port 9160


From the host system, you can invoke a cqlsh or use drivers to connect to cassandra using
```
cqlsh localhost 9260
```

More nodes can be run using the docker run command and the VBoxManage command to expose the service to the host system.


Running a multinode cluster using docker containers

- Start first node as seed
```
docker run -d -p 9160:9160 -p 9042:9042 -p 7199:7199 -t skhatri/cassandra
```

- Find the node with 9160 and treat it as seed and start another instance
```
docker run -d -p 9260:9160 -e SEEDS=$(docker inspect `docker ps -a |grep 9160\-\>9160|awk '{print $1}'`|grep 172|grep IP|awk '{print $2}'|cut -d',' -f1) -t skhatri/cassandra
```
- Start third instance of cassandra
```
docker run -d -e SEEDS=$(docker inspect `docker ps -a |grep 9160\-\>9160|awk '{print $1}'`|grep 172|grep IP|awk '{print $2}'|cut -d',' -f1) -t skhatri/cassandra
```

