#!/bin/sh
# Deny all hosts to communicate with each other

#s1
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,nw_dst=10.0.0.2,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,nw_dst=10.0.0.3,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,nw_dst=10.0.0.4,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,nw_dst=10.0.0.5,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,nw_dst=10.0.0.6,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,nw_dst=10.0.0.7,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,nw_dst=10.0.0.8,idle_timeout=0,actions=drop

sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.3,nw_dst=10.0.0.1,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.3,nw_dst=10.0.0.2,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.3,nw_dst=10.0.0.4,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.3,nw_dst=10.0.0.5,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.3,nw_dst=10.0.0.6,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.3,nw_dst=10.0.0.7,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.3,nw_dst=10.0.0.8,idle_timeout=0,actions=drop

#s2
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.5,nw_dst=10.0.0.1,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.5,nw_dst=10.0.0.2,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.5,nw_dst=10.0.0.3,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.5,nw_dst=10.0.0.4,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.5,nw_dst=10.0.0.6,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.5,nw_dst=10.0.0.7,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.5,nw_dst=10.0.0.8,idle_timeout=0,actions=drop

sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.7,nw_dst=10.0.0.1,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.7,nw_dst=10.0.0.2,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.7,nw_dst=10.0.0.3,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.7,nw_dst=10.0.0.4,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.7,nw_dst=10.0.0.5,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.7,nw_dst=10.0.0.6,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.7,nw_dst=10.0.0.8,idle_timeout=0,actions=drop

#s6
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.2,nw_dst=10.0.0.1,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.2,nw_dst=10.0.0.3,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.2,nw_dst=10.0.0.4,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.2,nw_dst=10.0.0.5,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.2,nw_dst=10.0.0.6,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.2,nw_dst=10.0.0.7,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.2,nw_dst=10.0.0.8,idle_timeout=0,actions=drop

sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.4,nw_dst=10.0.0.1,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.4,nw_dst=10.0.0.2,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.4,nw_dst=10.0.0.3,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.4,nw_dst=10.0.0.5,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.4,nw_dst=10.0.0.6,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.4,nw_dst=10.0.0.7,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.4,nw_dst=10.0.0.8,idle_timeout=0,actions=drop

#s7
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.6,nw_dst=10.0.0.1,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.6,nw_dst=10.0.0.2,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.6,nw_dst=10.0.0.3,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.6,nw_dst=10.0.0.4,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.6,nw_dst=10.0.0.5,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.6,nw_dst=10.0.0.7,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.6,nw_dst=10.0.0.8,idle_timeout=0,actions=drop

sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.8,nw_dst=10.0.0.1,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.8,nw_dst=10.0.0.2,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.8,nw_dst=10.0.0.3,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.8,nw_dst=10.0.0.4,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.8,nw_dst=10.0.0.5,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.8,nw_dst=10.0.0.6,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.8,nw_dst=10.0.0.7,idle_timeout=0,actions=drop




#s1
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=1,nw_dst=10.0.0.1,idle_timeout=0,actions=output:4,normal
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=2,nw_dst=10.0.0.3,idle_timeout=0,actions=output:3,normal

#s2
sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=1,nw_dst=10.0.0.5,idle_timeout=0,actions=output:4,normal
sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=2,nw_dst=10.0.0.7,idle_timeout=0,actions=output:3,normal

#s6
sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=1,nw_dst=10.0.0.2,idle_timeout=0,actions=output:4,normal
sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=2,nw_dst=10.0.0.4,idle_timeout=0,actions=output:3,normal

#s7
sudo ovs-ofctl add-flow s7 ip,priority=65500,in_port=1,nw_dst=10.0.0.6,idle_timeout=0,actions=output:4,normal
sudo ovs-ofctl add-flow s7 ip,priority=65500,in_port=2,nw_dst=10.0.0.8,idle_timeout=0,actions=output:3,normal

#s3
sudo ovs-ofctl add-flow s3 ip,priority=65500,in_port=1,nw_dst=10.0.0.2,idle_timeout=0,actions=output:2,normal
sudo ovs-ofctl add-flow s3 ip,priority=65500,in_port=2,nw_dst=10.0.0.1,idle_timeout=0,actions=output:1,normal

#s4
sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=1,nw_dst=10.0.0.4,idle_timeout=0,actions=output:2,normal
sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=2,nw_dst=10.0.0.3,idle_timeout=0,actions=output:1,normal
sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=3,nw_dst=10.0.0.5,idle_timeout=0,actions=output:4,normal
sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=4,nw_dst=10.0.0.6,idle_timeout=0,actions=output:3,normal

#s5
sudo ovs-ofctl add-flow s5 ip,priority=65500,in_port=1,nw_dst=10.0.0.8,idle_timeout=0,actions=output:2,normal
sudo ovs-ofctl add-flow s5 ip,priority=65500,in_port=2,nw_dst=10.0.0.7,idle_timeout=0,actions=output:1,normal