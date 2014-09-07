IP_FILE=/opt/local/datastax/dse-4.5.1/resources/cassandra/conf/ip.txt
TEMPLATE_FILE=/opt/local/datastax/dse-4.5.1/resources/cassandra/conf/template.yaml
CONFIG=/opt/local/datastax/dse-4.5.1/resources/cassandra/conf/cassandra.yaml

cat /opt/local/datastax/dse-4.5.1/resources/cassandra/conf/lib.txt > $IP_FILE

echo "listen_address: $(ifconfig eth0|grep addr:1|grep inet|awk '{print $2}'|cut -d':' -f2)" >> $IP_FILE

echo "seed_provider:                                                       
    - class_name: org.apache.cassandra.locator.SimpleSeedProvider            
      parameters:                                                               
          - seeds: "$(ifconfig eth0|grep addr:1|grep inet|awk '{print $2}'|cut -d':' -f2)"                    
" >> $IP_FILE

cat $TEMPLATE_FILE > $CONFIG
cat $IP_FILE >> $CONFIG

dse cassandra -f
