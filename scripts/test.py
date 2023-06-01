from tkinter import *
from PIL import ImageTk, Image
from tkinter import filedialog
import customtkinter as ctk
import os

#Import the required Libraries
from tkinter import *
from PIL import Image,ImageTk

ctk.set_appearance_mode("System")  # Modes: "System" (standard), "Dark", "Light"
ctk.set_default_color_theme("blue")  # Themes: "blue" (standard), "green", "dark-blue"



class App(ctk.CTk):

    def __init__(self):
        super().__init__()

        self.geometry("1000x800")
        self.grid_rowconfigure(1, weight=1)  # configure grid system
        self.grid_rowconfigure((2,3), weight=1)
        self.grid_columnconfigure((0,1,2), weight=1)

        central_frame = ctk.CTkFrame(self , corner_radius=0)
        central_frame.grid(row=0, column=1, rowspan=3, columnspan=3, sticky="nswe" )

        # inserting the image
        self.canvas= Canvas(central_frame, width= 500, height= 350)
        self.canvas.pack(side="right", fill="both", expand=True)
        image=Image.open('/Users/fed/Desktop/PROGETTO GRANELLI/Networking2/scripts/rete.png')
        img=image.resize((850, 650))
        self.rete_img=ImageTk.PhotoImage(img)
        self.canvas.create_image(5,5,anchor=NW,image=self.rete_img)

        self.arr_lines = [None]*20
        left_frame =  ctk.CTkFrame(self, width=140, height=800, corner_radius=0)
        left_frame.grid(row=0, column=0, rowspan=3, columnspan=2, sticky="nsw")
        left_frame.grid_rowconfigure((1,2,3), weight=1)

        btn_scenario1 = ctk.CTkButton(left_frame, text="btn1", command=lambda: button_event1())
        btn_scenario2 = ctk.CTkButton(left_frame, text="btn2", command=lambda: clear_lines())
        btn_scenario3 = ctk.CTkButton(left_frame, text="btn3", command=lambda: button_scenario4())

        btn_scenario1.grid(row=1, column=0, padx=20, pady=10)
        btn_scenario2.grid(row=2, column=0, padx=20, pady=10)
        btn_scenario3.grid(row=3, column=0, padx=20, pady=10)

       

    
        

def button_event1():

    clear_lines()
    ## DEFAULT SCENARIO

    #lines between hosts and switches
    app.arr_lines[0] = h11_s1_line = app.canvas.create_line(260,130,260,200, fill="yellow", width=5)
    app.arr_lines[1] = h9_s1_line = app.canvas.create_line(170,130,220,200, fill="green", width=5)
    app.arr_lines[2] = h1_s1_line = app.canvas.create_line(130,190,200,220, fill="blue", width=5)
    app.arr_lines[3] = h3_s1_line = app.canvas.create_line(130,290,200,250, fill="green", width=5)

    app.arr_lines[4] = h5_s2_line = app.canvas.create_line(130,450,200,480, fill="green", width=5)
    app.arr_lines[5] = h7_s2_line = app.canvas.create_line(130,540,200,510, fill="green", width=5)

    app.arr_lines[6] = h10_s6_line = app.canvas.create_line(600,130,600,200, fill="green", width=5)
    app.arr_lines[7] = h12_s6_line = app.canvas.create_line(680,130,630,200, fill="yellow", width=5)
    app.arr_lines[8] = h2_s6_line = app.canvas.create_line(730,200,650,230, fill="green", width=5)
    app.arr_lines[9] = h4_s6_line = app.canvas.create_line(730,280,650,250, fill="green", width=5)

    app.arr_lines[10] = h6_s7_line = app.canvas.create_line(730,450,650,480, fill="green", width=5)
    app.arr_lines[11] = h8_s7_line = app.canvas.create_line(730,540,650,510, fill="green", width=5)

    # lines just between switches
    app.arr_lines[12] = s4_s7_line = app.canvas.create_line(470,400,560,480, fill="green", width=5)
    app.arr_lines[13] = s5_s7_line = app.canvas.create_line(480,600,580,530, fill="green", width=5)

    app.arr_lines[14] = s2_s4_line = app.canvas.create_line(290,470,380,400, fill="green", width=5)
    app.arr_lines[15] = s2_s5_line = app.canvas.create_line(290,530,380,590, fill="green", width=5)

    app.arr_lines[16] = s1_s3_line = app.canvas.create_line(290,200,380,140, fill="yellow", width=5)
    app.arr_lines[17] = s1_s4_line = app.canvas.create_line(290,260,380,330, fill="green", width=5)

    app.arr_lines[18] = s4_s6_line = app.canvas.create_line(470,340,550,260, fill="green", width=5)
    app.arr_lines[19] =  s3_s6_line = app.canvas.create_line(480,140,570,200, fill="yellow", width=5)



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




app = App()









app.mainloop()