#!/bin/sh


# cre odue queue in switch 1
printf "Switch 1:\n"
sudo ovs-vsctl -- \
set port s1-eth1 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000 \
queues:12=@1q queues:34=@2q -- \
--id=@1q create queue other-config:min-rate=100 other-config:max-rate=500 -- \
--id=@2q create queue other-config:min-rate=100 other-config:max-rate=500

echo ' '

# cre odue queue in switch 2
printf "Switch 2:\n"
sudo ovs-vsctl -- \
set port s2-eth1 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000 \
queues:12=@1q queues:34=@2q -- \
--id=@1q create queue other-config:min-rate=100 other-config:max-rate=500 -- \
--id=@2q create queue other-config:min-rate=100 other-config:max-rate=500

# cre odue queue in switch 3
printf "Switch 3:\n"
sudo ovs-vsctl -- \
set port s1-eth1 qos=@newqos -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000 \
queues:12=@1q queues:34=@2q -- \
--id=@1q create queue other-config:min-rate=100 other-config:max-rate=500 -- \
--id=@2q create queue other-config:min-rate=100 other-config:max-rate=500

echo ' '

echo '*** End of Creating the Slices ...'
echo ' ---------------------------------------------- '




sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,nw_dst=10.0.0.2,idle_timeout=0,actions=set_queue:12,normal
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.3,nw_dst=10.0.0.4,idle_timeout=0,actions=set_queue:34,normal
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.2,nw_dst=10.0.0.1,idle_timeout=0,actions=set_queue:12,normal
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.4,nw_dst=10.0.0.3,idle_timeout=0,actions=set_queue:34,normal

sudo ovs-ofctl add-flow s3 ip,priority=65500,nw_src=10.0.0.1,nw_dst=10.0.0.2,idle_timeout=0,actions=set_queue:12,normal
sudo ovs-ofctl add-flow s3 ip,priority=65500,nw_src=10.0.0.3,nw_dst=10.0.0.4,idle_timeout=0,actions=set_queue:34,normal
sudo ovs-ofctl add-flow s3 ip,priority=65500,nw_src=10.0.0.2,nw_dst=10.0.0.1,idle_timeout=0,actions=set_queue:12,normal
sudo ovs-ofctl add-flow s3 ip,priority=65500,nw_src=10.0.0.4,nw_dst=10.0.0.3,idle_timeout=0,actions=set_queue:34,normal


