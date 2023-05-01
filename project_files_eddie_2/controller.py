from ryu.controller import ofp_event
from ryu.controller.handler import set_ev_cls
from ryu.base import app_manager
from ryu.controller.handler import CONFIG_DISPATCHER, MAIN_DISPATCHER
from ryu.ofproto import ofproto_v1_3
from ryu.lib.packet import packet
from ryu.lib.packet import ethernet
from ryu.lib.packet import ether_types
from ryu.lib.packet import udp
from ryu.lib.packet import tcp
from ryu.lib.packet import icmp
import subprocess
import threading
import time


class TrafficSlicing(app_manager.RyuApp):

    OFP_VERSIONS = [ofproto_v1_3.OFP_VERSION]

    def __init__(self, *args, **kwargs):
        super(TrafficSlicing, self).__init__(*args, **kwargs)

        self.mac_to_port = {
            
            1: {
                "00:00:00:00:00:01": 4, 
                "00:00:00:00:00:02": 1, 
                "00:00:00:00:00:03": 3, 
                "00:00:00:00:00:04": 2,
            },

            3: {
                "00:00:00:00:00:01": 1,
                "00:00:00:00:00:02": 2, 
            },

            2: {
                "00:00:00:00:00:03": 1, 
                "00:00:00:00:00:04": 2
            },

            4: {
                "00:00:00:00:00:01": 1, 
                "00:00:00:00:00:02": 4, 
                "00:00:00:00:00:03": 2, 
                "00:00:00:00:00:04": 3,
            },
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

        if eth.ethertype == ether_types.ETH_TYPE_LLDP:
            return
        
        dst = eth.dst

        dpid = datapath.id

        if dst in self.mac_to_port[dpid]: 

            out_port = self.mac_to_port[dpid][dst]

            actions = [datapath.ofproto_parser.OFPActionOutput(out_port)]

            match = datapath.ofproto_parser.OFPMatch(eth_dst=dst)

            self.add_flow(datapath, 1, match, actions)

            self._send_package(msg, datapath, in_port, actions)