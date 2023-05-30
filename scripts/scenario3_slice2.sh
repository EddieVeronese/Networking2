#!/bin/sh

# Switch 1

# Switch 2
sudo ovs-ofctl add-flow s2 priority=65500,udp,ip,nw_dst=10.0.0.7,idle_timeout=0,actions=set_queue:567800,output:3
sudo ovs-ofctl add-flow s2 priority=65500,udp,ip,nw_dst=10.0.0.5,idle_timeout=0,actions=set_queue:567800,output:4

sudo ovs-ofctl add-flow s2 priority=65500,udp,in_port=4,idle_timeout=0,actions=set_queue:567800,output:1
sudo ovs-ofctl add-flow s2 priority=65500,udp,in_port=3,idle_timeout=0,actions=set_queue:567800,output:1

# Switch 6

# Switch 7
sudo ovs-ofctl add-flow s7 priority=65500,udp,ip,nw_dst=10.0.0.8,idle_timeout=0,actions=set_queue:567800,output:3
sudo ovs-ofctl add-flow s7 priority=65500,udp,ip,nw_dst=10.0.0.6,idle_timeout=0,actions=set_queue:567800,output:4

sudo ovs-ofctl add-flow s7 priority=65500,udp,in_port=4,idle_timeout=0,actions=set_queue:567800,output:1
sudo ovs-ofctl add-flow s7 priority=65500,udp,in_port=3,idle_timeout=0,actions=set_queue:567800,output:1