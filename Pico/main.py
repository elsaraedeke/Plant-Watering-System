from machine import Pin, I2C, ADC
from picobricks import SSD1306_I2C
import time
import json


i2c = I2C(0, sda=Pin(4), scl=Pin(5), freq=400000)

time.sleep(0.1) 

oled = SSD1306_I2C(128, 64, i2c, addr=0x3c)

sensor = ADC(Pin(27))

relay = Pin(12, Pin.OUT)

while True:
    oled.fill(0)
    oled.text("Plant 1: ", 0, 0)

    #read moisture
    raw_value = sensor.read_u16()
    oled.text("Moisture: ", 0, 20)
    oled.text(str(raw_value), 80, 20)

    #pump
    oled.text("Watering: ", 0, 40)
    if (raw_value > 12000): 
        relay.value(1)
        oled.text("On", 80, 40)
        oled.show()
        time.sleep(2)
    else:
        relay.value(0)
        oled.text("Off", 80, 40)
        oled.show()
        time.sleep(2)

    
