from tkinter import *
from PIL import ImageTk, Image
from tkinter import filedialog
import customtkinter as ctk
import os

#Import the required Libraries
from tkinter import *
from PIL import Image,ImageTk

ctk.set_appearance_mode("Dark")  # Modes: "System" (standard), "Dark", "Light"
ctk.set_default_color_theme("blue")  # Themes: "blue" (standard), "green", "dark-blue"


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
        image=Image.open('/Users/fed/Desktop/PROGETTO GRANELLI/Networking2/scripts/rete.png')
        img=image.resize((850, 650))
        self.rete_img=ImageTk.PhotoImage(img)
        self.canvas.create_image(5,5,anchor=NW,image=self.rete_img)

        self.arr_lines = [None]*24
        left_frame =  ctk.CTkFrame(self, width=140, height=800, corner_radius=0)
        left_frame.grid(row=0, column=0, rowspan=3, columnspan=2, sticky="nsw")
        left_frame.grid_rowconfigure((1,2,3,4,5), weight=1)

        bottom_frame =  ctk.CTkFrame(self, width=1000, height=50,  corner_radius=0)
        bottom_frame.grid(row=3, column=0, rowspan=3, columnspan=3, sticky="swe")
        bottom_frame.grid_columnconfigure((1,2,3,4), weight=1)

        btn_scenarioD = ctk.CTkButton(left_frame, text="default", command=button_scenarioD)
        btn_scenario1 = ctk.CTkButton(left_frame, text="scenario1", command=button_scenario1)
        btn_scenario2 = ctk.CTkButton(left_frame, text="scenario2", command=button_scenario2)
        btn_scenario3 = ctk.CTkButton(left_frame, text="clear1", command=clear_lines)
        btn_scenario4 = ctk.CTkButton(left_frame, text="scenario4", command=button_scenario4)

        btn_scenarioD.grid(row=1, column=0, padx=20, pady=10)
        btn_scenario1.grid(row=2, column=0, padx=20, pady=10)
        btn_scenario2.grid(row=3, column=0, padx=20, pady=10)
        btn_scenario3.grid(row=4, column=0, padx=20, pady=10)
        btn_scenario4.grid(row=5, column=0, padx=20, pady=10)

        self.sub_button1 =ctk.CTkButton(bottom_frame, text="sub1", command=button_scenarioD, state= DISABLED)
        self.sub_button2 = ctk.CTkButton(bottom_frame, text="sub2", command=button_scenario1, state= DISABLED)
        self.sub_button3 = ctk.CTkButton(bottom_frame, text="sub3", command=button_scenario2, state= DISABLED)
        self.sub_button4 = ctk.CTkButton(bottom_frame, text="sub4", command=clear_lines, state= DISABLED)

        self.sub_button1.grid(row=0, column=0, padx=10, pady=20)
        self.sub_button2.grid(row=0, column=1, padx=10, pady=20)
        self.sub_button3.grid(row=0, column=2, padx=10, pady=20)
        self.sub_button4.grid(row=0, column=3, padx=10, pady=20)
       

def button_scenarioD():

    clear_lines()
    ## DEFAULT SCENARIO

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

    clear_lines()
    ## SCENARIO 1

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

    clear_lines()
    ## DEFAULT SCENARIO

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


def button_scenario4():

    clear_lines()
    ## SCENARIO 4
    
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