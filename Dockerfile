FROM skhatri/dev-base


MAINTAINER Suresh Khatri, kc2005au@gmail.com

#Put your datastax registration info here.
#Either get from Datastax
#RUN wget http://user:password@downloads.datastax.com/enterprise/dse-4.5.1-bin.tar.gz -O /tmp/dse-4.5.1-bin.tar.gz
#Use local server to work with already downloaded dse
#RUN wget http://10.1.1.19:8900/dse-4.5.1-bin.tar.gz -O /tmp/dse-4.5.1-bin.tar.gz

#Download to local and use to tmp of the container
COPY dse-4.5.1-bin.tar.gz /tmp/

RUN mkdir -p /opt/local/datastax && cd /opt/local/datastax && tar zxf /tmp/dse-4.5.1-bin.tar.gz

COPY lib.txt /opt/local/datastax/dse-4.5.1/resources/cassandra/conf/
COPY cassandra.yaml /opt/local/datastax/dse-4.5.1/resources/cassandra/conf/template.yaml
RUN cat /opt/local/datastax/dse-4.5.1/resources/cassandra/conf/template.yaml > /opt/local/datastax/dse-4.5.1/resources/cassandra/conf/cassandra.yaml
RUN cat /opt/local/datastax/dse-4.5.1/resources/cassandra/conf/lib.txt >> /opt/local/datastax/dse-4.5.1/resources/cassandra/conf/cassandra.yaml
COPY addip.sh /opt/local/datastax/dse-4.5.1/resources/cassandra/conf/

RUN rm -rf /tmp/dse-4.5.1-bin.tar.gz

EXPOSE 9042 9160 7199 7000

ENV DSE_HOME /opt/local/datastax/dse-4.5.1

ENV PATH $DSE_HOME/bin:$PATH

CMD ["/opt/local/datastax/dse-4.5.1/resources/cassandra/conf/addip.sh"]
