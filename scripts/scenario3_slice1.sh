#!/bin/sh

# Switch 1
sudo ovs-ofctl add-flow s1 priority=65500,udp,ip,nw_dst=10.0.0.3,idle_timeout=0,actions=set_queue:123400,output:3
sudo ovs-ofctl add-flow s1 priority=65500,udp,ip,nw_dst=10.0.0.1,idle_timeout=0,actions=set_queue:123400,output:4

sudo ovs-ofctl add-flow s1 priority=65500,udp,in_port=4,idle_timeout=0,actions=set_queue:123400,output:2
sudo ovs-ofctl add-flow s1 priority=65500,udp,in_port=3,idle_timeout=0,actions=set_queue:123400,output:2

# Switch 2

# Switch 6
sudo ovs-ofctl add-flow s6 priority=65500,udp,ip,nw_dst=10.0.0.4,idle_timeout=0,actions=set_queue:123400,output:3
sudo ovs-ofctl add-flow s6 priority=65500,udp,ip,nw_dst=10.0.0.2,idle_timeout=0,actions=set_queue:123400,output:4

sudo ovs-ofctl add-flow s6 priority=65500,udp,in_port=4,idle_timeout=0,actions=set_queue:123400,output:2
sudo ovs-ofctl add-flow s6 priority=65500,udp,in_port=3,idle_timeout=0,actions=set_queue:123400,output:2

# Switch 7

