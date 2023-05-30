#!/bin/sh

# Switch 1
sudo ovs-ofctl add-flow s1 priority=65500,icmp,ip,nw_dst=10.0.0.3,idle_timeout=0,actions=set_queue:123401,output:3
sudo ovs-ofctl add-flow s1 priority=65500,icmp,ip,nw_dst=10.0.0.1,idle_timeout=0,actions=set_queue:123401,output:4
sudo ovs-ofctl add-flow s1 priority=65500,tcp,ip,nw_dst=10.0.0.3,idle_timeout=0,actions=set_queue:123401,output:3
sudo ovs-ofctl add-flow s1 priority=65500,tcp,ip,nw_dst=10.0.0.1,idle_timeout=0,actions=set_queue:123401,output:4

#icmp
sudo ovs-ofctl add-flow s1 priority=65500,icmp,in_port=4,idle_timeout=0,actions=set_queue:123401,output:1
sudo ovs-ofctl add-flow s1 priority=65500,icmp,in_port=3,idle_timeout=0,actions=set_queue:123401,output:1

#tcp
sudo ovs-ofctl add-flow s1 priority=65500,tcp,in_port=4,idle_timeout=0,actions=set_queue:123401,output:1
sudo ovs-ofctl add-flow s1 priority=65500,tcp,in_port=3,idle_timeout=0,actions=set_queue:123401,output:1


# Switch 2

# Switch 6
sudo ovs-ofctl add-flow s6 priority=65500,icmp,ip,nw_dst=10.0.0.4,idle_timeout=0,actions=set_queue:123401,output:3
sudo ovs-ofctl add-flow s6 priority=65500,icmp,ip,nw_dst=10.0.0.2,idle_timeout=0,actions=set_queue:123401,output:4
sudo ovs-ofctl add-flow s6 priority=65500,tcp,ip,nw_dst=10.0.0.4,idle_timeout=0,actions=set_queue:123401,output:3
sudo ovs-ofctl add-flow s6 priority=65500,tcp,ip,nw_dst=10.0.0.2,idle_timeout=0,actions=set_queue:123401,output:4

#icmp
sudo ovs-ofctl add-flow s6 priority=65500,icmp,in_port=4,idle_timeout=0,actions=set_queue:123401,output:1
sudo ovs-ofctl add-flow s6 priority=65500,icmp,in_port=3,idle_timeout=0,actions=set_queue:123401,output:1

#tcp
sudo ovs-ofctl add-flow s6 priority=65500,tcp,in_port=4,idle_timeout=0,actions=set_queue:123401,output:1
sudo ovs-ofctl add-flow s6 priority=65500,tcp,in_port=3,idle_timeout=0,actions=set_queue:123401,output:1

# Switch 7
