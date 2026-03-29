# Plant-Watering-System
KHE '26 Embedded Systems project: automated watering system using RPI, Flask, Python, Flutter

## The Team
- Vivian Chuang
- Elsa Raedeke
- Alexander Renteria
- Tim Ng

## Description
Our project is a smart irrigation system + mobile app that has been designed to automate plant care for our target audience of cavemen to bring them into the age of agriculture. One of the key hurdles that prevented cavemen from having flourishing societies was having to constantly be on the move to follow their prey, but with our watering system, we can allow for cavemen to begin settling down and creating villages. 

## At its Core
We employed a Picobricks board with a Raspberry Pi Pico, a water pump/motor, MicroPython, Flutter, and Flask in order to measure moisture levels of the soil and pump water when the levels drop below a certain threshold. Our RPI then feeds data to our mobile app to allow users to see their water levels on the go. 

## Setup & Installation
  1. Flash MicroPython (Pico)
     
     - Install MicroPython on your Pico if not already done
       
  2. Upload Code to Pico
     - While connected to the Pico, in terminal type:
       ```
       ls /dev/tty.*
       mpremote connect /dev/tty.<PORT> fs cp main.py :
       mpremote connect /dev/tty.<PORT> run main.py
       ```
      
  3. Run Flutter App
     Build the apk using: ```flutter build apk```
     You can install it just by finding it in your downloads folder on your Android device and clicking install.
       
       

