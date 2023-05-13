#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
About: Basic example of service (running inside a APPContainer) migration.
"""

import os
import shlex
import time

from subprocess import check_output

from comnetsemu.cli import CLI
from comnetsemu.net import Containernet, VNFManager
from mininet.link import TCLink
from mininet.log import info, setLogLevel
from mininet.node import Controller


def get_ofport(ifce: str):
    """Get the openflow port based on the iterface name.

    :param ifce (str): Name of the interface.
    """
    return (
        check_output(shlex.split("ovs-vsctl get Interface {} ofport".format(ifce)))
        .decode("utf-8")
        .strip()
    )


if __name__ == "__main__":

    # Only used for auto-testing.
    AUTOTEST_MODE = os.environ.get("COMNETSEMU_AUTOTEST_MODE", 0)

    setLogLevel("info")

    net = Containernet(controller=Controller, link=TCLink, xterms=False)
    mgr = VNFManager(net)

    info("*** Add the default controller\n")
    net.addController("c0")

    info("*** Creating the client and hosts\n")
    h1 = net.addDockerHost(
        "h1", dimage="dev_test", ip="10.0.0.11/24", docker_args={"hostname": "h1"}
    )
    
    h2 = net.addDockerHost(
        "h2", dimage="dev_test", ip="10.0.0.12/24", docker_args={"hostname": "h2"}
    )

    h3 = net.addDockerHost(
        "h3",
        dimage="dev_test",
        ip="10.0.0.13/24",
        docker_args={"hostname": "h3", "pid_mode": "host"},
    )
    h4 = net.addDockerHost(
        "h4",
        dimage="dev_test",
        ip="10.0.0.14/24",
        docker_args={"hostname": "h4", "pid_mode": "host"},
    )

    info("*** Adding switch and links\n")
    s1 = net.addSwitch("s1")
    s2 = net.addSwitch("s2")
    s3 = net.addSwitch("s3")
    s4 = net.addSwitch("s4")
    
    
    # Add the interfaces for service traffic.
    net.addLinkNamedIfce(s3, h3, bw=1000, delay="5ms")
    net.addLinkNamedIfce(s4, h4, bw=1000, delay="5ms")
    net.addLinkNamedIfce(s1, h1, bw=1000, delay="5ms")
    net.addLinkNamedIfce(s2, h2, bw=1000, delay="5ms")
    net.addLinkNamedIfce(s1, s2, bw=1000, delay="5ms")
    net.addLinkNamedIfce(s1, s3, bw=1000, delay="5ms")
    net.addLinkNamedIfce(s3, s4, bw=1000, delay="5ms")
    net.addLinkNamedIfce(s4, s2, bw=1000, delay="5ms")

    # Add the interface for host internal traffic.
    net.addLink(
        s4, h4, bw=1000, delay="1ms", intfName1="s4-h4-int", intfName2="h4-s4-int"
    )
    net.addLink(
        s3, h3, bw=1000, delay="1ms", intfName1="s3-h3-int", intfName2="h3-s3-int"
    )
    
    """
    net.addLink(
        s3, s4, bw=1000, delay="1ms", intfName1="s3-s4-int", intfName2="s4-s3-int"
    )           
    """
    ##########################################################
    
    info("\n*** Starting network\n")
    net.start()

    s1_h1_port_num = get_ofport("s1-h1")
    s1_s3_port_num = get_ofport("s1-s3")
    s2_h2_port_num = get_ofport("s2-h2")
    s2_s4_port_num = get_ofport("s2-s4")
    s3_s1_port_num = get_ofport("s3-s1")
    s3_s4_port_num = get_ofport("s3-s4")
    s3_h3_port_num = get_ofport("s3-h3")
    s4_h4_port_num = get_ofport("s4-h4")
    s4_s2_port_num = get_ofport("s4-s2")
    s4_s3_port_num = get_ofport("s4-s3")

    """
    h3_mac = h3.MAC(intf="h3-s3")
    h4_mac = h4.MAC(intf="h4-s4")

    h3.setMAC("00:00:00:00:00:13", intf="h3-s3")
    h4.setMAC("00:00:00:00:00:13", intf="h4-s4")

    info("*** Use the subnet 192.168.0.0/24 for internal traffic between h3 and h4.\n")
    print("- Internal IP of h2: 192.168.0.12")
    print("- Internal IP of h3: 192.168.0.13")
    h3.cmd("ip addr add 192.168.0.13/24 dev h3-s3-int")
    h4.cmd("ip addr add 192.168.0.14/24 dev h4-s4-int")
    h3.cmd("ping -c 3 192.168.0.14")
    """
######################################################################


    # INFO: For the simplicity, OpenFlow rules are managed directly via
    # `ovs-ofctl` utility provided by the OvS.
    # For realistic setup, switches should be managed by a remote controller.
    info("*** Add flow to forward traffic from h1 to h2 to switch s1.\n")
    h1_ip = "10.0.0.11"
    h2_ip = "10.0.0.12"
    h3_ip = "10.0.0.13"
    h4_ip = "10.0.0.14"
    check_output(
        shlex.split(
            'ovs-ofctl add-flow s1 "ip,priority=65500,nw_dst={},idle_timeout=0,actions=output:{}"'.format(
                h3_ip, s1_s3_port_num
            )
        )
    )
    check_output(
        shlex.split(
            'ovs-ofctl add-flow s1 "ip,priority=65500,nw_dst={},nw_src={},idle_timeout=0,actions=output:{}"'.format(
                h1_ip, h3_ip, s1_h1_port_num
            )
        )
    )
    check_output(
        shlex.split(
            'ovs-ofctl add-flow s2 "ip,priority=65500, in_port={},idle_timeout=0,actions=output:{}"'.format(
                s2_h2_port_num, s2_s4_port_num
            )
        )
    )
    check_output(
        shlex.split(
            'ovs-ofctl add-flow s2 "ip,priority=65500,nw_dst={},idle_timeout=0,actions=output:{}"'.format(
                h2_ip, s2_h2_port_num
            )
        )
    )
    check_output(
        shlex.split(
            'ovs-ofctl add-flow s3 "ip,priority=65500,nw_dst={},idle_timeout=0,actions=output:{}"'.format(
                h3_ip, s3_h3_port_num
            )
        )
    )
    # THIS CREATES A BUG
    check_output(
        shlex.split(
            'ovs-ofctl add-flow s3 "ip,priority=65500,nw_src={},nw_dst={},idle_timeout=0,actions=output:{}"'.format(
                h3_ip, h4_ip, s3_s4_port_num
            )
        )
    )
    check_output(
        shlex.split(
            'ovs-ofctl add-flow s3 "ip,priority=65500,nw_src={},nw_dst={},idle_timeout=0,actions=output:{}"'.format(
                h3_ip, h1_ip, s3_s1_port_num
            )
        )
    )
    check_output(
        shlex.split(
            'ovs-ofctl add-flow s3 "ip,priority=65500,nw_src={},nw_dst={},idle_timeout=0,actions=output:{}"'.format(
                h3_ip, h2_ip, s3_s4_port_num
            )
        )
    )
    # OK like this
    check_output(
        shlex.split(
            'ovs-ofctl add-flow s4 "ip,priority=65500,nw_src={},idle_timeout=0,actions=output:{}"'.format(
                h3_ip, s4_h4_port_num
            )
        )
    )
    check_output(
        shlex.split(
            'ovs-ofctl add-flow s4 "ip,priority=65500,nw_dst={},idle_timeout=0,actions=output:{}"'.format(
                h3_ip, s4_s3_port_num
            )
        )
    )
    check_output(
        shlex.split(
            'ovs-ofctl add-flow s4 "ip,priority=65500,nw_dst={},idle_timeout=0,actions=output:{}"'.format(
                h2_ip, s4_s2_port_num
            )
        )
    )

    info("*** h1 & h2 ping 10.0.0.13 with 3 packets: \n")
    ret = h1.cmd("ping -c 3 10.0.0.13")
    print(ret)

    ret = h2.cmd("ping -c 3 10.0.0.13")
    print(ret)

    info("*** h2 ping 10.0.0.14 with 3 packets: (SHOULD FAIL)\n")
    ret = h2.cmd("ping -c 3 10.0.0.14")
    print(ret)

    info("*** Deploy counter service on h3.\n")
    counter_server_h3 = mgr.addContainer(
        "counter_server_h3", "h3", "service_migration", "python /home/server.py h3"
    )
    time.sleep(5)
    info("*** Deploy client app on h1.\n")
    client1_app = mgr.addContainer(
        "client", "h1", "service_migration", "python /home/client.py"
    )
    time.sleep(10)
    client_log = client1_app.getLogs()
    print("\n*** Setup1: Current log of the client: \n{}".format(client_log))

    """
    # NEW
    info("*** Migrate (Re-deploy) the couter service to h4.\n")
    counter_server_h4 = mgr.addContainer(
        "counter_server_h4",
        "h4",
        "service_migration",
        "python /home/server.py h4 --get_state",
    )
    info(
        "*** Send SEGTERM signal to the service running on the h2.\n"
        "Let it transfer its state through the internal network.\n"
    )
    pid_old_service = (
        check_output(shlex.split("pgrep -f '^python /home/server.py h2$'"))
        .decode("utf-8")
        .strip()
    )
    for _ in range(3):
        check_output(shlex.split("kill {}".format(pid_old_service)))
        # Wait a little bit to let the signal work.
        time.sleep(1)

    service_log = counter_server_h3.getLogs()
    print("\n*** Current log of the service on h3: \n{}".format(service_log))

    mgr.removeContainer("counter_server_h2")

    info("*** Mod the added flow to forward traffic from h1 to h3 to switch s1.\n")
    check_output(
        shlex.split(
            'ovs-ofctl mod-flows s1 "in_port={}, actions=output:{}"'.format(
                s1_h1_port_num, s1_h3_port_num
            )
        )
    )

    time.sleep(10)
    client_log = client_app.getLogs()
    print("\n*** Setup2: Current log of the client: \n{}".format(client_log))

    ##########

    info("*** Migrate (Re-deploy) the couter service back to h2.\n")
    counter_server_h2 = mgr.addContainer(
        "counter_server_h2",
        "h2",
        "service_migration",
        "python /home/server.py h2 --get_state",
    )
    pid_old_service = (
        check_output(shlex.split("pgrep -f '^python /home/server.py h3 --get_state$'"))
        .decode("utf-8")
        .strip()
    )
    print(f"The PID of the old service: {pid_old_service}")
    for _ in range(3):
        check_output(shlex.split("kill {}".format(pid_old_service)))
        # Wait a little bit to let the signal work.
        time.sleep(1)

    service_log = counter_server_h2.getLogs()
    print("\n*** Current log of the service on h2: \n{}".format(service_log))
    mgr.removeContainer("counter_server_h3")

    info("*** Mod the added flow to forward traffic from h1 back to h2 to switch s1.\n")
    check_output(
        shlex.split(
            'ovs-ofctl mod-flows s1 "in_port={}, actions=output:{}"'.format(
                s1_h1_port_num, s1_h2_port_num
            )
        )
    )

    time.sleep(10)
    client_log = client_app.getLogs()
    print("\n*** Setup3: Current log of the client: \n{}".format(client_log))
    """
    if not AUTOTEST_MODE:
        CLI(net)

    mgr.removeContainer("counter_server_h3")

    net.stop()
    mgr.stop()
"""
    try:
        mgr.removeContainer("counter_server_h2")
        mgr.removeContainer("counter_server_h3")
    except Exception as e:
        print(e)
    finally:
        net.stop()
        mgr.stop()
"""
