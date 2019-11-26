import processing.serial.*;
Serial myPort;
// imports the serial port for UART
float y = 0;
float xAngle = 0;
int XANGLE = 0;
float yAngle = 0;
int YANGLE = 0;
int xdegreepos = 190;
int ydegreepos = 490;
int yANGLE = 0;
String values;
//a string of integers and characters will be sent over UART
void setup () {
  println("Available serial ports:");
  printArray(Serial.list());
  // prints all the available serial ports
  myPort = new Serial(this, Serial.list()[2], 9600);
  // chooses the 3rd serial port for UART (1st port - COM3, 2nd port - Metro)
  size (600, 700);
  // creates a 600 x 700 screen
}
void draw () {
  background (255, 150, 100);
  // colors the screen orange
  stroke (0, 0, 255);
  line (0, 300, 600, 300);
  line (300, 0, 300, 700);
  line (0, 600, 600, 600);
  //draws a 4-quadrant graph with blue lines
  y = mouseY;
  xAngle = map (mouseX, 0, 600, 0, 180);
  //the x angle is converted from the mouse position (0-600) to an angle (0-180)
  XANGLE = int (xAngle);
  // and then made into a integer
  yAngle = map (mouseY, 0, 600, 0, 180);
  YANGLE = int (yAngle);
  yANGLE = YANGLE;
  if (mouseY > 600) {
    y = 600;
  }
  // prevents mouse circle from going into text area
  if (YANGLE > 180) {
    yANGLE = 180;
  }
  fill (0, 0, 255);
  ellipse (mouseX, y, 15, 15);
  // creates blue mouse-position circle
  text ("Servo 1 =", 10, 650);
  text (XANGLE, 170, 650);
  // prints value of angle based on mouse position
  if (XANGLE < 10) {
    xdegreepos = 210;
  }
  if ((XANGLE > 10) && (XANGLE < 100)) {
    xdegreepos = 220;
  }
  if (XANGLE > 100) {
    xdegreepos = 235;
  }
  noFill ();
  stroke (0, 0, 255);
  ellipse (xdegreepos, 615, 10, 10);
  text ("Servo 2 =", 310, 650);
  text (yANGLE, 470, 650);
  if (yANGLE < 10) {
    ydegreepos = 510;
  }
  if ((yANGLE > 10) && (yANGLE < 100)) {
    ydegreepos = 520;
  }
  if (yANGLE > 100) {
    ydegreepos = 535;
  }
  ellipse (ydegreepos, 615, 10, 10);
  // creates degree sign above angle text
  textSize (32);
  if (XANGLE < 10) {
    if (yANGLE < 10) {
      values = ("0" + "0" + XANGLE + "," + "0" + "0" + yANGLE + "$");
    }

    if ((yANGLE > 10) && (yANGLE < 100)) {
      values = ("0" + "0" + XANGLE + "," + "0" + yANGLE + "$");
    }

    if (yANGLE > 100) {
      values = ("0" + "0" + XANGLE + "," + yANGLE + "$");
    }
  }

  if (XANGLE > 10 && XANGLE < 100) {
    if (yANGLE < 10) {
      values = ("0" + XANGLE + "," + "0" + "0" + yANGLE + "$");
    }

    if ((yANGLE > 10) && (yANGLE < 100)) {
      values = ("0" + XANGLE + "," + "0" + yANGLE + "$");
    }

    if (yANGLE > 100) {
      values = ("0" + XANGLE + "," + yANGLE + "$");
    }
  }

  if (XANGLE > 100) {
    if (yANGLE < 10) {
      values = (XANGLE + "," + "0" + "0" + yANGLE + "$");
    }

    if ((yANGLE > 10) && (yANGLE < 100)) {
      values = (XANGLE + "," + "0" + yANGLE + "$");
    }

    if (yANGLE > 100) {
      values = (XANGLE + "," + yANGLE + "$");
    }
  }
  // adds 0s to string when there are no digits in the 100s or 10s place, so that the CircuitPython program will always have a three digit number - and therefore the right place values
  myPort.write(values);
  // sends a string of two three-digit angles separated by a comma or a dollar sign
  println (values);
}
