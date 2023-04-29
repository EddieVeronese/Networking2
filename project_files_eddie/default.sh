#!/bin/sh


# cre odue queue in switch 1 per h1 e h3
printf "Switch 1:\n"
sudo ovs-vsctl -- \
#non so cosa fanno
set port s1-eth1 qos=@newqos -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000 \
queues:12=@1q queues:34=@2q -- \
--id=@1q create queue other-config:min-rate=100 other-config:max-rate=500 -- \
--id=@2q create queue other-config:min-rate=100 other-config:max-rate=500

echo ' '

# cre odue queue in switch 6 per h2 e h4
printf "Switch 6:\n"
sudo ovs-vsctl -- \
#non so cosa fanno
set port s1-eth1 qos=@newqos -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000 \
queues:24=@1q queues:43=@2q -- \
--id=@1q create queue other-config:min-rate=100 other-config:max-rate=500 -- \
--id=@2q create queue other-config:min-rate=100 other-config:max-rate=500

echo ' '

# cre odue queue in switch 2 per h5 e h7
printf "Switch 2:\n"
sudo ovs-vsctl -- \
#non so cosa fanno
set port s1-eth1 qos=@newqos -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000 \
queues:56=@3q queues:78=@4q -- \
--id=@3q create queue other-config:min-rate=100 other-config:max-rate=500 -- \
--id=@4q create queue other-config:min-rate=100 other-config:max-rate=500

echo ' '

# cre odue queue in switch 7 per h6 e h8
printf "Switch 7:\n"
sudo ovs-vsctl -- \
#non so cosa fanno
set port s1-eth1 qos=@newqos -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000 \
queues:65=@1q queues:87=@2q -- \
--id=@3q create queue other-config:min-rate=100 other-config:max-rate=500 -- \
--id=@4q create queue other-config:min-rate=100 other-config:max-rate=500

# cre odue queue in switch 3 per h1
printf "Switch 3:\n"
sudo ovs-vsctl -- \
#non so cosa fanno
set port s1-eth1 qos=@newqos -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000 \
queues:12=@1q -- \
--id=@1q create queue other-config:min-rate=100 other-config:max-rate=500

echo ' '

# cre odue queue in switch 4 per h1
printf "Switch 4:\n"
sudo ovs-vsctl -- \
#non so cosa fanno
set port s1-eth1 qos=@newqos -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000 \
queues:34=@2q queues:56=@3q -- \
--id=@2q create queue other-config:min-rate=100 other-config:max-rate=500 -- \
--id=@3q create queue other-config:min-rate=100 other-config:max-rate=500

echo ' '
# cre odue queue in switch 5 per h1
printf "Switch 5:\n"
sudo ovs-vsctl -- \
#non so cosa fanno
set port s1-eth1 qos=@newqos -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000 \
queues:78=@4q -- \
--id=@4q create queue other-config:min-rate=100 other-config:max-rate=500 -- \


echo '*** End of Creating the Slices ...'
echo ' ---------------------------------------------- '

#creo link
#s1

# Switch 1
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:12,output:3
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:12,output:4

sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:34,output:2
sudo ovs-ofctl add-flow s1 ip,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:34,output:3

# Switch 2
sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:56,output:1
sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:56,output:4

sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:78,output:2
sudo ovs-ofctl add-flow s2 ip,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:78,output:3

# Switch 3
sudo ovs-ofctl add-flow s3 table=0,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:12,output:2
sudo ovs-ofctl add-flow s3 table=0,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:12,output:1

# Switch 4
sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:34,output:2
sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:34,output:1

sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:56,output:3
sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:56,output:4

#switch 5
sudo ovs-ofctl add-flow s3 table=0,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:78,output:2
sudo ovs-ofctl add-flow s3 table=0,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:78,output:1

# Switch 6
sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:12,output:4
sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:12,output:1

sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:34,output:3
sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:34,output:2

# Switch 7
sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=1,idle_timeout=0,actions=set_queue:56,output:4
sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=4,idle_timeout=0,actions=set_queue:56,output:1

sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=3,idle_timeout=0,actions=set_queue:78,output:2
sudo ovs-ofctl add-flow s4 ip,priority=65500,in_port=2,idle_timeout=0,actions=set_queue:78,output:3