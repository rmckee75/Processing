import processing.serial.*;
Serial myPort = new Serial(this, Serial.list()[2], 9600);
float angle = 0;
float red = 255;
float green = 0;
float blue = 0;
void setup() 
{
     println("Available serial ports:");
     printArray(Serial.list());
     size (600, 600);
    
}

void draw() {
  print(myPort.available());
    if (myPort.available() > 0) { 
      int myNum = myPort.read();
       background (0, 0, 0);
      angle = map (myNum, 0, 255, 0, 3.9508043048);
      if (angle < 1.9754021524) {
        red = 0;
        green = map (angle, 0, 1.9754021524, 255, 0);;
        blue = map (angle, 0, 1.9754021524, 0, 255);
      }
      if (angle > 1.9754021524) {
        red = map (angle, 1.9754021524, 3.9508043048, 0, 255);
        green = 0;
        blue = map (angle, 1.9754021524, 3.9508043048, 255, 0);
      }
      ellipse(300, 300, 300, 300);
      fill(red, green, blue);
      translate(300, 300);
      rotate (angle);
      stroke(0, 0, 0);
      line(0, 0, -141.421356237, 50);
      println(angle);
    }
    }
