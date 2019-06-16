/* streaming csv content at the speed of time interval.
   mouseX position will change the speed of play back.
   additional: prints total play time based on the speed and size.
 */

Table table;

//usertest feeling easing on different speed
float currentSize = 0.0;
float easing = 0.10;

int i = 0;
int j = 0;

int currentTime = 0;
int previousTime = 0;
int timeInterval = 300;

int size1;
int size2;
int size3;


PImage backgroundData;


void setup() {
  frameRate(50);

  noCursor();
  fullScreen();
  smooth();
  noStroke();

  table = loadTable("UI_full.csv", "header");
  backgroundData = loadImage("backgroundData.PNG");
}



void draw() {
  currentTime = millis();
  background(50);    //change this to inactivity layer
  image(backgroundData, 0, 0);

  //speed streaming
  dynamicInterval();

  //read csv
  readCSV();


  //draw data
  visualize(easing(size1), 5, 1);
  visualize(easing(size2), 5, 2);
  visualize(easing(size3), 5, 3);


  //when time interval has passed
  if (currentTime - previousTime > timeInterval && i < table.getRowCount() - 1) {

    i++;    //append
    previousTime = currentTime;  //wipe

    //print stats
    println("index: " + i + " - jndex" + j + " - values: "+  size1 + " - timeInterval: " + timeInterval);

    //putting visualization here neglects easing
  } else if (i >= table.getRowCount()) {
    //replay data sheet
    i = 0;
  }

  speedbar();
}


void visualize(float value, int multiply, int pos) {
  //visualizing data value
  rectMode(CENTER);
  fill(255);
  rect(width * (0.25 * pos), height/2, value * multiply, value * multiply, value / 2);
}


void stats() {
  //visualize stats
  fill(255);
  text(timeInterval, width * 0.8, height * 0.9);
}

void calculateTotal() {
  //here we calculate total playtime based on the data size and speed
  int totalTime = (table.getRowCount() * timeInterval)/1000;
  println("total data stream time: " + totalTime + "seconds");
}

void calculateCurrent() {
  //here we calculate total playtime based on the data size and speed
  int leftTime = ((table.getRowCount() - i)* timeInterval)/1000;
  println("streaming time left: " + leftTime + "seconds");
}

void dynamicInterval() {
  //change time interval by moving mouse on x-axis
  timeInterval = int( map(mouseX, 0, width, 20, 300) );
}




void readCSV() {
  TableRow row = table.getRow(i - j);

  //checks whether there is an empty point
  if (row.getInt(0) == 0 && (i - j) != 0) {
    j++;
  } else {
    j = 0;
    size1 = row.getInt(0);
  }

  TableRow row2 = table.getRow(i - j);

  //checks whether there is an empty point
  if (row2.getInt(1) == 0 && (i - j) != 0) {
    j++;
  } else {
    j = 0;
    size2 = row2.getInt(1);
  }

  TableRow row3 = table.getRow(i - j);

  //checks whether there is an empty point
  if (row3.getInt(2) == 0 && (i - j) != 0) {
    j++;
  } else {
    j = 0;
    size3 = row3.getInt(2);
  }
}

void keyPressed() {

  if (key == 't') {
    calculateTotal();
  } else if (key == 'c') {  
    calculateCurrent();
  } else if (key == '1') {
    i += 10;
  } else if (key == '2') {
    i -= 10;
  } else if (key == '3') {
    i += 500;
  } else if (key == '4') {
    i -= 500;
  }
}


void speedbar() {
  rectMode(CORNER);
  fill(255, 215, 30);
  rect(0, height * 0.97, width, height);

  fill(255, 80, 30);
  rect(mouseX - 1, height * 0.97, 2, height);
  fill(255, 80, 30, 50);
  rect(mouseX - 1, 0, 2, height);

  fill(255);
  textSize(80);
  textAlign(CENTER, BOTTOM);
  text("Speed " + int(1000/timeInterval) + "X", width * 0.85, 0.16 * height);
}

float easing(int sensVal) {
  //animation easing

  //will be made dynamic if needed
  //easing = map(timeInterval, 50, 2000,  

  //50ms = 

  //to ease the new value
  float targetVal = float(sensVal);
  float dx1 = targetVal - currentSize;
  currentSize += dx1 * easing;

  return currentSize;
}


float easingRandom(int sensVal) {
  //animation easing

  //will be made dynamic if needed
  //easing = map(timeInterval, 50, 2000,  

  //50ms = 

  //to ease the new value
  float targetVal = float(sensVal);
  float dx1 = targetVal - currentSize;
  currentSize += dx1 * easing;

  return currentSize;
}
