import processing.serial.*;
import processing.sound.*;

SinOsc sine1, sine2;
Serial myPort;
String sval="0";
int lf =10;
float frq;


void setup()
{
  size(600, 600);
  background(0);
  stroke(255);
  frameRate(60);
  println(Serial.list());
  String portName = Serial.list()[0]; 
  myPort = new Serial(this, portName, 9600);
  myPort.clear();
  
  sine1 = new SinOsc(this);
  sine2 = new SinOsc(this);
  sine1.play();
  sine2.play();
}

void draw() {
  background(0);
  GetSerialData();
  
 
  frq=map(float(sval),20,200,100,2000);
  text("sine 1 freq: " + frq, 10, 50);
  sine1.freq(frq);
  sine2.freq(300);
  sine2.amp(map(mouseY,0,600,0,1));
  sine1.amp(map(mouseX,0,600,0,1));
  text("sine 1 freq: " + frq, 10, 50);
  text("sine 1 amp: " + map(mouseX,0,600,0,1), 10, 60);
  text("sine 2 amp: " + map(mouseY,0,600,0,1), 10, 70);
}


String GetSerialData() {
  while (myPort.available() > 0) {
    sval = myPort.readStringUntil(lf);
  }
  return sval;
}
