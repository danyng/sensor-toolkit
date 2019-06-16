/* microphone module
   sending the raw noise level every time interval

   currently, the code does NOT summarize the collected data
   the "wemos d1 mini v3" does not operate with the millis() function
   future troubleshooting is required.
*/


#include "OOCSI.h"

const char* ssid = "STK LOCAL NAME";
const char* password = "STK LOCAL PASSWORD";

const char* OOCSIName = "module_microphone2";
const char* recipient = "stk_demo_visualizer";

const char* hostserver = "INSERT IP HERE";
const char* key = "noiseVal";

OOCSI oocsi = OOCSI();


#define ledPin D4


//--- time parameters
unsigned long currentTime = 0;
unsigned long previousTime = 0;
int timeInterval = 500;
int rawTimeInterval = 50;



//--- highpass filter parameters
float EMA_a = 0.5;    //initialization of EMA alpha
int EMA_S = 0;        //initialization of EMA S
int highpass = 0;



//--- summarizing parameters
int sumReadings = 0;
int readIndex = 0;
int average = 0;



void setup() {
  Serial.begin(115200);

  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);
  
  oocsi.connect(OOCSIName, hostserver, ssid, password, processOOCSI);

  EMA_S = analogRead(A0);     //set EMA S for t=1
}



void loop() {
  //  currentTime = millis();

  int sensVal = analogRead(A0);

  highPass(sensVal);

  //  sumReadings += highpass;

  //  if (currentTime - previousTime > timeInterval) {
  //    average = sumReadings / readIndex;

  oocsi.newMessage(recipient);
  oocsi.addInt(key, highpass);   //noise not reduced here!
  oocsi.sendMessage();

  Serial.print("sending value of: ");
  Serial.println(highpass);

  //    wipe variables
  //    sumReadings = 0;
  //    readIndex = 0;

  //    currentTime = millis();
  //    previousTime = currentTime;

  //  } else {
  //    readIndex++;    //for average noise level
  //  }

  oocsi.check();
  delay(rawTimeInterval);

}



void highPass(int sensVal) {
  EMA_S = (EMA_a * sensVal) + ((1 - EMA_a) * EMA_S); //run the EMA
  highpass = int(sensVal - EMA_S);
  highpass = abs(highpass);
}



void averageLevel(int sensVal) {
  sumReadings += sensVal;
}



void processOOCSI() {
  // don't do anything; we are sending only
}
