#!/bin/sh

sudo ovs-vsctl set port s1-eth1 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=10000000 \
queues:1=@1q -- \
--id=@1q create queue other-config:min-rate=1000000 other-config:max-rate=5000000

sudo ovs-vsctl set port s2-eth1 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=10000000 \
queues:1=@1q -- \
--id=@1q create queue other-config:min-rate=1000000 other-config:max-rate=5000000 

#mapping s1 queues to hosts (h1 - h6,h7,h8)
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,nw_dst=10.0.0.6,idle_timeout=0,actions=set_queue:1,normal
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,nw_dst=10.0.0.7,idle_timeout=0,actions=set_queue:1,normal
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,nw_dst=10.0.0.8,idle_timeout=0,actions=set_queue:1,normal

#mapping s2 queues to hosts (h6,h7,h8 - h1)
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.6,nw_dst=10.0.0.1,idle_timeout=0,actions=set_queue:1,normal
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.6,nw_dst=10.0.0.7,idle_timeout=0,actions=set_queue:1,normal
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.6,nw_dst=10.0.0.8,idle_timeout=0,actions=set_queue:1,normal
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.7,nw_dst=10.0.0.1,idle_timeout=0,actions=set_queue:1,normal
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.7,nw_dst=10.0.0.6,idle_timeout=0,actions=set_queue:1,normal
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.7,nw_dst=10.0.0.8,idle_timeout=0,actions=set_queue:1,normal
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.8,nw_dst=10.0.0.1,idle_timeout=0,actions=set_queue:1,normal
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.8,nw_dst=10.0.0.6,idle_timeout=0,actions=set_queue:1,normal
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.8,nw_dst=10.0.0.7,idle_timeout=0,actions=set_queue:1,normal