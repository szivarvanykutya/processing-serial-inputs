import processing.serial.*;
import processing.sound.*;

SinOsc sine1, sine2;
Serial myPort;
String sval="0";
int lf =10;
float data, frq ;
float[] samples = new float[20];


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
  delay(500);
  sine1 = new SinOsc(this);
  sine2 = new SinOsc(this);
  sine1.play();
  //sine2.play();
  GetSerialData();
  for (int i = 0; i < samples.length; i++) {
    samples[i] = map(float(sval), 20, 200, 100, 1000);
  }
}

void draw() {
  background(0);
  GetSerialData();
  // ---------- sliding average -------------------
  for (int i = 0; i < samples.length-1; i++) {
    samples[i] = samples[i+1];
  }
  samples[samples.length-1] = map(float(sval), 20, 200, 100, 1000);
  data = samples[0];
  for (int i = 1; i < samples.length-1; i++) {
    data = samples[i] + data;
  }
  /*------------cleaning data -------------------
   float avg=data/samples.length;
   for (int i = 0; i < samples.length; i++) {
   if(samples[i] > avg+avg*0.5) {
   samples[i] = avg;
   }
   if(samples[i] < avg-avg*0.5) {
   samples[i] = avg;
   }
   }
   data = samples[0];
   for (int i = 1; i < samples.length-1; i++) {
   data = samples[i] + data;
   }
   //-------------------------- optional cleaning----------*/

  frq=data/samples.length;

  //frq=map(float(sval), 20, 200, 100, 1000);


  text("sine 1 freq: " + frq, 10, 50);
  sine1.freq(frq);
  sine2.freq(300);
  sine2.amp(map(mouseY, 0, 600, 0, 1));
  sine1.amp(map(mouseX, 0, 600, 0, 1));
  text("sine 1 freq: " + frq, 10, 50);
  text("sine 1 amp: " + map(mouseX, 0, 600, 0, 1), 10, 60);
  text("sine 2 amp: " + map(mouseY, 0, 600, 0, 1), 10, 70);
}


String GetSerialData() {
  while (myPort.available() > 0) {
    sval = myPort.readStringUntil(lf);
  }
  return sval;
}
