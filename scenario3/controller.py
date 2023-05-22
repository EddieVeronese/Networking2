from ryu.controller import ofp_event
from ryu.controller.handler import set_ev_cls
from ryu.base import app_manager
from ryu.controller.handler import CONFIG_DISPATCHER, MAIN_DISPATCHER
from ryu.ofproto import ofproto_v1_3
from ryu.lib.packet import packet, ipv6, ipv4
from ryu.lib.packet import ethernet
from ryu.lib.packet import ether_types
from ryu.lib.packet import udp
from ryu.lib.packet import tcp
from ryu.lib.packet import icmp
from enum import Enum
import subprocess
import threading
import time


class EmergencyType(Enum):
    NONE = 0
    SWITCH_BROKEN = 1
    NEW_HOSTS = 2


class TrafficSlicing(app_manager.RyuApp):

    OFP_VERSIONS = [ofproto_v1_3.OFP_VERSION]

    def __init__(self, *args, **kwargs):
        super(TrafficSlicing, self).__init__(*args, **kwargs)

        self.mac_to_port = {
            1: {
                "00:00:00:00:00:01": 1, 
                "00:00:00:00:00:02": 2, 
                "00:00:00:00:00:03": 3, 
                "00:00:00:00:00:04": 3
            },

            2: {
                "00:00:00:00:00:02": 1, 
                "00:00:00:00:00:01": 2, 
                "00:00:00:00:00:04": 3, 
                "00:00:00:00:00:04": 3
            },

            3: {
                "00:00:00:00:00:03": 1,
                "00:00:00:00:00:01": 2,
                "00:00:00:00:00:04": 3,
                "00:00:00:00:00:02": 3,
                
            },

            4: {
                "00:00:00:00:00:04": 1, 
                "00:00:00:00:00:03": 2, 
                "00:00:00:00:00:01": 2, 
                "00:00:00:00:00:02": 3
            }
            
        }  
        
        

    @set_ev_cls(ofp_event.EventOFPSwitchFeatures, CONFIG_DISPATCHER)
    def switch_features_handler(self, ev): 
        
        datapath = ev.msg.datapath

        ofproto = datapath.ofproto

        parser = datapath.ofproto_parser

        match = parser.OFPMatch()

        actions = [parser.OFPActionOutput(ofproto.OFPP_CONTROLLER, ofproto.OFPCML_NO_BUFFER)]

        self.add_flow(datapath, 0, match, actions)
    
    def add_flow(self, datapath, priority, match, actions):

        ofproto = datapath.ofproto

        parser = datapath.ofproto_parser

        mod = parser.OFPFlowMod(
            datapath = datapath,
            priority = priority,
            match = match,
            instructions = [parser.OFPInstructionActions(ofproto.OFPIT_APPLY_ACTIONS, actions)]
        )

        datapath.send_msg(mod)

    def _send_package(self, msg, datapath, in_port, actions):

        data = None

        if msg.buffer_id == datapath.ofproto.OFP_NO_BUFFER:
            data = msg.data

        out = datapath.ofproto_parser.OFPPacketOut(
            datapath = datapath,
            buffer_id = msg.buffer_id,
            in_port = in_port,
            actions = actions,
            data = data,
        )

        datapath.send_msg(out)

    @set_ev_cls(ofp_event.EventOFPPacketIn, MAIN_DISPATCHER)
    def _packet_in_handler(self, ev):
        msg = ev.msg

        datapath = msg.datapath

        in_port = msg.match["in_port"]

        pkt = packet.Packet(msg.data)

        eth = pkt.get_protocol(ethernet.ethernet)

        print("Sono qua")

        if eth.ethertype == ether_types.ETH_TYPE_LLDP:
            return
        
        if eth.ethertype == ether_types.ETH_TYPE_IPV6:
            ipv6_pkt = pkt.get_protocol(ipv6.ipv6)
            ip_dst = ipv6_pkt.dst
        else:
            ipv4_pkt = pkt.get_protocol(ipv4.ipv4)
            ip_dst = ipv4_pkt.ipv4_dst
            print(f"IPv4 {ip_dst}")
        
        dst = eth.dst

        dpid = datapath.id

        print(f"Eccolo {dst} e {dpid}")

        if dst in self.mac_to_port[dpid]: 
            print("Eccolo")

            out_port = self.mac_to_port[dpid][dst]

            actions = [datapath.ofproto_parser.OFPActionOutput(out_port)]

            match = datapath.ofproto_parser.OFPMatch(eth_dst=dst)

            self.add_flow(datapath, 1, match, actions)

            self._send_package(msg, datapath, in_port, actions)
    
        
            
    
