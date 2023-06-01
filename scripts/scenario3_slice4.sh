#!/bin/sh

# Switch 1


# Switch 2
sudo ovs-ofctl add-flow s2 priority=65500,icmp,ip,nw_dst=10.0.0.7,idle_timeout=0,actions=set_queue:567801,output:3
sudo ovs-ofctl add-flow s2 priority=65500,icmp,ip,nw_dst=10.0.0.5,idle_timeout=0,actions=set_queue:567801,output:4
sudo ovs-ofctl add-flow s2 priority=65500,tcp,ip,nw_dst=10.0.0.7,idle_timeout=0,actions=set_queue:567801,output:3
sudo ovs-ofctl add-flow s2 priority=65500,tcp,ip,nw_dst=10.0.0.5,idle_timeout=0,actions=set_queue:567801,output:4

#icmp
sudo ovs-ofctl add-flow s2 priority=65500,icmp,in_port=4,idle_timeout=0,actions=set_queue:567801,output:2
sudo ovs-ofctl add-flow s2 priority=65500,icmp,in_port=3,idle_timeout=0,actions=set_queue:567801,output:2

#tcp
sudo ovs-ofctl add-flow s2 priority=65500,tcp,in_port=4,idle_timeout=0,actions=set_queue:567801,output:2
sudo ovs-ofctl add-flow s2 priority=65500,tcp,in_port=3,idle_timeout=0,actions=set_queue:567801,output:2

# Switch 6


# Switch 7
sudo ovs-ofctl add-flow s7 priority=65500,icmp,ip,nw_dst=10.0.0.8,idle_timeout=0,actions=set_queue:567801,output:3
sudo ovs-ofctl add-flow s7 priority=65500,icmp,ip,nw_dst=10.0.0.6,idle_timeout=0,actions=set_queue:567801,output:4
sudo ovs-ofctl add-flow s7 priority=65500,tcp,ip,nw_dst=10.0.0.8,idle_timeout=0,actions=set_queue:567801,output:3
sudo ovs-ofctl add-flow s7 priority=65500,tcp,ip,nw_dst=10.0.0.6,idle_timeout=0,actions=set_queue:567801,output:4

#icmp
sudo ovs-ofctl add-flow s7 priority=65500,icmp,in_port=4,idle_timeout=0,actions=set_queue:567801,output:2
sudo ovs-ofctl add-flow s7 priority=65500,icmp,in_port=3,idle_timeout=0,actions=set_queue:567801,output:2

#tcp
sudo ovs-ofctl add-flow s7 priority=65500,tcp,in_port=4,idle_timeout=0,actions=set_queue:567801,output:2
sudo ovs-ofctl add-flow s7 priority=65500,tcp,in_port=3,idle_timeout=0,actions=set_queue:567801,output:2

