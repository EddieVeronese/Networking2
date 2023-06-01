from tkinter import *
from PIL import ImageTk, Image
from tkinter import filedialog
import customtkinter as ctk
import os

#Import the required Libraries
from tkinter import *
from PIL import Image,ImageTk

#Create an instance of tkinter frame
win = ctk.CTk()

#Set the geometry of tkinter frame
win.geometry("750x250")

#Create a canvas
canvas= Canvas(win, width= 600, height= 400)
canvas.pack()

#Load an image in the script
#img= ImageTk.PhotoImage(Image.open("/Users/fed/Desktop/PROGETTO GRANELLI/Networking2/scenario3/rete.gif"))

image=Image.open('/Users/fed/Desktop/PROGETTO GRANELLI/Networking2/scenario3/rete.gif')
#gif1 = ImageTk.PhotoImage(file='/Users/fed/Desktop/PROGETTO GRANELLI/Networking2/scenario3/rete.gif')
img=image.resize((500, 500))
my_img=ImageTk.PhotoImage(img)

#Add image to the Canvas Items
canvas.create_image(10,10,anchor=NW,image=my_img)

win.mainloop()

