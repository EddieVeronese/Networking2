#!/bin/sh
for bridge in $(sudo ovs-vsctl list-br)
do
    sudo ovs-ofctl del-flows $bridge
done


# Switch 1 2000 Mb ok
printf "Switch 1\n"
sudo ovs-vsctl -- \
set port s1-eth1 qos=@newqos -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:12=@1q queues:34=@2q queues:910=@3q queues:1112=@4q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=700000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=700000 -- \
--id=@3q create queue other-config:min-rate=100000 other-config:max-rate=300000 -- \
--id=@4q create queue other-config:min-rate=100000 other-config:max-rate=300000

# Switch 2 2000 Mb uguale a default
printf "Switch 2\n"
sudo ovs-vsctl -- \
set port s2-eth1 qos=@newqos -- \
set port s2-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:56=@1q queues:78=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=1000000

# Switch 3
printf "\nSwitch 3\n"
sudo ovs-vsctl -- \
set port s3-eth1 qos=@newqos -- \
set port s3-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000000 \
queues:12=@1q queues:910=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=700000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=300000

# Switch 4 ok
printf "\nSwitch 4\n"
sudo ovs-vsctl -- \
set port s4-eth1 qos=@newqos -- \
set port s4-eth2 qos=@newqos -- \
set port s4-eth3 qos=@newqos -- \
set port s4-eth4 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:34=@1q queues:1112=@2q queues:56=@3q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=700000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=300000 -- \
--id=@3q create queue other-config:min-rate=100000 other-config:max-rate=1000000


# Switch 5 uguale a default
printf "\nSwitch 5\n"
sudo ovs-vsctl -- \
set port s5-eth1 qos=@newqos -- \
set port s5-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000000 \
queues:78=@1q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000

# Switch 6 ok
printf "\nSwitch 6\n"
sudo ovs-vsctl -- \
set port s6-eth1 qos=@newqos -- \
set port s6-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:12=@1q queues:34=@2q queues:910=@3q queues:1112=@4q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=700000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=700000 -- \
--id=@3q create queue other-config:min-rate=100000 other-config:max-rate=300000 -- \
--id=@4q create queue other-config:min-rate=100000 other-config:max-rate=300000

# Switch 7 uguale a default
printf "\nSwitch 7\n"
sudo ovs-vsctl -- \
set port s7-eth1 qos=@newqos -- \
set port s7-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:56=@1q queues:78=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=1000000


# Creating links
printf "\n[INFO] Creating links..."

# Switch 1 ok
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,idle_timeout=0,actions=set_queue:12,output:1
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.2,idle_timeout=0,actions=set_queue:12,output:4

sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.3,idle_timeout=0,actions=set_queue:34,output:2
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.4,idle_timeout=0,actions=set_queue:34,output:3

sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.9,idle_timeout=0,actions=set_queue:910,output:1
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.10,idle_timeout=0,actions=set_queue:910,output:5

sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.11,idle_timeout=0,actions=set_queue:1112,output:2
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.12,idle_timeout=0,actions=set_queue:1112,output:6

# Switch 2 =
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.5,idle_timeout=0,actions=set_queue:56,output:1
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.6,idle_timeout=0,actions=set_queue:56,output:4

sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.7,idle_timeout=0,actions=set_queue:78,output:2
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.8,idle_timeout=0,actions=set_queue:78,output:3

# Switch 3 ok
sudo ovs-ofctl add-flow s3 ip,priority=65500,nw_src=10.0.0.1,idle_timeout=0,actions=set_queue:12,output:2
sudo ovs-ofctl add-flow s3 ip,priority=65500,nw_src=10.0.0.2,idle_timeout=0,actions=set_queue:12,output:1

sudo ovs-ofctl add-flow s3 ip,priority=65500,nw_src=10.0.0.9,idle_timeout=0,actions=set_queue:910,output:2
sudo ovs-ofctl add-flow s3 ip,priority=65500,nw_src=10.0.0.10,idle_timeout=0,actions=set_queue:910,output:1

#Switch 4 ok
sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.3,idle_timeout=0,actions=set_queue:34,output:2
sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.4,idle_timeout=0,actions=set_queue:34,output:1

sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.11,idle_timeout=0,actions=set_queue:1112,output:2
sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.12,idle_timeout=0,actions=set_queue:1112,output:1

sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.5,idle_timeout=0,actions=set_queue:56,output:3
sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.6,idle_timeout=0,actions=set_queue:56,output:4

# Switch 5 =
sudo ovs-ofctl add-flow s5 ip,priority=65500,nw_src=10.0.0.7,idle_timeout=0,actions=set_queue:78,output:2
sudo ovs-ofctl add-flow s5 ip,priority=65500,nw_src=10.0.0.8,idle_timeout=0,actions=set_queue:78,output:1

# Switch 6 ok
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.2,idle_timeout=0,actions=set_queue:12,output:1
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.1,idle_timeout=0,actions=set_queue:12,output:4

sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.4,idle_timeout=0,actions=set_queue:34,output:2
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.3,idle_timeout=0,actions=set_queue:34,output:3

sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.10,idle_timeout=0,actions=set_queue:910,output:1
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.9,idle_timeout=0,actions=set_queue:910,output:5

sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.12,idle_timeout=0,actions=set_queue:1112,output:2
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.11,idle_timeout=0,actions=set_queue:1112,output:6

# Switch 7 =
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.6,idle_timeout=0,actions=set_queue:56,output:1
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.5,idle_timeout=0,actions=set_queue:56,output:4

sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.8,idle_timeout=0,actions=set_queue:78,output:2
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.7,idle_timeout=0,actions=set_queue:78,output:3
