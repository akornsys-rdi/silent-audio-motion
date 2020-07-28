#define STBY        8
#define APWM        3
#define AIN1        6
#define AIN2        5
#define BPWM        11
#define BIN1        9
#define BIN2        10
#define FW_L        A0
#define TRG_L       A1
#define ADJ_L       A2
#define FW_R        A3
#define TRG_R       A4
#define ADJ_R       A5
#define DEBUG       2

void setup() {
    analogReference(EXTERNAL);
    pinMode(DEBUG, OUTPUT);
    pinMode(TRG_L, INPUT);
    pinMode(TRG_R, INPUT);
    ADCSRA = ADCSRA & B11111000 | B00000100;
    Serial.begin(115200);
}

void loop() {
    Serial.print(analogRead(FW_L));
    Serial.print(" ");
    Serial.print(analogRead(ADJ_L));
    Serial.print(" ");
    if (digitalRead(TRG_L)) Serial.print(1023);
    else Serial.print(0);
    Serial.print(" ");
    Serial.print(analogRead(FW_R));
    Serial.print(" ");
    Serial.print(analogRead(ADJ_R));
    Serial.print(" ");
    if (digitalRead(TRG_R)) Serial.println(1023);
    else Serial.println(0);
    digitalWrite(DEBUG, !digitalRead(DEBUG));
    delay(5);
}
