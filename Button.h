/*
  Button.h - Library for checking the buttons, connected to Analog pin of Arduino
*/

// ensure this library description is only included once
#ifndef Button_h
#define Button_h

#include <Arduino.h>

class Button {
    bool isAct, preAct, pause, pause_r;
    int  adcValue, offset, sw_time;
    unsigned long c_time;
  public:
    Button(int val, int ofs, int sw_t);
    void check(int value);
    bool isActive(void);
    void release(void);
};

#endif