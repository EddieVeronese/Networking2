#!/bin/sh

#!/bin/sh
for bridge in $(sudo ovs-vsctl list-br)
do
    sudo ovs-ofctl del-flows $bridge
done

# Switch 1 2000 Mb  ->for blue_slice
printf "Switch 1\n"
sudo ovs-vsctl -- \
set port s1-eth1 qos=@newqos -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:blue=@1q -- \
--id=@1q create queue other-config:min-rate=200000 other-config:max-rate=2000000

# Switch 2 2000 Mb ->for orange_slice
printf "Switch 2\n"
sudo ovs-vsctl -- \
set port s2-eth1 qos=@newqos -- \
set port s2-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:orange=@1q -- \
--id=@1q create queue other-config:min-rate=200000 other-config:max-rate=2000000

# Switch 3 ->not used in this config
printf "\nSwitch 3\n"
sudo ovs-vsctl -- \
set port s3-eth1 qos=@newqos -- \
set port s3-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000000

# Switch 4 ->both for blue and orange _slices
printf "\nSwitch 4\n"
sudo ovs-vsctl -- \
set port s4-eth1 qos=@newqos -- \
set port s4-eth2 qos=@newqos -- \
set port s4-eth3 qos=@newqos -- \
set port s4-eth4 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:blue=@1q queues:orange=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=1000000


# Switch 5 ->not used in this config
printf "\nSwitch 5\n"
sudo ovs-vsctl -- \
set port s5-eth1 qos=@newqos -- \
set port s5-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000000

# Switch 6 ->for orange_slice
printf "\nSwitch 6\n"
sudo ovs-vsctl -- \
set port s6-eth1 qos=@newqos -- \
set port s6-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:orange=@1q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000

# Switch 7 ->for blue_slice
printf "\nSwitch 7\n"
sudo ovs-vsctl -- \
set port s7-eth1 qos=@newqos -- \
set port s7-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:blue=@1q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000


# Creating links
printf "\n[INFO] Creating links..."

# Switch 1
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:blue,output:2
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:blue,output:2

sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:blue,output:4
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:blue,output:3

sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=5,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=6,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=1,idle_timeout=0,actions=drop

# Switch 2
sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:orange,output:1
sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:orange,output:1

sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:orange,output:4
sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:orange,output:3

sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=2,idle_timeout=0,actions=drop

# Switch 3
sudo ovs-ofctl add-flow s3 ip,priority=65500,in_port=1,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s3 ip,priority=65500,in_port=2,idle_timeout=0,actions=drop

#Switch 4 
sudo ovs-ofctl add-flow s4 table=0,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:blue,output:3
sudo ovs-ofctl add-flow s4 table=0,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:blue,output:1

sudo ovs-ofctl add-flow s4 table=0,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:orange,output:2
sudo ovs-ofctl add-flow s4 table=0,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:orange,output:4

# Switch 5
sudo ovs-ofctl add-flow s5 ip,priority=65500,in_port=1,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s5 ip,priority=65500,in_port=2,idle_timeout=0,actions=drop

# Switch 6
sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:orange,output:2
sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:orange,output:2

sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:34,output:4
sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:34,output:3

sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=5,idle_timeout=0,actions=drop
sudo ovs-ofctl add-flow s6 ip,priority=65500,in_port=6,idle_timeout=0,actions=drop

# Switch 7
sudo ovs-ofctl add-flow s7 ip,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:blue,output:1
sudo ovs-ofctl add-flow s7 ip,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:blue,output:1

sudo ovs-ofctl add-flow s7 ip,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:blue,output:4
sudo ovs-ofctl add-flow s7 ip,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:blue,output:3