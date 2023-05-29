#!/bin/sh
for bridge in $(sudo ovs-vsctl list-br)
do
    sudo ovs-ofctl del-flows $bridge
done


# Switch 1
printf "Switch 1\n"
sudo ovs-vsctl -- \
set port s1-eth1 qos=@newqos -- \
set port s1-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:123400=@1q queues:123401=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=500000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=500000

# Switch 2
printf "Switch 2\n"
sudo ovs-vsctl -- \
set port s2-eth1 qos=@newqos -- \idle_timeout
set port s2-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:567800=@1q queues:567801=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=1000000

# Switch 3
printf "\nSwitch 3\n"
sudo ovs-vsctl -- \
set port s3-eth1 qos=@newqos -- \
set port s3-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000000 \
queues:1234=@1q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=500000 -- \

# Switch 4
printf "\nSwitch 4\n"
sudo ovs-vsctl -- \
set port s4-eth1 qos=@newqos -- \
set port s4-eth2 qos=@newqos -- \
set port s4-eth3 qos=@newqos -- \
set port s4-eth4 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:1234=@1q queues:5678=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=500000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=1000000

# Switch 5
printf "\nSwitch 5\n"
sudo ovs-vsctl -- \
set port s5-eth1 qos=@newqos -- \
set port s5-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=1000000 \
queues:5678=@1q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=500000 -- \

# Switch 6
printf "\nSwitch 6\n"
sudo ovs-vsctl -- \
set port s6-eth1 qos=@newqos -- \
set port s6-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:123400=@1q queues:123401=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=500000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=500000

# Switch 7
printf "\nSwitch 7\n"
sudo ovs-vsctl -- \
set port s7-eth1 qos=@newqos -- \
set port s7-eth2 qos=@newqos -- \
--id=@newqos create QoS type=linux-htb \
other-config:max-rate=2000000 \
queues:567800=@1q queues:567801=@2q -- \
--id=@1q create queue other-config:min-rate=100000 other-config:max-rate=1000000 -- \
--id=@2q create queue other-config:min-rate=100000 other-config:max-rate=1000000


# Creating links with new_src
printf "\n[INFO] Creating links..."

# CONTROLLO PROT. SOLO IN USCITA, IN ENTRATA SUPER PARTES

# Switch 1
sudo ovs-ofctl add-flow s1 priority=65500,udp,ip,nw_dst=10.0.0.3,idle_timeout=0,actions=set_queue:123400,output:3
sudo ovs-ofctl add-flow s1 priority=65500,udp,ip,nw_dst=10.0.0.1,idle_timeout=0,actions=set_queue:123400,output:4
sudo ovs-ofctl add-flow s1 priority=65500,icmp,ip,nw_dst=10.0.0.3,idle_timeout=0,actions=set_queue:123401,output:3
sudo ovs-ofctl add-flow s1 priority=65500,icmp,ip,nw_dst=10.0.0.1,idle_timeout=0,actions=set_queue:123401,output:4
sudo ovs-ofctl add-flow s1 priority=65500,tcp,ip,nw_dst=10.0.0.3,idle_timeout=0,actions=set_queue:123401,output:3
sudo ovs-ofctl add-flow s1 priority=65500,tcp,ip,nw_dst=10.0.0.1,idle_timeout=0,actions=set_queue:123401,output:4

# udp
sudo ovs-ofctl add-flow s1 priority=65500,udp,in_port=4,idle_timeout=0,actions=set_queue:123400,output:2
sudo ovs-ofctl add-flow s1 priority=65500,udp,in_port=3,idle_timeout=0,actions=set_queue:123400,output:2
#sudo ovs-ofctl add-flow s1 priority=65500,udp,in_port=2,idle_timeout=0,actions=set_queue:123400,output:4,output:3

#icmp
sudo ovs-ofctl add-flow s1 priority=65500,icmp,in_port=4,idle_timeout=0,actions=set_queue:123401,output:1
sudo ovs-ofctl add-flow s1 priority=65500,icmp,in_port=3,idle_timeout=0,actions=set_queue:123401,output:1
#sudo ovs-ofctl add-flow s1 priority=65500,icmp,in_port=1,idle_timeout=0,actions=set_queue:123401,output:4,output:3

#tcp
sudo ovs-ofctl add-flow s1 priority=65500,tcp,in_port=4,idle_timeout=0,actions=set_queue:123401,output:1
sudo ovs-ofctl add-flow s1 priority=65500,tcp,in_port=3,idle_timeout=0,actions=set_queue:123401,output:1
#sudo ovs-ofctl add-flow s1 priority=65500,tcp,in_port=1,idle_timeout=0,actions=set_queue:123401,output:4,output:3


# Switch 2
sudo ovs-ofctl add-flow s2 priority=65500,udp,ip,nw_dst=10.0.0.7,idle_timeout=0,actions=set_queue:567800,output:3
sudo ovs-ofctl add-flow s2 priority=65500,udp,ip,nw_dst=10.0.0.5,idle_timeout=0,actions=set_queue:567800,output:4
sudo ovs-ofctl add-flow s2 priority=65500,icmp,ip,nw_dst=10.0.0.7,idle_timeout=0,actions=set_queue:567801,output:3
sudo ovs-ofctl add-flow s2 priority=65500,icmp,ip,nw_dst=10.0.0.5,idle_timeout=0,actions=set_queue:567801,output:4
sudo ovs-ofctl add-flow s2 priority=65500,tcp,ip,nw_dst=10.0.0.7,idle_timeout=0,actions=set_queue:567801,output:3
sudo ovs-ofctl add-flow s2 priority=65500,tcp,ip,nw_dst=10.0.0.5,idle_timeout=0,actions=set_queue:567801,output:4

# udp
sudo ovs-ofctl add-flow s2 priority=65500,udp,in_port=4,idle_timeout=0,actions=set_queue:567800,output:1
sudo ovs-ofctl add-flow s2 priority=65500,udp,in_port=3,idle_timeout=0,actions=set_queue:567800,output:1
#sudo ovs-ofctl add-flow s2 priority=65500,udp,in_port=1,idle_timeout=0,actions=set_queue:567800,output:4,output:3

#icmp
sudo ovs-ofctl add-flow s2 priority=65500,icmp,in_port=4,idle_timeout=0,actions=set_queue:567801,output:2
sudo ovs-ofctl add-flow s2 priority=65500,icmp,in_port=3,idle_timeout=0,actions=set_queue:567801,output:2
#sudo ovs-ofctl add-flow s2 priority=65500,icmp,in_port=2,idle_timeout=0,actions=set_queue:567801,output:4,output:3

#tcp
sudo ovs-ofctl add-flow s2 priority=65500,tcp,in_port=4,idle_timeout=0,actions=set_queue:567801,output:2
sudo ovs-ofctl add-flow s2 priority=65500,tcp,in_port=3,idle_timeout=0,actions=set_queue:567801,output:2
#sudo ovs-ofctl add-flow s2 priority=65500,tcp,in_port=2,idle_timeout=0,actions=set_queue:567801,output:4,output:3



# Switch 3
sudo ovs-ofctl add-flow s3 priority=65500,in_port=1,idle_timeout=0,actions=set_queue:1234,output:2
sudo ovs-ofctl add-flow s3 priority=65500,in_port=2,idle_timeout=0,actions=set_queue:1234,output:1
sudo ovs-ofctl add-flow s3 priority=65500,udp,idle_timeout=0,actions=drop


#Switch 4 
sudo ovs-ofctl add-flow s4 priority=65500,in_port=1,idle_timeout=0,actions=set_queue:1234,output:2
sudo ovs-ofctl add-flow s4 priority=65500,in_port=2,idle_timeout=0,actions=set_queue:1234,output:1
sudo ovs-ofctl add-flow s4 priority=65500,in_port=4,idle_timeout=0,actions=set_queue:5678,output:3
sudo ovs-ofctl add-flow s4 priority=65500,in_port=3,idle_timeout=0,actions=set_queue:5678,output:4
sudo ovs-ofctl add-flow s4 priority=65500,tcp,idle_timeout=0,actions=drop


# Switch 5
sudo ovs-ofctl add-flow s5 priority=65500,in_port=1,idle_timeout=0,actions=set_queue:5678,output:2
sudo ovs-ofctl add-flow s5 priority=65500,in_port=2,idle_timeout=0,actions=set_queue:5678,output:1
sudo ovs-ofctl add-flow s5 priority=65500,udp,idle_timeout=0,actions=drop


# Switch 6
sudo ovs-ofctl add-flow s6 priority=65500,udp,ip,nw_dst=10.0.0.4,idle_timeout=0,actions=set_queue:123400,output:3
sudo ovs-ofctl add-flow s6 priority=65500,udp,ip,nw_dst=10.0.0.2,idle_timeout=0,actions=set_queue:123400,output:4
sudo ovs-ofctl add-flow s6 priority=65500,icmp,ip,nw_dst=10.0.0.4,idle_timeout=0,actions=set_queue:123401,output:3
sudo ovs-ofctl add-flow s6 priority=65500,icmp,ip,nw_dst=10.0.0.2,idle_timeout=0,actions=set_queue:123401,output:4
sudo ovs-ofctl add-flow s6 priority=65500,tcp,ip,nw_dst=10.0.0.4,idle_timeout=0,actions=set_queue:123401,output:3
sudo ovs-ofctl add-flow s6 priority=65500,tcp,ip,nw_dst=10.0.0.2,idle_timeout=0,actions=set_queue:123401,output:4

#udp
sudo ovs-ofctl add-flow s6 priority=65500,udp,in_port=4,idle_timeout=0,actions=set_queue:123400,output:2
sudo ovs-ofctl add-flow s6 priority=65500,udp,in_port=3,idle_timeout=0,actions=set_queue:123400,output:2
#sudo ovs-ofctl add-flow s6 priority=65500,udp,in_port=2,idle_timeout=0,actions=set_queue:123400,output:4,output:3

#icmp
sudo ovs-ofctl add-flow s6 priority=65500,icmp,in_port=4,idle_timeout=0,actions=set_queue:123401,output:1
sudo ovs-ofctl add-flow s6 priority=65500,icmp,in_port=3,idle_timeout=0,actions=set_queue:123401,output:1
#sudo ovs-ofctl add-flow s6 priority=65500,icmp,in_port=1,idle_timeout=0,actions=set_queue:123401,output:4,output:3

#tcp
sudo ovs-ofctl add-flow s6 priority=65500,tcp,in_port=4,idle_timeout=0,actions=set_queue:123401,output:1
sudo ovs-ofctl add-flow s6 priority=65500,tcp,in_port=3,idle_timeout=0,actions=set_queue:123401,output:1
#sudo ovs-ofctl add-flow s6 priority=65500,tcp,in_port=1,idle_timeout=0,actions=set_queue:123401,output:4,output:3



# Switch 7
sudo ovs-ofctl add-flow s7 priority=65500,udp,ip,nw_dst=10.0.0.8,idle_timeout=0,actions=set_queue:567800,output:3
sudo ovs-ofctl add-flow s7 priority=65500,udp,ip,nw_dst=10.0.0.6,idle_timeout=0,actions=set_queue:567800,output:4
sudo ovs-ofctl add-flow s7 priority=65500,icmp,ip,nw_dst=10.0.0.8,idle_timeout=0,actions=set_queue:567801,output:3
sudo ovs-ofctl add-flow s7 priority=65500,icmp,ip,nw_dst=10.0.0.6,idle_timeout=0,actions=set_queue:567801,output:4
sudo ovs-ofctl add-flow s7 priority=65500,tcp,ip,nw_dst=10.0.0.8,idle_timeout=0,actions=set_queue:567801,output:3
sudo ovs-ofctl add-flow s7 priority=65500,tcp,ip,nw_dst=10.0.0.6,idle_timeout=0,actions=set_queue:567801,output:4

#udp
sudo ovs-ofctl add-flow s7 priority=65500,udp,in_port=4,idle_timeout=0,actions=set_queue:567800,output:1
sudo ovs-ofctl add-flow s7 priority=65500,udp,in_port=3,idle_timeout=0,actions=set_queue:567800,output:1
#sudo ovs-ofctl add-flow s7 priority=65500,udp,in_port=1,idle_timeout=0,actions=set_queue:567800,output:4,output:3

#icmp
sudo ovs-ofctl add-flow s7 priority=65500,icmp,in_port=4,idle_timeout=0,actions=set_queue:567801,output:2
sudo ovs-ofctl add-flow s7 priority=65500,icmp,in_port=3,idle_timeout=0,actions=set_queue:567801,output:2
#sudo ovs-ofctl add-flow s7 priority=65500,icmp,in_port=2,idle_timeout=0,actions=set_queue:567801,output:4,output:3

#tcp
sudo ovs-ofctl add-flow s7 priority=65500,tcp,in_port=4,idle_timeout=0,actions=set_queue:567801,output:2
sudo ovs-ofctl add-flow s7 priority=65500,tcp,in_port=3,idle_timeout=0,actions=set_queue:567801,output:2
#sudo ovs-ofctl add-flow s7 priority=65500,tcp,in_port=2,idle_timeout=0,actions=set_queue:567801,output:4,output:3


