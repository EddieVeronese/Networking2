#!/usr/bin/python3

from mininet.topo import Topo
from mininet.net import Mininet
from mininet.node import OVSKernelSwitch, RemoteController
from mininet.cli import CLI
from mininet.link import TCLink
import subprocess
import time


class NetworkSlicingTopo(Topo):
    def build(self):

        host_config = dict(inNamespace=True)
        link_config = dict()
        host_link_config = dict()

        #creo 7 switch
        for i in range(4):
            sconfig = {"dpid": "%016x" % (i + 1)}
            self.addSwitch("s%d" % (i + 1), **sconfig)

        #creo 8 host
        for i in range(4):
            self.addHost("h%d" % (i + 1), **host_config) 
            
 
        # linko gli switch
        self.addLink("s1", "s3", **link_config)
        self.addLink("s1", "s4", **link_config)
        self.addLink("s2", "s3", **link_config)
        self.addLink("s2", "s4", **link_config)

        # Add clients-router1 and clients-router2 links
        self.addLink("h1", "s1", **host_link_config)
        self.addLink("h2", "s1", **host_link_config)
        self.addLink("h3", "s2", **host_link_config)
        self.addLink("h4", "s2", **host_link_config)


topos = {"networkslicingtopo": (lambda: NetworkSlicingTopo())}

if __name__ == "__main__":
    topo = NetworkSlicingTopo()
    net = Mininet(
        topo=topo,

        switch=OVSKernelSwitch,
        build=False,
        autoSetMacs=True,
        autoStaticArp=True,
        link=TCLink,
    )
    
    controller=RemoteController( 'c0', ip='127.0.0.1', port=6653)
    net.addController(controller)

    net.build()
    net.start()

    subprocess.call("./prova.sh")
    time.sleep(30)
    subprocess.call("./default.sh")

    
    CLI(net)
    net.stop()