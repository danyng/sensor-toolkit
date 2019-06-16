// logger stats for monitoring incoming data and additional "meta" data


import nl.tue.id.oocsi.*;
import java.util.*;

OOCSI oocsi;


long index = 0;
int amountSensors = 3;

String[] keys = {"size1", "size2", "size3"};
int[] values = {-200, -200, -200};
Date[] lastTimes = new Date[3];

// last event parameters
Date lastEventTime = new Date();
String lastKey;
int lastValue;


boolean constantLog = false;
boolean requestLog = false;
boolean resetMarker = true;  //activate at start



void setup() {  
  size(800, 400);
  background(0);
  oocsi = new OOCSI(this, "logger_stats_" + int(random(18273)), "oocsi.id.tue.nl");
  oocsi.subscribe("main_entrance_UI_channel");
  println();

  println("press 's' to (de)activate log streamer");
  println("press 't' for the last event time");
  println("press 'l' for last event info");
  println("press 'h' for hotkeys");
  println("press 'r' for resetting the marker and begin time");
}


void draw() {
}


void main_entrance_UI_channel(OOCSIEvent event) {
  for (String key : keys) {

    if (event.has(key)) {

      //storing key values
      for (int i = 0; i < values.length; i++) {
        if (key == keys[i]) {
          values[i] = event.getInt(key, -200);
          lastTimes[i] = event.getTimestamp();
        }
      }


      //last key info
      lastKey = key;
      lastValue = event.getInt(key, -200);
      lastEventTime = event.getTimestamp();

      index++;


      //log streaming
      if (constantLog == true) {
        println("sender: " + event.getSender() + " - key: " + key + " - value: " + event.getInt(key, 0) + " - timestamp: " + event.getTimestamp() + " - data ID: " + index);
      }

      //last message
      if (requestLog == true) {
        println("sender: " + event.getSender() + " - key: " + key + " - value: " + event.getInt(key, 0) + " - timestamp: " + event.getTimestamp() + " - data ID: " + index);
        requestLog = false;
      }

      //time marker for first logged time
      if (resetMarker == true) {
        lastEventTime = event.getTimestamp();
        index = 0;
        println("marker and index has been reset!");
        resetMarker = false;
      }
    }
  }
}


void checkLogToggles() {
  if (constantLog == false) {
    println("log streaming has been stopped. Press 's' to continue");
  } else {
    println("log streaming continues");
  }
}

void keyPressed() {
  //log stream on/off
  if (key == 's') {
    constantLog = !constantLog;
    checkLogToggles();
  } 

  //started from
  else if (key == 't') {
    println("total index since start: " + index + " - Last event on: " + lastEventTime);
  } 

  //request last event
  else if (key == 'l') {
    requestLog = true;
    println("last event: ");
  } 

  //request last event each sensor
  else if (key == '1') {
    println("last event of hub1: " + values[0] + " " + lastTimes[0]);
  } else if (key == '2') {
    println("last event of hub2: " + values[1] + " " + lastTimes[1]);
  } else if (key == '3') {
    println("last event of hub3: " + values[2] + " " + lastTimes[2]);
  } 

  //show hotkeys
  else if (key == 'h') {
    println("press 's' to (de)activate log streamer");
    println("press 't' for the last event time");
    println("press 'l' for last event info");
    println("press 'h' for hotkeys");
    println("press 'r' for resetting the marker and begin time");
  } 

  //reset. Use this for counting throughout the day
  else if (key == 'r') {
    //reset index number
    resetMarker = true;
  }
}
