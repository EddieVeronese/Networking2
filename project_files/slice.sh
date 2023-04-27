#!/bin/bash

# Start FlowVisor service
echo "Starting FlowVisor service..."
sudo /etc/init.d/flowvisor start

echo "Waiting for service to start..."
sleep 10
echo "Done."

# Get FlowVisor current config
echo "FlowVisor initial config:"
fvctl -f /etc/flowvisor/flowvisor.passwd get-config

# Get FlowVisor current defined slices
echo "FlowVisor initially defined slices:"
fvctl -f /etc/flowvisor/flowvisor.passwd list-slices

# Get FlowVisor current defined flowspaces
echo "FlowVisor initially defined flowspaces:"
fvctl -f /etc/flowvisor/flowvisor.passwd list-flowspace

# Get FlowVisor connected switches
echo "FlowVisor connected switches:"
fvctl -f /etc/flowvisor/flowvisor.passwd list-datapaths

# Get FlowVisor connected switches links up
echo "FlowVisor connected switches links:"
fvctl -f /etc/flowvisor/flowvisor.passwd list-links

# Define the FlowVisor slices
echo "Definition of FlowVisor slices..."
fvctl -f /etc/flowvisor/flowvisor.passwd add-slice slice1 tcp:localhost:10001 admin@slice1
fvctl -f /etc/flowvisor/flowvisor.passwd add-slice slice2 tcp:localhost:10002 admin@slice2
fvctl -f /etc/flowvisor/flowvisor.passwd add-slice slice3 tcp:localhost:10003 admin@slice3
fvctl -f /etc/flowvisor/flowvisor.passwd add-slice slice4 tcp:localhost:10004 admin@slice4

# Check defined slices
echo "Check slices just defined:"
fvctl -f /etc/flowvisor/flowvisor.passwd list-slices

# Define flowspaces
echo "Definition of flowspaces..."

#slice 1
#switch 1
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid1-port1 1 1 in_port=1 slice1=7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid1-port4 1 1 in_port=4 slice1=7
#switch 3
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid3 3 1 any slice1=7
#switch 6
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid6-port1 6 1 in_port=1 slice1=7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid6-port4 6 1 in_port=4 slice1=7

#slice 2
#switch 1
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid1-port3 1 1 in_port=3 slice2=7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid1-port2 1 1 in_port=2 slice2=7
#switch 4 
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid4-port1 4 1 in_port=1 slice2=7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid4-port2 4 1 in_port=2 slice2=7
#switch 6
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid6-port2 6 1 in_port=2 slice2=7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid6-port3 6 1 in_port=2 slice2=7

#slice 3
#switch 2
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid2-port1 2 1 in_port=1 slice3=7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid2-port4 2 1 in_port=4 slice3=7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid2-port5 2 1 in_port=5 slice3=7
#switch 4
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid4-port3 4 1 in_port=3 slice3=7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid4-port4 4 1 in_port=4 slice3=7
#switch 7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid7-port1 7 1 in_port=1 slice3=7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid7-port4 7 1 in_port=4 slice3=7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid7-port5 7 1 in_port=5 slice3=7

#slice 4
#switch 2
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid2-port3 2 1 in_port=3 slice4=7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid2-port2 2 1 in_port=2 slice4=7
#switch 5
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid5 5 1 any slice4=7
#switch 7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid7-port3 7 1 in_port=3 slice4=7
fvctl -f /etc/flowvisor/flowvisor.passwd add-flowspace dpid7-port2 7 1 in_port=2 slice4=7

# Check all the flowspaces added
echo "Check all flowspaces just defined:"
fvctl -f /etc/flowvisor/flowvisor.passwd list-flowspace