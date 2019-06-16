/* brightness module 
 * sending brightness level every time interval
*/


#include "OOCSI.h"

const char* ssid = "STK LOCAL NAME"; 
const char* password = "STK LOCAL PASSWORD";

const char* OOCSIName = "module_brightness";
const char* recipient = "stk_demo_visualizer";

const char* hostserver = "INSERT IP HERE";
const char* key = "brightnessVal";

OOCSI oocsi = OOCSI();


#define ledPin D4
int timeInterval = 1000;


void setup() {
  Serial.begin(115200);

  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);    // LOW = on
  
  oocsi.connect(OOCSIName, hostserver, ssid, password, processOOCSI);
}



void loop() {

  oocsi.newMessage(recipient);
  oocsi.addInt(key, analogRead(A0));
  oocsi.sendMessage();

  oocsi.check();
  delay(timeInterval);
}



void processOOCSI() {
  // don't do anything; we are sending only
}
