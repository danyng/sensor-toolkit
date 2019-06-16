/* temperature module referenced from the adafruit si7021 library
   sending temperature level every time interval

   additional: humidity level, but interface implementation pending
*/


#include "OOCSI.h"
#include "Adafruit_Si7021.h"

const char* ssid = "STK LOCAL NAME";
const char* password = "STK LOCAL PASSWORD";

const char* OOCSIName = "module_temperature";
const char* recipient = "stk_demo_visualizer";

const char* hostserver = "INSERT IP HERE";
const char* key = "temperatureVal";

OOCSI oocsi = OOCSI();


#define ledPin D4
int timeInterval = 1000;

Adafruit_Si7021 sensor = Adafruit_Si7021();



void setup() {
  Serial.begin(115200);

  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);    // LOW = on

  oocsi.connect(OOCSIName, hostserver, ssid, password, processOOCSI);


  Serial.println("Si7021 test!");

  if (!sensor.begin()) {
    Serial.println("Did not find Si7021 sensor!");
    while (true)
      ;
  }

  Serial.print("Found model ");
  switch (sensor.getModel()) {
    case SI_Engineering_Samples:
      Serial.print("SI engineering samples"); break;
    case SI_7013:
      Serial.print("Si7013"); break;
    case SI_7020:
      Serial.print("Si7020"); break;
    case SI_7021:
      Serial.print("Si7021"); break;
    case SI_UNKNOWN:
    default:
      Serial.print("Unknown");
  }
  Serial.print(" Rev(");
  Serial.print(sensor.getRevision());
  Serial.print(")");
  Serial.print(" Serial #"); Serial.print(sensor.sernum_a, HEX); Serial.println(sensor.sernum_b, HEX);

}



void loop() {
  //  Serial.print("Humidity:    ");
  //  Serial.print(sensor.readHumidity());
  //  Serial.print("\tTemperature: ");
  //  Serial.println(sensor.readTemperature());

  oocsi.newMessage(recipient);
  oocsi.addFloat(key, sensor.readTemperature());
  oocsi.sendMessage();

  oocsi.check();
  delay(timeInterval);
}



void processOOCSI() {
  // don't do anything; we are sending only
}
