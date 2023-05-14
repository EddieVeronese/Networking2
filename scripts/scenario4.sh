#!/bin/sh

#!/bin/sh
for bridge in $(sudo ovs-vsctl list-br)
do
    sudo ovs-ofctl del-flows $bridge
done

# Switch 1 2000 Mb  ->for 1_slice
printf "Switch 1\n"
sudo ovs-vsctl -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:1368=@1q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=2000000

# Switch 2 2000 Mb ->for 2_slice
printf "Switch 2\n"
sudo ovs-vsctl -- \
set port s2-eth1 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:2457=@1q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=2000000

# Switch 4 ->both for 1 and 2 _slices
printf "\nSwitch 4\n"
sudo ovs-vsctl -- \
set port s4-eth1 qos=@newqos -- \
set port s4-eth2 qos=@newqos -- \
set port s4-eth3 qos=@newqos -- \
set port s4-eth4 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=4000000 \
queues:1368=@1q queues:2457=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=2000000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=2000000

# Switch 6 ->for 2_slice
printf "\nSwitch 6\n"
sudo ovs-vsctl -- \
set port s6-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:2457=@1q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=2000000

# Switch 7 ->for 1_slice
printf "\nSwitch 7\n"
sudo ovs-vsctl -- \
set port s7-eth1 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:1368=@1q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=2000000


# Creating links
printf "\n[INFO] Creating links di Fede gg easy..."

# Switch 1 ok
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,,idle_timeout=0,actions=set_queue:1368,output:2
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.1,,idle_timeout=0,actions=set_queue:1368,output:3

sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.3,,idle_timeout=0,actions=set_queue:1368,output:2
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.3,,idle_timeout=0,actions=set_queue:1368,output:4

sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.6,,idle_timeout=0,actions=set_queue:1368,output:4
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.6,,idle_timeout=0,actions=set_queue:1368,output:3

sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.8,,idle_timeout=0,actions=set_queue:1368,output:4
sudo ovs-ofctl add-flow s1 ip,priority=65500,nw_src=10.0.0.8,,idle_timeout=0,actions=set_queue:1368,output:3

sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=5,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=6,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=1,idle_timeout=0,actions=drop

# Switch 2
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.5,,idle_timeout=0,actions=set_queue:2457,output:1
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.5,,idle_timeout=0,actions=set_queue:2457,output:3

sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.7,,idle_timeout=0,actions=set_queue:2457,output:1
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.7,,idle_timeout=0,actions=set_queue:2457,output:4

sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.2,,idle_timeout=0,actions=set_queue:2457,output:3
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.2,,idle_timeout=0,actions=set_queue:2457,output:4

sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.4,,idle_timeout=0,actions=set_queue:2457,output:3
sudo ovs-ofctl add-flow s2 ip,priority=65500,nw_src=10.0.0.4,,idle_timeout=0,actions=set_queue:2457,output:4

# Switch 3
sudo ovs-ofctl add-flow s3 ip,priority=65500,in_port=1,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s3 ip,priority=65500,in_port=2,idle_timeout=0,actions=drop

#Switch 4 
sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.1,,idle_timeout=0,actions=set_queue:1368,output:3
sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.3,,idle_timeout=0,actions=set_queue:1368,output:3

sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.6,,idle_timeout=0,actions=set_queue:1368,output:1
sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.8,,idle_timeout=0,actions=set_queue:1368,output:1

sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.2,,idle_timeout=0,actions=set_queue:2457,output:4
sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.4,,idle_timeout=0,actions=set_queue:2457,output:4

sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.5,,idle_timeout=0,actions=set_queue:2457,output:2
sudo ovs-ofctl add-flow s4 ip,priority=65500,nw_src=10.0.0.7,,idle_timeout=0,actions=set_queue:2457,output:2

# Switch 5
sudo ovs-ofctl add-flow s5 ip,priority=65500,in_port=1,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s5 ip,priority=65500,in_port=2,idle_timeout=0,actions=drop


# Switch 6
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.2,,idle_timeout=0,actions=set_queue:1368,output:2
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.2,,idle_timeout=0,actions=set_queue:1368,output:3

sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.4,,idle_timeout=0,actions=set_queue:1368,output:2
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.4,,idle_timeout=0,actions=set_queue:1368,output:4

sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.5,,idle_timeout=0,actions=set_queue:1368,output:3
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.5,,idle_timeout=0,actions=set_queue:1368,output:4

sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.7,,idle_timeout=0,actions=set_queue:1368,output:3
sudo ovs-ofctl add-flow s6 ip,priority=65500,nw_src=10.0.0.7,,idle_timeout=0,actions=set_queue:1368,output:4

sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=5,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=6,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=1,idle_timeout=0,actions=drop

# Switch 7
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.6,,idle_timeout=0,actions=set_queue:2457,output:1
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.6,,idle_timeout=0,actions=set_queue:2457,output:3

sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.8,,idle_timeout=0,actions=set_queue:2457,output:1
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.8,,idle_timeout=0,actions=set_queue:2457,output:4

sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.1,,idle_timeout=0,actions=set_queue:2457,output:3
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.1,,idle_timeout=0,actions=set_queue:2457,output:4

sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.3,,idle_timeout=0,actions=set_queue:2457,output:3
sudo ovs-ofctl add-flow s7 ip,priority=65500,nw_src=10.0.0.3,,idle_timeout=0,actions=set_queue:2457,output:4
