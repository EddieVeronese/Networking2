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
from enum import Enum
import subprocess
import threading
import time

class EmergencyType(Enum):
    NONE = 0
    SWITCH_BROKEN = 1
    NEW_HOSTS = 2
    FILTER = 3
    CHANGE_CONNECTION = 4


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
                "00:00:00:00:00:09": 5,
                "00:00:00:00:00:0b": 6
            },

            2: {
                "00:00:00:00:00:05": 4, 
                "00:00:00:00:00:06": 1, 
                "00:00:00:00:00:07": 3, 
                "00:00:00:00:00:08": 2,
            },

            3: {
                "00:00:00:00:00:01": 1,
                "00:00:00:00:00:02": 2, 
            },

            4: {
                "00:00:00:00:00:03": 1, 
                "00:00:00:00:00:04": 2, 
                "00:00:00:00:00:05": 4, 
                "00:00:00:00:00:06": 3
            },

            5: {
                "00:00:00:00:00:07": 1,
                "00:00:00:00:00:08": 2, 
            },

            6: {
                "00:00:00:00:00:01": 1, 
                "00:00:00:00:00:02": 4, 
                "00:00:00:00:00:03": 2, 
                "00:00:00:00:00:04": 3,
                "00:00:00:00:00:0a": 5,
                "00:00:00:00:00:0c": 6
            },

            7: {
                "00:00:00:00:00:05": 1, 
                "00:00:00:00:00:06": 4, 
                "00:00:00:00:00:07": 2, 
                "00:00:00:00:00:08": 3,
            }
        }  
        
        # Set utils for simulating emergency situations
        self.emergency_type = 0
        self.time = time.time()

        self.in_filter = False;
        
        # Listens to the timer() function.  
        self.threadd = threading.Thread(target=self.run_simulation, args=())
        self.threadd.daemon = True
        self.threadd.start()

        

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

        print(f"Eccolo {dst}") 
        
        if dst in self.mac_to_port[dpid]: 

            out_port = self.mac_to_port[dpid][dst]

            actions = [datapath.ofproto_parser.OFPActionOutput(out_port)]

            match = datapath.ofproto_parser.OFPMatch(eth_dst=dst)

            self.add_flow(datapath, 1, match, actions)

            self._send_package(msg, datapath, in_port, actions)
    
        # Function that automates the alternation between Emergency and Non-Emergency Scenario                
    def run_simulation(self):
        time.sleep(5)

        subprocess.run(['python3', 'gui.py'])

        while True:
            
            if self.in_filter == False:
                self.emergency_type = input("\n\nTypes of emergencies:\n \t0 -> No Emergency\n \t1-> Switch Broken\n \t2-> New Hosts\n \t3-> Filter\n \t4-> Chage connection\n Enter value: ")

                if int(self.emergency_type) == EmergencyType.NONE.value:
                    subprocess.call("./default.sh")	

                elif int(self.emergency_type) == EmergencyType.SWITCH_BROKEN.value:
                    subprocess.call("./scenario1.sh")
        
                elif int(self.emergency_type) == EmergencyType.NEW_HOSTS.value:
                    subprocess.call("./scenario2.sh")
                
                elif int(self.emergency_type) == EmergencyType.FILTER.value:
                    subprocess.call("./scenario3_copy.sh")

                    self.in_filter = True;

                elif int(self.emergency_type) == EmergencyType.CHANGE_CONNECTION.value:
                    subprocess.call("./scenario4.sh")
                
                else:
                    print("Command not found, please insert a valid value")
                
                time.sleep(5)
            else:
                self.input_num = int(input("\n\nFilter menu:\n \t0 -> Back to default\n \t1-> Slice 1 on\n \t2-> Slice 2 on\n \t3-> Slice 3 on\n \t4-> Slice 4 on\n Enter value: "))


                if self.input_num == 0:
                    subprocess.call("./default.sh")	
                elif self.input_num == 1:
                    subprocess.call("./scenario3_slice1.sh")	
                elif self.input_num == 2:
                    subprocess.call("./scenario3_slice2.sh")	
                elif self.input_num == 3:
                    subprocess.call("./scenario3_slice3.sh")	
                elif self.input_num == 4:
                    subprocess.call("./scenario3_slice4.sh")	
                else:
                    print("Command not found")

                time.sleep(5)



            
    
