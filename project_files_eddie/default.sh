#!/bin/sh


# Switch 1 2000 Mb
printf "Switch 1\n"
sudo ovs-vsctl -- \
set port s1-eth1 qos=@newqos -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:12=@1q queues:34=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=1000000

# Switch 2 2000 Mb
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
queues:12=@1q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000

# Switch 4
printf "\nSwitch 4\n"
sudo ovs-vsctl -- \
set port s4-eth1 qos=@newqos -- \
set port s4-eth2 qos=@newqos -- \
set port s4-eth3 qos=@newqos -- \
set port s4-eth4 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:34=@1q queues:56=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=1000000


# Switch 5
printf "\nSwitch 5\n"
sudo ovs-vsctl -- \
set port s5-eth1 qos=@newqos -- \
set port s5-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000000 \
queues:78=@1q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000

# Switch 6
printf "\nSwitch 6\n"
sudo ovs-vsctl -- \
set port s6-eth1 qos=@newqos -- \
set port s6-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:12=@1q queues:34=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=1000000

# Switch 7
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

# Switch 1
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:12,output:1
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:12,output:4

sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:34,output:2
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:34,output:3

sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=5,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=6,idle_timeout=0,actions=drop

# Switch 2
sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:56,output:1
sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:56,output:4

sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:78,output:2
sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:78,output:3


# Switch 3
sudo ovs-ofctl add-flow s3 table=0,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:12,output:2
sudo ovs-ofctl add-flow s3 table=0,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:12,output:1

#Switch 4 
sudo ovs-ofctl add-flow s4 table=0,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:34,output:2
sudo ovs-ofctl add-flow s4 table=0,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:34,output:1

sudo ovs-ofctl add-flow s4 table=0,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:56,output:3
sudo ovs-ofctl add-flow s4 table=0,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:56,output:4

# Switch 5
sudo ovs-ofctl add-flow s5 table=0,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:78,output:2
sudo ovs-ofctl add-flow s5 table=0,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:78,output:1

# Switch 6
sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:12,output:4
sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:12,output:1

sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:34,output:3
sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:34,output:2


sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=5,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=6,idle_timeout=0,actions=drop

# Switch 7
sudo ovs-ofctl add-flow s7 ip,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:56,output:4
sudo ovs-ofctl add-flow s7 ip,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:56,output:1

sudo ovs-ofctl add-flow s7 ip,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:78,output:3
sudo ovs-ofctl add-flow s7 ip,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:78,output:2




