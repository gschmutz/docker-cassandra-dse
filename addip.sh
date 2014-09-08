#!/bin/bash

IP_FILE=/opt/local/datastax/dse-4.5.1/resources/cassandra/conf/ip.txt
TEMPLATE_FILE=/opt/local/datastax/dse-4.5.1/resources/cassandra/conf/template.yaml
CONFIG=/opt/local/datastax/dse-4.5.1/resources/cassandra/conf/cassandra.yaml

cat /opt/local/datastax/dse-4.5.1/resources/cassandra/conf/lib.txt > $IP_FILE

LOCAL_IP=$(ifconfig eth0|grep addr:1|grep inet|awk '{print $2}'|cut -d':' -f2)
echo "listen_address: $LOCAL_IP" >> $IP_FILE

if [ -z "$SEEDS" ];
then
  SEED_IP=$LOCAL_IP
else
  SEED_IP=$SEEDS
fi

if [ -z "$SOLR" ];
then
  SOLR_OPTION=-s
else
  SOLR_OPTION=
fi

if [ -z "$SPARK" ];
then
  SPARK_OPTION=-s
else
  SPARK_OPTION=
fi


echo "seed_provider:                                                       
    - class_name: org.apache.cassandra.locator.SimpleSeedProvider            
      parameters:                                                               
          - seeds: "$SEED_IP"                    
" >> $IP_FILE

cat $TEMPLATE_FILE > $CONFIG
cat $IP_FILE >> $CONFIG

if [ -z "$MANUAL" ];
then
  /opt/local/datastax/dse-4.5.1/bin/dse cassandra -f $SPARK_OPTION $SOLR_OPTION
fi
