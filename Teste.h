#define DELAY     1000

#define ON        0x01
#define OFF       0x00
#define NUM_LEDS  0x03

#define RED_LED   0X400000
#define BLUE_LED  0X200000
#define GREEN_LED 0X080000

void setupGPIO();
int setLED(int color, int state); //int because error
void delay(int milliseconds);
