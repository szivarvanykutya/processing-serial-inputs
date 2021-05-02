import processing.serial.*;
import processing.sound.*;

SinOsc sine;
Serial myPort;
String sval="0";
int lf =10;



void setup()
{
  size(600, 600);
  background(0);
  stroke(255);
  frameRate(30);
  println(Serial.list());
  String portName = Serial.list()[0]; // according to arduino connected serial device in the list
  myPort = new Serial(this, portName, 9600);
  myPort.clear();
  
  sine = new SinOsc(this);
  sine.play();
}

void draw() {
  background(0);
  GetSerialData();
  text("Received: " + sval, 10, 50);
  sine.freq(float(sval)*2);
}

String GetSerialData() {
  while (myPort.available() > 0) {
    sval = myPort.readStringUntil(lf);
  }
  return sval;
}
