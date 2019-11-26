import time
from analogio import AnalogIn
import board
import busio
import pulseio
from adafruit_motor import servo
uart = busio.UART(board.D1, board.D0, baudrate=9600)
# creates a UART cable (plugged into TX (D1) and RX (D2) pins)
pwm1 = pulseio.PWMOut(board.A2, duty_cycle=2 ** 15, frequency = 50)
pwm2 = pulseio.PWMOut(board.A3, duty_cycle=2 ** 15, frequency = 50)
# creates two servos (plugged into A2 and A3) with the pulseio module and sets duty_cycle (percentage of time pulses are high) and frequency (of pulses)
servo1 = servo.Servo(pwm1)
servo2 = servo.Servo(pwm2)
c = 1
d = 1
# counters for angle1 and angle2 start at 0
h1 = 0
t1 = 0
o1 = 0
h2 = 0
t2 = 0
o2 = 0
angle1 = 0
angle2 = 0
while True:
    values = uart.read(1)
    # read the UART values one byte at a time
    if values is not None:
        # if values are being sent
        angle = values.decode("utf-8")
        # converts them to text format
        if angle is not "," and angle is not "$":
            if c is 1:
                h1 = int(angle) * 100
            # multiply the first integer by 100 to create the hundreds place
            if c is 2:
                t1 = int(angle) * 10
            # then the second by 10
            if c is 3:
                o1 = int(angle) * 1
            # and the last one by 1
            c = c + 1
            # move down one place value each time an angle is recieved
            if d is 1:
                h2 = int(angle) * 100
            if d is 2:
                t2 = int(angle) * 10
            if d is 3:
                o2 = int(angle) * 1
            d = d + 1
            angle1 = h1 + t1 + o1
            angle2 = h2 + t2 + o2
            # add the hundreds, tens, and ones places to make the angle
        if angle is ",":
            d = 1
        if angle is "$":
            c = 1
        # when you reach the end of the angle, return the counter to 1 (the 100s place)
        print(angle1)
        print(angle2)
        if angle1 < 180:
            servo1.angle = angle1
        if angle2 < 180:
            servo2.angle = angle2
        # set the servos to the angle (if it is a viable angle under 180 degrees)
