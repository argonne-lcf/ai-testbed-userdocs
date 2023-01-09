
HOST1=`ifconfig eno1 | grep "inet " | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | head -1`
OCT123=`echo "$HOST1" | cut -d "." -f 1,2,3`
OCT4=`echo "$HOST1" | cut -d "." -f 4`
HOST2=$OCT123.`expr $OCT4 + 1`
HOST3=$OCT123.`expr $OCT4 + 2`
HOST4=$OCT123.`expr $OCT4 + 3`
export HOSTS=$HOST1,$HOST2,$HOST3,$HOST4
export IPUOF_VIPU_API_PARTITION_ID=p64
export TCP_IF_INCLUDE=$OCT123.0/8
export IPUOF_VIPU_API_HOST=$HOST1
echo $HOSTS
echo $IPUOF_VIPU_API_PARTITION_ID
echo $TCP_IF_INCLUDE
echo $IPUOF_VIPU_API_HOST
