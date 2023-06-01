#!/bin/sh
for bridge in $(sudo ovs-vsctl list-br)
do
    sudo ovs-ofctl del-flows $bridge
done

printf "Ops, Francisco ha rotto uno switch\n"

# Switch 1
printf "Switch 1\n"
sudo ovs-vsctl -- \
set port s1-eth1 qos=@newqos -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:1113=@1q  \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=500000

# Switch 2
printf "Switch 2\n"
sudo ovs-vsctl -- \
set port s2-eth1 qos=@newqos -- \
set port s2-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:1213=@1q \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000

# Switch 3
printf "\nSwitch 3\n"
sudo ovs-vsctl -- \
set port s3-eth1 qos=@newqos -- \
set port s3-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000000 \
queues:1413=@1q queues:1213=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=500000 -- \
--id=@2q create queue other-config:min-rate=1000000 other-config:max-rate=500000

# Switch 4
printf "\nSwitch 4\n"
sudo ovs-vsctl -- \
set port s4-eth3 qos=@newqos -- \
set port s4-eth4 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:1113=@1q queues:1413=@2q queues:1213=@3q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=1000000 -- \
--id=@3q create queue other-config:min-rate=100000 other-config:max-rate=1000000


# Creating links with new_src
printf "\n[INFO] Creating links..."

# Switch 1 ok
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.11,idle_timeout=0,actions=set_queue:1113,output:3
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=2,idle_timeout=0,actions=drop

# Switch 2
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.12,idle_timeout=0,actions=set_queue:1213,output:3
sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=2,idle_timeout=0,actions=drop

# Switch 3
sudo ovs-ofctl add-flow s3 ip,priority=65500,nw_src=10.0.0.11,idle_timeout=0,actions=set_queue:1113,output:1
sudo ovs-ofctl add-flow s3 ip,priority=65500,nw_src=10.0.0.12,idle_timeout=0,actions=set_queue:1213,output:1

sudo ovs-ofctl add-flow s3 ip,priority=65500,nw_src=10.0.0.14,idle_timeout=0,actions=set_queue:1413,output:1


#Switch 4 
sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.12,idle_timeout=0,actions=set_queue:1213,output:2
sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.14,idle_timeout=0,actions=set_queue:1413,output:2




