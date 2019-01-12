/*
  Button.h - Library for checking the buttons, connected to Analog pin of Arduino
*/

#include "Button.h"

Button::Button(int val, int ofs, int sw_t){
  adcValue = val;
  offset   = ofs;
  sw_time  = sw_t;
  isAct    = false;
  preAct   = false;
  pause    = false;
}

void Button::check(int value) {

  //int value = analogRead(A0);
  //Serial.println(value);
  
  if((value>adcValue-offset)&&(value<adcValue+offset)&&(!preAct)&&(!pause)) { // Button was pushed first time
    preAct = true;
    c_time = millis();
  }
  if((value>adcValue-offset)&&(value<adcValue+offset)&&(preAct)&&(millis()-c_time>sw_time)) { // Waiting for contacts to become stable
    isAct  = true;
    preAct = false;
    pause  = true;
  }
  if(((value<adcValue-offset)||(value>adcValue+offset))&&(pause)&&(!pause_r)) { // Button was released
    pause_r = true;
    c_time  = millis();
  }
  if(((value<adcValue-offset)||(value>adcValue+offset))&&(pause_r)&&(millis()-c_time>sw_time)) { //Still released? then consider it's released
    pause   = false;
    pause_r = false;
    isAct   = false;
  }
}

bool Button::isActive(void) {
  return isAct; 
}

void Button::release(void) {
  isAct = false;
}
