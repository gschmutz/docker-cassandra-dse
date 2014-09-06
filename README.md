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


