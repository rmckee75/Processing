int a = 150;
int b = 150;
// declares the circle's starting position (middle of the screen)
int c = 1;
int d = 5;
// the object changes vertically 5 times as fast, which makes it bounce around
void setup ()
{
  size (300, 300);
  // makes the screen 300 x 300
  background (255, 0, 0);
  // colors it red
}
void draw ()
// equivalent of void loop () in arduino
{
  background (255, 0 , 0);
  // redraw the background each time, to prevent the circle from leaving a line
  ellipse (a, b, 150, 150);
  // make a 150 x 150 circle
  fill (0, 255, 0);
  // color it green
  if (a >= 225 || a <= 75)
  // when the edge of the circle reaches the edge of the screen...
    {
      c = -c;
      // ... switch directions
    }
   if (b >= 225 || b <= 75)
   {
     d = -d;
   }
   a = a + c;
   b = b + d;
   // increase (or decrease) a and b by the designated amounts
   println ("Hello world.");
}
