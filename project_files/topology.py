#!/usr/bin/python3

from mininet.topo import Topo
from mininet.net import Mininet
from mininet.node import OVSKernelSwitch, RemoteController
from mininet.cli import CLI
from mininet.link import TCLink
import subprocess


class NetworkSlicingTopo(Topo):
    def __init__(self):

        Topo.__init__(self)


        host_config = dict(inNamespace=True)
        link_config = dict()
        host_link_config = dict()

        #creo 7 switch
        for i in range(7):
            sconfig = {"dpid": "%016x" % (i + 1)}
            self.addSwitch("s%d" % (i + 1), **sconfig)

        #creo 18 host
        for i in range(18):
            self.addHost("h%d" % (i + 1), **host_config) 
            
 
        # linko gli switch
        self.addLink("s1", "s3", **link_config)
        self.addLink("s1", "s4", **link_config)
        self.addLink("s2", "s4", **link_config)
        self.addLink("s2", "s5", **link_config)
        self.addLink("s3", "s6", **link_config)
        self.addLink("s4", "s6", **link_config)
        self.addLink("s4", "s7", **link_config)
        self.addLink("s5", "s7", **link_config)

        # Add clients-router1 and clients-router2 links
        self.addLink("h1", "s1", **host_link_config)
        self.addLink("h2", "s6", **host_link_config)
        self.addLink("h3", "s1", **host_link_config)
        self.addLink("h4", "s6", **host_link_config)
        self.addLink("h5", "s2", **host_link_config)
        self.addLink("h6", "s2", **host_link_config)
        self.addLink("h7", "s7", **host_link_config)
        self.addLink("h8", "s7", **host_link_config)
        self.addLink("h9", "s2", **host_link_config)
        self.addLink("h10", "s7", **host_link_config)






topos = {"networkslicingtopo": (lambda: NetworkSlicingTopo())}

if __name__ == "__main__":
    topo = NetworkSlicingTopo()
    net = Mininet(
        topo=topo,
        
        # We specify an external controller by passing the Controller object in the Mininet constructor
        # This was added in Mininet 2.2.0 and above.
        # SOS Note: Do not specify port -- Default: 6653
        controller=RemoteController( 'c0', ip='127.0.0.1'), 
        switch=OVSKernelSwitch,
        build=False,
        autoSetMacs=True,
        autoStaticArp=True,
        link=TCLink,
    )
    
    # ------------ Check Constructor for Controller ----------------- #
    #controller = RemoteController("c1", ip="127.0.0.1", port=6633)
    #net.addController(controller)
    
    net.build()
    net.start()
    
    # Here we automate the process of creating the 2 slices by calling as a subprocess the common_scenario.sh
    # Assumption: We begin with a non-emergency scenario.
    subprocess.call("./common_scenario.sh")
    
    CLI(net)
    net.stop()