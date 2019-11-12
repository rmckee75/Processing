import time
from analogio import AnalogIn #pylint: disable-msg=import-error
import board #pylint: disable-msg=import-error
import busio #pylint: disable-msg=import-error
potentio = AnalogIn(board.A2)
# the potentiometer is plugged into analog pin 2
uart = busio.UART(board.D1, board.D0, baudrate=9600)
# creates a UART cable (plugged into TX (D1) and RX (D2) pins)

while True:
    PotVal = round(potentio.value/257)
    # scales the potentiometer values (0 to 65535) to the range of byte values for the UART (0 to 255)
    uart.write(bytes(PotVal))
    # converts value to bytes so it can be sent through UART
    print(PotVal)
    time.sleep(.05)