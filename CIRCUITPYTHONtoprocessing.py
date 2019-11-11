import time
from analogio import AnalogIn #pylint: disable-msg=import-error
import board #pylint: disable-msg=import-error
import busio #pylint: disable-msg=import-error
potentio = AnalogIn(board.A2)
uart = busio.UART(board.D1, board.D0, baudrate=9600)

while True:
    PotVal = round(potentio.value/257)
    uart.write(bytes(PotVal))
    print(PotVal)
    time.sleep(.05)