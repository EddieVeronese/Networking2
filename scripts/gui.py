from tkinter import *
from PIL import ImageTk, Image
from tkinter import filedialog
import customtkinter as ctk
import os
import subprocess

#Import the required Libraries
from tkinter import *
from PIL import Image,ImageTk

ctk.set_appearance_mode("Dark")  # Modes: "System" (standard), "Dark", "Light"
ctk.set_default_color_theme("blue")  # Themes: "blue" (standard), "green", "dark-blue"

scenario3_slice1_on = False
scenario3_slice2_on = False
scenario3_slice3_on = False
scenario3_slice4_on = False


class App(ctk.CTk):

    def __init__(self):
        super().__init__()

        self.geometry("1180x880")
        self.grid_rowconfigure(1, weight=1)  # configure grid system
        self.grid_rowconfigure((2,3), weight=1)
        self.grid_columnconfigure((0,1,2), weight=1)

        central_frame = ctk.CTkFrame(self , corner_radius=0)
        central_frame.grid(row=0, column=1, rowspan=3, columnspan=3, sticky="nswe" )

        # inserting the image
        self.canvas= Canvas(central_frame, width= 500, height= 350)
        self.canvas.pack(side="right", fill="both", expand=True)

        # add riferimento locale
        image=Image.open('rete.png')
        img=image.resize((850, 650))
        self.rete_img=ImageTk.PhotoImage(img)
        self.canvas.create_image(5,5,anchor=NW,image=self.rete_img)

        self.arr_lines = [None]*35
        left_frame =  ctk.CTkFrame(self, width=140, height=800, corner_radius=0)
        left_frame.grid(row=0, column=0, rowspan=3, columnspan=2, sticky="nsw")
        left_frame.grid_rowconfigure((1,2,3,4,5), weight=1)

        bottom_frame =  ctk.CTkFrame(self, width=1000, height=50,  corner_radius=0)
        bottom_frame.grid(row=3, column=0, rowspan=3, columnspan=3, sticky="swe")
        bottom_frame.grid_columnconfigure((1,2,3,4), weight=1)

        btn_scenarioD = ctk.CTkButton(left_frame, text="default", command=button_scenarioD)
        btn_scenario1 = ctk.CTkButton(left_frame, text="scenario1", command=button_scenario1)
        btn_scenario2 = ctk.CTkButton(left_frame, text="scenario2", command=button_scenario2)
        btn_scenario3 = ctk.CTkButton(left_frame, text="scenario3", command=button_scenario3)
        btn_scenario4 = ctk.CTkButton(left_frame, text="scenario4", command=button_scenario4)

        btn_scenarioD.grid(row=1, column=0, padx=20, pady=10)
        btn_scenario1.grid(row=2, column=0, padx=20, pady=10)
        btn_scenario2.grid(row=3, column=0, padx=20, pady=10)
        btn_scenario3.grid(row=4, column=0, padx=20, pady=10)
        btn_scenario4.grid(row=5, column=0, padx=20, pady=10)

        self.sub_button1 = ctk.CTkButton(bottom_frame, text="slice1", command=button_scenario3_slice1, state= DISABLED)
        self.sub_button2 = ctk.CTkButton(bottom_frame, text="slice2", command=button_scenario3_slice2, state= DISABLED)
        self.sub_button3 = ctk.CTkButton(bottom_frame, text="slice3", command=button_scenario3_slice3, state= DISABLED)
        self.sub_button4 = ctk.CTkButton(bottom_frame, text="slice4", command=button_scenario3_slice4, state= DISABLED)

        self.sub_button1.grid(row=0, column=0, padx=10, pady=20)
        self.sub_button2.grid(row=0, column=1, padx=10, pady=20)
        self.sub_button3.grid(row=0, column=2, padx=10, pady=20)
        self.sub_button4.grid(row=0, column=3, padx=10, pady=20)
       

def button_scenarioD():
    disble_bottom_btn()
    clear_lines()
    ## DEFAULT SCENARIO
    subprocess.call("./default.sh")	

    #lines between hosts and switches
    app.arr_lines[0] = h11_s1_line = app.canvas.create_line(260,130,260,200, fill="", width=5)
    app.arr_lines[1] = h9_s1_line = app.canvas.create_line(170,130,220,200, fill="", width=5)
    app.arr_lines[2] = h1_s1_line = app.canvas.create_line(130,190,200,220, fill="blue", width=5)
    app.arr_lines[3] = h3_s1_line = app.canvas.create_line(130,290,200,250, fill="violet", width=5)

    app.arr_lines[4] = h5_s2_line = app.canvas.create_line(130,450,200,480, fill="red", width=5)
    app.arr_lines[5] = h7_s2_line = app.canvas.create_line(130,540,200,510, fill="orange", width=5)

    app.arr_lines[6] = h10_s6_line = app.canvas.create_line(600,130,600,200, fill="", width=5)
    app.arr_lines[7] = h12_s6_line = app.canvas.create_line(680,130,630,200, fill="", width=5)
    app.arr_lines[8] = h2_s6_line = app.canvas.create_line(730,200,650,230, fill="blue", width=5)
    app.arr_lines[9] = h4_s6_line = app.canvas.create_line(730,280,650,250, fill="violet", width=5)

    app.arr_lines[10] = h6_s7_line = app.canvas.create_line(730,450,650,480, fill="red", width=5)
    app.arr_lines[11] = h8_s7_line = app.canvas.create_line(730,540,650,510, fill="orange", width=5)

    # lines just between switches
    app.arr_lines[12] = s4_s7_line = app.canvas.create_line(470,400,560,480, fill="red", width=5)
    app.arr_lines[13] = s5_s7_line = app.canvas.create_line(480,600,580,530, fill="orange", width=5)

    app.arr_lines[14] = s2_s4_line = app.canvas.create_line(290,470,380,400, fill="red", width=5)
    app.arr_lines[15] = s2_s5_line = app.canvas.create_line(290,530,380,590, fill="orange", width=5)

    app.arr_lines[16] = s1_s3_line = app.canvas.create_line(290,200,380,140, fill="blue", width=5)
    app.arr_lines[17] = s1_s4_line = app.canvas.create_line(290,260,380,330, fill="violet", width=5)

    app.arr_lines[18] = s4_s6_line = app.canvas.create_line(470,340,550,260, fill="violet", width=5)
    app.arr_lines[19] = s3_s6_line = app.canvas.create_line(480,140,570,200, fill="blue", width=5)


def button_scenario1():
    disble_bottom_btn()
    clear_lines()
    ## SCENARIO 1
    subprocess.call("./scenario1.sh")

    #lines between hosts and switches
    app.arr_lines[0] = h11_s1_line = app.canvas.create_line(260,130,260,200, fill="", width=5)
    app.arr_lines[1] = h9_s1_line = app.canvas.create_line(170,130,220,200, fill="", width=5)
    app.arr_lines[2] = h1_s1_line = app.canvas.create_line(130,190,200,220, fill="blue", width=5)
    app.arr_lines[3] = h3_s1_line = app.canvas.create_line(130,290,200,250, fill="violet", width=5)

    app.arr_lines[4] = h5_s2_line = app.canvas.create_line(130,450,200,480, fill="red", width=5)
    app.arr_lines[5] = h7_s2_line = app.canvas.create_line(130,540,200,510, fill="green", width=5)

    app.arr_lines[6] = h10_s6_line = app.canvas.create_line(600,130,600,200, fill="", width=5)
    app.arr_lines[7] = h12_s6_line = app.canvas.create_line(680,130,630,200, fill="", width=5)
    app.arr_lines[8] = h2_s6_line = app.canvas.create_line(730,200,650,230, fill="blue", width=5)
    app.arr_lines[9] = h4_s6_line = app.canvas.create_line(730,280,650,250, fill="violet", width=5)

    app.arr_lines[10] = h6_s7_line = app.canvas.create_line(730,450,650,480, fill="red", width=5)
    app.arr_lines[11] = h8_s7_line = app.canvas.create_line(730,540,650,510, fill="green", width=5)

    # lines just between switches
    app.arr_lines[12] = s4_s7_line = app.canvas.create_line(470,410,560,490, fill="red", width=5)
    app.arr_lines[13] = s5_s7_line = app.canvas.create_line(470,400,560,480, fill="green", width=5)

    app.arr_lines[14] = s2_s4_line = app.canvas.create_line(290,480,380,410, fill="red", width=5)
    app.arr_lines[15] = s2_s5_line = app.canvas.create_line(290,470,380,400, fill="green", width=5)

    app.arr_lines[16] = s1_s3_line = app.canvas.create_line(290,200,380,140, fill="blue", width=5)
    app.arr_lines[17] = s1_s4_line = app.canvas.create_line(290,190,380,130, fill="violet", width=5)

    app.arr_lines[18] = s4_s6_line = app.canvas.create_line(480,130,570,190, fill="violet", width=5)
    app.arr_lines[19] = s3_s6_line = app.canvas.create_line(480,140,570,200, fill="blue", width=5)

def button_scenario2():
    disble_bottom_btn()
    clear_lines()
    ## SCENARIO 2 
    subprocess.call("./scenario2.sh")

    #lines between hosts and switches
    app.arr_lines[0] = h11_s1_line = app.canvas.create_line(260,130,260,200, fill="purple", width=5)
    app.arr_lines[1] = h9_s1_line = app.canvas.create_line(170,130,220,200, fill="green", width=5)
    app.arr_lines[2] = h1_s1_line = app.canvas.create_line(130,190,200,220, fill="blue", width=5)
    app.arr_lines[3] = h3_s1_line = app.canvas.create_line(130,290,200,250, fill="violet", width=5)

    app.arr_lines[4] = h5_s2_line = app.canvas.create_line(130,450,200,480, fill="red", width=5)
    app.arr_lines[5] = h7_s2_line = app.canvas.create_line(130,540,200,510, fill="orange", width=5)

    app.arr_lines[6] = h10_s6_line = app.canvas.create_line(600,130,600,200, fill="green", width=5)
    app.arr_lines[7] = h12_s6_line = app.canvas.create_line(680,130,630,200, fill="purple", width=5)
    app.arr_lines[8] = h2_s6_line = app.canvas.create_line(730,200,650,230, fill="blue", width=5)
    app.arr_lines[9] = h4_s6_line = app.canvas.create_line(730,280,650,250, fill="violet", width=5)

    app.arr_lines[10] = h6_s7_line = app.canvas.create_line(730,450,650,480, fill="red", width=5)
    app.arr_lines[11] = h8_s7_line = app.canvas.create_line(730,540,650,510, fill="orange", width=5)

    # lines just between switches
    app.arr_lines[12] = s4_s7_line = app.canvas.create_line(470,400,560,480, fill="red", width=5)
    app.arr_lines[13] = s5_s7_line = app.canvas.create_line(480,600,580,530, fill="orange", width=5)

    app.arr_lines[14] = s2_s4_line = app.canvas.create_line(290,470,380,400, fill="red", width=5)
    app.arr_lines[15] = s2_s5_line = app.canvas.create_line(290,530,380,590, fill="orange", width=5)

    app.arr_lines[16] = s1_s3_line = app.canvas.create_line(290,200,380,140, fill="blue", width=5)
    app.arr_lines[17] = s1_s3_line2 = app.canvas.create_line(290,190,380,130, fill="green", width=5)
    app.arr_lines[20] = s1_s4_line = app.canvas.create_line(290,260,380,330, fill="violet", width=5)
    app.arr_lines[21] = s1_s4_line2 = app.canvas.create_line(290,250,380,320, fill="purple", width=5)

    app.arr_lines[18] = s4_s6_line = app.canvas.create_line(470,340,550,260, fill="violet", width=5)
    app.arr_lines[22] = s4_s6_line2 = app.canvas.create_line(470,330,550,250, fill="purple", width=5)
    app.arr_lines[19] = s3_s6_line = app.canvas.create_line(480,140,570,200, fill="blue", width=5)
    app.arr_lines[23] = s3_s6_line2 = app.canvas.create_line(480,130,570,190, fill="green", width=5)


def button_scenario3():
    subprocess.call("./scenario3.sh")

    clear_lines()
    enable_bottom_btn()


def button_scenario3_slice1():
    global scenario3_slice1_on

    if scenario3_slice1_on == False:    
        subprocess.call("./scenario3_slice1.sh")

        #lines between hosts and switches
        app.arr_lines[0] = h1_s1_line = app.canvas.create_line(130,185,200,215, fill="blue", width=5)
        app.arr_lines[1] = h3_s1_line = app.canvas.create_line(130,285,200,245, fill="blue", width=5)
        app.arr_lines[2] = h2_s6_line = app.canvas.create_line(730,195,650,225, fill="blue", width=5)
        app.arr_lines[3] = h4_s6_line = app.canvas.create_line(730,275,650,245, fill="blue", width=5)

        # lines just between switches
        app.arr_lines[4] = s1_s3_line = app.canvas.create_line(290,195,380,135, fill="blue", width=5)
        app.arr_lines[5] = s1_s4_line = app.canvas.create_line(290,255,380,325, fill="blue", width=5)
        app.arr_lines[6] = s4_s6_line = app.canvas.create_line(470,335,550,255, fill="blue", width=5)
        app.arr_lines[7] =  s3_s6_line = app.canvas.create_line(480,135,570,195, fill="blue", width=5)
    
        scenario3_slice1_on = True
    else:
        i=0
        while i<8:
            app.canvas.delete(app.arr_lines[i])
            i += 1

        scenario3_slice1_on = False
        scenario3_update()


def button_scenario3_slice2():
    global scenario3_slice2_on

    if scenario3_slice2_on == False:
        subprocess.call("./scenario3_slice2.sh")

        #lines between hosts and switches
        app.arr_lines[8] = h5_s2_line = app.canvas.create_line(130,445,200,475, fill="yellow", width=5)
        app.arr_lines[9] = h7_s2_line = app.canvas.create_line(130,535,200,505, fill="yellow", width=5)
        app.arr_lines[10] = h6_s7_line = app.canvas.create_line(730,445,650,475, fill="yellow", width=5)
        app.arr_lines[11] = h8_s7_line = app.canvas.create_line(730,535,650,505, fill="yellow", width=5)

        # lines just between switches
        app.arr_lines[12] = s4_s7_line = app.canvas.create_line(470,395,560,475, fill="yellow", width=5)
        app.arr_lines[13] = s5_s7_line = app.canvas.create_line(480,595,580,525, fill="yellow", width=5)
        app.arr_lines[14] = s2_s4_line = app.canvas.create_line(290,465,380,395, fill="yellow", width=5)
        app.arr_lines[15] = s2_s5_line = app.canvas.create_line(290,525,380,585, fill="yellow", width=5)

        scenario3_slice2_on = True
    else:
        i=8
        while i<16:
            app.canvas.delete(app.arr_lines[i])
            i += 1

        scenario3_slice2_on = False
        scenario3_update()


def button_scenario3_slice3():
    global scenario3_slice3_on

    if scenario3_slice3_on == False:
        subprocess.call("./scenario3_slice3.sh")

        #lines between hosts and switches
        app.arr_lines[16] = h1_s1_line = app.canvas.create_line(130,195,200,225, fill="black", width=5)
        app.arr_lines[17] = h3_s1_line = app.canvas.create_line(130,295,200,255, fill="black", width=5)
        app.arr_lines[18] = h2_s6_line = app.canvas.create_line(730,205,650,235, fill="black", width=5)
        app.arr_lines[19] = h4_s6_line = app.canvas.create_line(730,285,650,255, fill="black", width=5)


        # lines just between switches
        app.arr_lines[20] = s1_s3_line = app.canvas.create_line(290,205,380,145, fill="black", width=5)
        app.arr_lines[21] = s1_s4_line = app.canvas.create_line(290,264,380,335, fill="black", width=5)
        app.arr_lines[22] = s4_s6_line = app.canvas.create_line(470,345,550,265, fill="black", width=5)
        app.arr_lines[23] =  s3_s6_line = app.canvas.create_line(480,145,570,205, fill="black", width=5)

        scenario3_slice3_on = True
    else:
        i=16
        while i<24:
            app.canvas.delete(app.arr_lines[i])
            i += 1

        scenario3_slice3_on = False
        scenario3_update()


def button_scenario3_slice4():
    global scenario3_slice4_on

    if scenario3_slice4_on == False:
        subprocess.call("./scenario3_slice4.sh")

        #lines between hosts and switches
        app.arr_lines[24] = h5_s2_line = app.canvas.create_line(130,455,200,485, fill="red", width=5)
        app.arr_lines[25] = h7_s2_line = app.canvas.create_line(130,545,200,515, fill="red", width=5)
        app.arr_lines[26] = h6_s7_line = app.canvas.create_line(730,455,650,485, fill="red", width=5)
        app.arr_lines[27] = h8_s7_line = app.canvas.create_line(730,545,650,515, fill="red", width=5)

        # lines just between switches
        app.arr_lines[28] = s4_s7_line = app.canvas.create_line(470,405,560,485, fill="red", width=5)
        app.arr_lines[29] = s5_s7_line = app.canvas.create_line(480,605,580,535, fill="red", width=5)
        app.arr_lines[30] = s2_s4_line = app.canvas.create_line(290,475,380,405, fill="red", width=5)
        app.arr_lines[31] = s2_s5_line = app.canvas.create_line(290,535,380,595, fill="red", width=5)

        scenario3_slice4_on = True
    else:
        i=24
        while i<32:
            app.canvas.delete(app.arr_lines[i])
            i += 1

        scenario3_slice4_on = False
        scenario3_update()


def scenario3_update():
    subprocess.call("./scenario3.sh")

    if scenario3_slice1_on == True:
        subprocess.call("./scenario3_slice1.sh")
    elif scenario3_slice2_on == True:
        subprocess.call("./scenario3_slice2.sh")
    elif scenario3_slice3_on == True:
        subprocess.call("./scenario3_slice3.sh")
    elif scenario3_slice4_on == True:
        subprocess.call("./scenario3_slice4.sh")


def button_scenario4():
    disble_bottom_btn()
    clear_lines()
    ## SCENARIO 4
    subprocess.call("./scenario4.sh")
    
    #lines between hosts and switches
    app.arr_lines[0] = h11_s1_line = app.canvas.create_line(260,130,260,200, fill="blue", width=5)

    app.arr_lines[1] = h9_s1_line = app.canvas.create_line(170,130,220,200, fill="blue", width=5)
    app.arr_lines[2] = h1_s1_line = app.canvas.create_line(130,190,200,220, fill="blue", width=5)
    app.arr_lines[3] = h3_s1_line = app.canvas.create_line(130,290,200,250, fill="blue", width=5)

    app.arr_lines[4] = h5_s2_line = app.canvas.create_line(130,450,200,480, fill="yellow", width=5)
    app.arr_lines[5] = h7_s2_line = app.canvas.create_line(130,540,200,510, fill="yellow", width=5)

    
    app.arr_lines[6] = h10_s6_line = app.canvas.create_line(600,130,600,200, fill="yellow", width=5)

    app.arr_lines[7] = h12_s6_line = app.canvas.create_line(680,130,630,200, fill="yellow", width=5)
    app.arr_lines[8] = h2_s6_line = app.canvas.create_line(730,200,650,230, fill="yellow", width=5)
    app.arr_lines[9] = h4_s6_line = app.canvas.create_line(730,280,650,250, fill="yellow", width=5)

    app.arr_lines[10] = h6_s7_line = app.canvas.create_line(730,450,650,480, fill="blue", width=5)
    app.arr_lines[11] = h8_s7_line = app.canvas.create_line(730,540,650,510, fill="blue", width=5)

    # lines just between switches
    app.arr_lines[12] = s4_s7_line = app.canvas.create_line(470,400,560,480, fill="blue", width=5)
    app.arr_lines[13] = s5_s7_line = app.canvas.create_line(480,600,580,530, fill="", width=5)
    app.arr_lines[14] = s2_s4_line = app.canvas.create_line(290,470,380,400, fill="yellow", width=5)

    app.arr_lines[15] = s2_s5_line = app.canvas.create_line(290,530,380,590, fill="", width=5)

    app.arr_lines[16] = s1_s3_line = app.canvas.create_line(290,200,380,140, fill="", width=5)
    app.arr_lines[17] = s1_s4_line = app.canvas.create_line(290,260,380,330, fill="blue", width=5)

    app.arr_lines[18] = s4_s6_line = app.canvas.create_line(470,340,550,260, fill="yellow", width=5)
    app.arr_lines[19] =  s3_s6_line = app.canvas.create_line(480,140,570,200, fill="", width=5)


def clear_lines():
    for line in app.arr_lines:
        app.canvas.delete(line)

def disble_bottom_btn():
    global scenario3_slice1_on
    scenario3_slice1_on = False
    global scenario3_slice2_on
    scenario3_slice2_on = False
    global scenario3_slice3_on
    scenario3_slice3_on = False
    global scenario3_slice4_on
    scenario3_slice4_on = False


    app.sub_button1.configure(state= DISABLED)
    app.sub_button2.configure(state= DISABLED)
    app.sub_button3.configure(state= DISABLED)
    app.sub_button4.configure(state= DISABLED)

def enable_bottom_btn():
    app.sub_button1.configure(state= ACTIVE)
    app.sub_button2.configure(state= ACTIVE)
    app.sub_button3.configure(state= ACTIVE)
    app.sub_button4.configure(state= ACTIVE)


app = App()
app.mainloop()