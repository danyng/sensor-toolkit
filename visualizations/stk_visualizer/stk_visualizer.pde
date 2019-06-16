import nl.tue.id.oocsi.*;

boolean buttonState = false;
boolean buttonState2 = false;
int sliderVal = 0;
int noiseVal = 0;
int brightnessVal = 0;
float temperatureVal = 0;
float angleVal = 0;

int calibrationNum = 0;
boolean calibrated = false;

PImage doorOpen;
PImage doorOpen2;
PImage doorClosed;

PImage calibrateOpen;
PImage calibrateClosed;
PImage calibrateStart;


PImage sun;
PImage sunCore;

PImage temperature;
PImage waves;


void setup() {

  OOCSI oocsi = new OOCSI(this, "stk_demo_visualizer", "IP HERE");

  fullScreen(2);
  //size(1920, 1080);
  noCursor();
  rectMode(CENTER);

  doorOpen = loadImage("doorOpen.png");
  doorOpen2 = loadImage("doorOpen2.png");
  doorClosed = loadImage("doorClosed.png");

  calibrateOpen = loadImage("calibrateOpen.png");
  calibrateClosed = loadImage("calibrateClosed.png");
  calibrateStart = loadImage("calibrateStart.png");


  sun = loadImage("sun.png");
  sunCore = loadImage("sunCore.png");

  temperature = loadImage("temperature.png");
  waves = loadImage("waves.png");

  imageMode(CENTER);
}





void draw() {

  background(245);

  drawButton(1);
  drawSlider(2);
  drawSound(3);
  drawBrightness(4);
  drawTemperature(5);
  drawDoor(6);

  drawCalibration(calibrationNum);
}





void drawButton(int numberModule) {
  // position coordinates
  int total = 6;
  float xPos = float(numberModule) / (total + 1);  

  // button init values
  int buttonSize = 30;
  float buttonHeight = 0.51;

  color fillColor = color(80);
  String buttonValue = "OFF";


  // conditions
  if (buttonState == true) {
    fillColor = color(255, 180, 70);
    buttonValue = "ON";
    buttonSize = 10;
    buttonHeight = 0.505;
  } else {
    fillColor = color(80);
    buttonValue = "OFF";
    buttonSize = 25;
    buttonHeight = 0.501;
  }

  // draw background rectangle with dropshadow
  noStroke();
  fill(50, 30); 
  rect(width * xPos + 8, height * 0.5 + 8, 220, 300, 20);  
  fill(fillColor);
  rect(width * xPos, height * 0.5, 220, 300, 20);

  // draw red button
  fill(255, 80, 70);
  rect(xPos * width, buttonHeight * height, 60, buttonSize);

  // draw the button baseline
  strokeWeight(8);
  stroke(255);  
  line(xPos * width - 40, 0.51 * height, xPos * width + 40, 0.51 * height);

  // precise sensor value
  textSize(50);
  fill(255);
  if (buttonValue == "OFF") {
    text(buttonValue, xPos * width, (0.57 + 0.05) * height);     //for off
  } else {
    text(buttonValue, (xPos + 0.01) * width, (0.57 + 0.05) * height);     //for on
  }
}






void drawSlider(int numberModule) {
  // position coordinates
  int total = 6;
  float xPos = float(numberModule) / (total + 1);  

  // slider init values
  color fillColor = color(80);
  float sliderHeight = 0;

  // conditions
  //sliderHeight = map(mouseX, 0, width, 40, 300);
  sliderHeight = map(sliderVal, 8, 1024, 0, 300);


  // draw background rectangle with dropshadow
  noStroke();
  fill(50, 30); 
  rect(width * xPos + 8, height * 0.5 + 8, 220, 300, 20);  
  fill(fillColor);
  rect(width * xPos, height * 0.5, 220, 300, 20);


  // draw slider border
  strokeWeight(15);
  stroke(fillColor);
  fill(255);
  rect(width * xPos, height * 0.5, 220 - 15, 300 - 15, 20);

  // draw slider fill height
  noStroke();
  rectMode(CORNERS);
  fill(fillColor);
  rect(width * xPos - 110, height * 0.5 + 150 - sliderHeight, width * xPos + 110, height * 0.5 + 150, 20);
  rectMode(CENTER);


  // precise sensor value with dropshadow and re-alignment
  textSize(50);
  int drawVal = int(map(sliderVal, 8, 1024, 0, 100));


  float offsetX = 0.013;
  float offsetY = 0.045;


  if (drawVal != 100 && drawVal != 0 && drawVal >= 10) {
    fill(0, 30);
    text(drawVal, width * ( xPos + 0.004 + offsetX), height * (0.5 + 0.073 + 0.003 + offsetY)  );
    fill(255);
    text(drawVal, width * (xPos + offsetX), height * (0.5 + 0.073 + offsetY) );
  } else if (drawVal == 100) {
    fill(0, 30);
    text(drawVal, width * ( xPos + 0.004 + offsetX - 0.015), height * (0.5 + 0.073 + 0.003 + offsetY)  );
    fill(255);
    text(drawVal, width * (xPos + offsetX - 0.015), height * (0.5 + 0.073 + offsetY) );
  } else {
    fill(0, 30);
    text(drawVal, width * ( xPos + 0.004 + offsetX + 0.015), height * (0.5 + 0.073 + 0.003 + offsetY)  );
    fill(255);
    text(drawVal, width * (xPos + offsetX + 0.015), height * (0.5 + 0.073 + offsetY) );
  }
}






void drawSound(int numberModule) {
  // position coordinates
  int total = 6;
  float xPos = float(numberModule) / (total + 1);

  // sound init values
  color fillColor = color(80);
  //float multiplier = map(mouseX, 0, width, 0, 3);
  float multiplier = map(noiseVal, 0, 150, 0, 3);
  float randNumbX = random(-3, 3);
  float randNumbY = random(-3, 3);

  // conditions
  if (multiplier > 2) {
    fillColor = color(255, 80, 70);
  } else if (multiplier > 1) {
    fillColor = color(255, 180, 70);
  } else {
    fillColor = color(80);
  }

  // draw background rectangle with dropshadow
  noStroke();
  fill(50, 30); 
  rect(width * xPos + 8, height * 0.5 + 8, 220, 300, 20);  
  fill(fillColor);
  rect(width * xPos, height * 0.5, 220, 300, 20);


  // draw rectangle
  fill(255);
  rect(width * xPos + randNumbX*multiplier, height * 0.5 + randNumbY*multiplier, 50, 50, 5);
}





void drawBrightness(int numberModule) {
  // position coordinates
  int total = 6;
  float xPos = float(numberModule) / (total + 1);

  // sound init values
  color fillColor = color(255, 230, 130);
  //int intensity = int(map(mouseX, 0, width, 0, 255));
  float intensity = map(brightnessVal, 0, 800, 255, 0);

  // draw background rectangle with dropshadow
  noStroke();
  fill(50, 30); 
  rect(width * xPos + 8, height * 0.5 + 8, 220, 300, 20);  
  fill(fillColor);
  rect(width * xPos, height * 0.5, 220, 300, 20);

  image(sun, width * xPos, height * 0.5);

  // shade overlay to represent the shadow
  fill(50, intensity);
  rect(width * xPos, height * 0.5, 220, 300, 20);

  image(sunCore, width * xPos, height * 0.5);



  // precise sensor value with dropshadow and re-alignment
  textSize(50);
  int drawVal = int(map(brightnessVal, 0, 1024, 0, 100));

  float offsetX = 0.013;
  float offsetY = 0.045;

  if (drawVal != 100 && drawVal != 0 && drawVal >= 10) {
    fill(0, 30);
    text(drawVal, width * ( xPos + 0.002 + offsetX), height * (0.5 + 0.073 + 0.003 + offsetY)  );
    fill(255);
    text(drawVal, width * (xPos + offsetX), height * (0.5 + 0.073 + offsetY) );
  } else if (drawVal == 100) {
    fill(0, 30);
    text(drawVal, width * ( xPos + 0.002 + offsetX - 0.015), height * (0.5 + 0.073 + 0.003 + offsetY)  );
    fill(255);
    text(drawVal, width * (xPos + offsetX - 0.015), height * (0.5 + 0.073 + offsetY) );
  } else {
    fill(0, 30);
    text(drawVal, width * ( xPos + 0.002 + offsetX + 0.015), height * (0.5 + 0.073 + 0.003 + offsetY)  );
    fill(255);
    text(drawVal, width * (xPos + offsetX + 0.015), height * (0.5 + 0.073 + offsetY) );
  }
}




void drawTemperature(int numberModule) {
  // position coordinates
  int total = 6;
  float xPos = float(numberModule) / (total + 1);

  // sound init values
  color fillColor = color(80);
  //int intensityR = int(map(mouseX, 0, width, 10, 255));
  //int intensityG = int(map(mouseX, 0, width, 120, 85));
  //int intensityB = int(map(mouseX, 0, width, 160, 10));

  //int intensityR = int(map(temperatureVal, 20, 45, 10, 255));
  //int intensityG = int(map(temperatureVal, 20, 45, 120, 85));
  //int intensityB = int(map(temperatureVal, 20, 45, 160, 10));

  int intensityO = int(map(temperatureVal, 10, 36, 255, 0));

  // draw background rectangle with dropshadow
  noStroke();
  fill(50, 30); 
  rect(width * xPos + 8, height * 0.5 + 8, 220, 300, 20);  
  fill(255, 85, 10); 
  rect(width * xPos, height * 0.5, 220, 300, 20);

  // opacity overlay
  fill(0, intensityO); 
  rect(width * xPos, height * 0.5, 220, 300, 20);

  println(intensityO);

  image(waves, width * xPos, height * (0.5 - 0.03));
  image(temperature, width * xPos, height * 0.5);

  // precise sensor value with dropshadow and re-alignment
  textSize(50);
  //float drawVal = temperatureVal;
  float drawVal = temperatureVal;


  float offsetX = 0.013;
  float offsetY = 0.045;

  if (drawVal != 100 && drawVal != 0 && drawVal >= 10) {    // when 2 digits
    fill(0, 30);
    text(nf(drawVal, 0, 1), width * ( xPos + 0.002 + offsetX - 0.020), height * (0.5 + 0.073 + 0.003 + offsetY)  );
    fill(255);
    text(nf(drawVal, 0, 1), width * (xPos + offsetX - 0.020), height * (0.5 + 0.073 + offsetY) );
  } else if (drawVal == 100) {                              // when 3 digits
    fill(0, 30);
    text(nf(drawVal, 0, 1), width * ( xPos + 0.002 + offsetX - 0.015 * 2.3), height * (0.5 + 0.073 + 0.003 + offsetY)  );
    fill(255);
    text(nf(drawVal, 0, 1), width * (xPos + offsetX - 0.015 * 2.3), height * (0.5 + 0.073 + offsetY) );
  } else {                                                  // when 1 digit
    fill(0, 30);
    text(nf(drawVal, 0, 1), width * ( xPos + 0.002 + offsetX), height * (0.5 + 0.073 + 0.003 + offsetY)  );
    fill(255);
    text(nf(drawVal, 0, 1), width * (xPos + offsetX), height * (0.5 + 0.073 + offsetY) );
  }
}






void drawDoor(int numberModule) {
  // position coordinates
  int total = 6;
  float xPos = float(numberModule) / (total + 1);

  // sound init values
  color fillColor = color(80);
  int value = int(map(mouseX, 0, width, 0, 100));

  // draw dropshadow
  noStroke();
  fill(50, 30); 
  rect(width * xPos + 8, height * 0.5 + 8, 220, 300, 20);  

  if (calibrationNum == 0) {

    if (buttonState2 == true) {
      if (calibrated == true) {
        image(doorOpen2, width * xPos, height * 0.5);
      } else {
        image(doorOpen, width * xPos, height * 0.5);
      }

      //// precise sensor value
      //textSize(50);
      //fill(255);
      //text(value, width * (xPos - 0.045), height * (0.5 - 0.08) );     //oocsi
    } else {
      image(doorClosed, width * xPos, height * 0.5);

      //// precise sensor value
      //textSize(50);
      //fill(255, 100);
      //text(0, width * (xPos - 0.045), height * (0.5 - 0.08) );     //oocsi
    }
  } else {
    noStroke();
    fill(50, 30); 
    rect(width * xPos + 8, height * 0.5 + 8, 220, 300, 20);  
    fill(fillColor);
    rect(width * xPos, height * 0.5, 220, 300, 20);

    // calibration text
    textSize(18);
    fill(255);
    text("calibrating..", width * (xPos), height * (0.5 + 0.125) );     //oocsi
  }

  if (calibrated == true) {
    textSize(18);
    fill(255);
    text("*", width * (xPos - 0.05), height * (0.5 - 0.115) );     //oocsi
  }
}





void drawCalibration(int num) {

  if (num == 0) {
    // draw nothing
  } else if (num == 1) {
    fill(0, 100);
    rect(width/2, height/2, 1920, 1080);
    image(calibrateStart, width * 0.5, height * 0.5);
  } else if (num == 2) {
    fill(0, 100);
    rect(width/2, height/2, 1920, 1080);
    image(calibrateOpen, width * 0.5, height * 0.5);
  } else if (num == 3) {
    fill(0, 100);
    rect(width/2, height/2, 1920, 1080);
    image(calibrateClosed, width * 0.5, height * 0.5);
  }
}




void keyReleased() {

  if (key == 't') {
    buttonState = !buttonState;
  }

  if (key == 'c') {
    if (calibrationNum < 3) {
      calibrationNum++;
    } else {
      calibrationNum = 0;
      calibrated = !calibrated;
    }

    println("calibrationNum is: " + calibrationNum);
  }
}

void mouseReleased() {
  println("X: " + float(mouseX) / width + "Y :" + float(mouseY) / height);
}



void handleOOCSIEvent(OOCSIEvent event) {

  if (event.has("buttonState")) {
    buttonState = event.getBoolean("buttonState", false);
    println("buttonState is: " + buttonState);
  }

  if (event.has("sliderVal")) {
    sliderVal = event.getInt("sliderVal", -200);
    println("sliderval is: " + sliderVal);
  }

  if (event.has("noiseVal")) {
    noiseVal = event.getInt("noiseVal", -200);
    println("noise is: " + noiseVal);
  }

  if (event.has("brightnessVal")) {
    brightnessVal = event.getInt("brightnessVal", -200);
    println("brightness is: " + brightnessVal);
  }

  if (event.has("temperatureVal")) {
    temperatureVal = event.getFloat("temperatureVal", -200);
    println("temperature is: " + temperatureVal);
  }

  if (event.has("angleVal")) {
    angleVal = event.getFloat("angleVal", -200);
    println("angle is: " + angleVal);
  }

  if (event.has("buttonState2")) {
    buttonState2 = event.getBoolean("buttonState2", false);
    println("buttonState is: " + buttonState2);
  }
}
