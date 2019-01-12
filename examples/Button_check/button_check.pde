/*-----------------------------------------------------------
Please, note: Wemos D1 R1 board was used for testing. 
10K resistor was permanently used between A0 and VCC.
Buttons were connecting the 470R, 1K, 5K and 10K 
resistors from A0 to ground.
-------------------------------------------------------------*/
#define BWU     150 //Button with 150 adcValue 1K
#define BWD     69  //Button with 69 adcValue  470R
#define BDU     489 //Button with 489 adcValue 5K
#define BDD     733 //Button with 733 adcValue 10K
#define OFFSET  5   //Offset for ADC Value inaccuracy (for example, for 1K resistor 145-155 values are considered to be correct (150+-5))
#define SW_TIME 90  //90 milliseconds for contacts action (the time to wait for button contacts to be closed for sure)
#define BTN_CHK 20  //The time for checking if the button was pressed

#include <Button.h>

unsigned long c;

Button bwd(BWD, OFFSET, SW_TIME), bwu(BWU, OFFSET, SW_TIME), bdd(BDD, OFFSET, SW_TIME), bdu(BDU, OFFSET, SW_TIME);

void setup() {
  Serial.begin(9600);
  c = millis();
}

void loop() { 
  if (millis() - c > BTN_CHK) {
	int value analogRead(A0);
    bwd.check(value);
    bwu.check(value);
    bdd.check(value);
    bdu.check(value);
    c = millis();
  }  
  if(bwd.isActive()) {Serial.println("BWD"); bwd.release();} //use release function to "release the button" (isActive() will return false) after you did the button action
  if(bwu.isActive()) {Serial.println("BWU"); bwu.release();} //Please, note, isActive() will return false automatically after the button will be physically released
  if(bdd.isActive()) {Serial.println("BDD"); bdd.release();}
  if(bdu.isActive()) {Serial.println("BDU"); bdu.release();}   
}