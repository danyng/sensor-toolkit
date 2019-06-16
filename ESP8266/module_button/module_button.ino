/* button module 
 * sending a boolean when pressed on button
 * 
 */


#include "OOCSI.h"

const char* ssid = "STK LOCAL NAME"; 
const char* password = "STK LOCAL PASSWORD";

const char* OOCSIName = "module_button2";
const char* recipient = "stk_demo_visualizer";

const char* hostserver = "INSERT IP HERE";
const char* key = "buttonState";

OOCSI oocsi = OOCSI();


#define ledPin D4
#define buttonPin D3

boolean prevState = false;
boolean currState = false;



void setup() {
  Serial.begin(115200);

  pinMode(buttonPin, INPUT_PULLUP);
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);

  oocsi.connect(OOCSIName, hostserver, ssid, password, processOOCSI);
}



void loop() {

  Serial.println(digitalRead(buttonPin));

  // check whether button is pressed
  if (digitalRead(buttonPin) == 0) {
    currState = !currState;
    delay(200); //debounce
  }

  // do one thing when conditions are not the same anymore
  if (currState != prevState && currState == true) {
    Serial.println("lights are on");
    oocsiSend(true);
    prevState = currState;
  } else if (currState != prevState && currState == false) {
    Serial.println("lights are off");
    oocsiSend(false);
    prevState = currState;
  }

  oocsi.check();
  delay(50);
}



void processOOCSI() {
  // don't do anything; we are sending only
}



void oocsiSend(boolean state) {

  oocsi.newMessage(recipient);
  oocsi.addBool(key, state);
  oocsi.sendMessage();

}
