#define STBY                    8
#define APWM                    3
#define AIN1                    6
#define AIN2                    5
#define BPWM                    11
#define BIN1                    9
#define BIN2                    10
#define FW_L                    A0
#define TRG_L                   A1
#define ADJ_L                   A2
#define FW_R                    A3
#define TRG_R                   A4
#define ADJ_R                   A5
#define DEBUG                   2

#define BUFFER_SIZE             32  // Tamaño de buffer de datos del flujo analógico de entrada
#define STANDBY_THRESHOLD       10  // Por debajo de este nivel permanece apagado, muestra nivel de entrada bajo
#define SATURATION_THRESHOLD    900 // Por encima de este nivel muestra saturación de entrada

void setup() {
    analogReference(EXTERNAL);
    pinMode(STBY, OUTPUT);
    pinMode(APWM, OUTPUT);
    pinMode(AIN1, OUTPUT);
    pinMode(AIN2, OUTPUT);
    pinMode(BPWM, OUTPUT);
    pinMode(BIN1, OUTPUT);
    pinMode(BIN2, OUTPUT);
    pinMode(DEBUG, OUTPUT);
    pinMode(TRG_L, INPUT);
    pinMode(TRG_R, INPUT);
    TCCR2B = TCCR2B & B11111000 | B00000001;    // set timer 2 divisor to 1 for PWM frequency of 31372.55 Hz
    ADCSRA = ADCSRA & B11111000 | B00000100;    // set ADC capture time divider to 16, 20µs for each capture
    Serial.begin(115200);
}

void loop() {
    static boolean input_standby_l = false;
    static boolean input_standby_r = false;
    static boolean input_saturation_l = false;
    static boolean input_saturation_r = false;
    static boolean output_clipping_l = false;
    static boolean output_clipping_r = false;
    static unsigned int channel_buffer_l[BUFFER_SIZE];
    static unsigned int channel_buffer_r[BUFFER_SIZE];
    static unsigned int peak_value_l = 0;
    static unsigned int peak_value_r = 0;
    static unsigned int adjust_l = 0;
    static unsigned int adjust_r = 0;

    read_channel(channel_buffer_l, channel_buffer_r);
    read_adjust(&adjust_l, &adjust_r); //each 250ms
    search_peak_value(&peak_value_l, channel_buffer_l, &peak_value_r, channel_buffer_r);
    process_channel(input_standby_l && input_standby_r, channel_buffer_l, adjust_l, channel_buffer_r, adjust_r);
    set_status(&input_standby_l, &input_saturation_l, &output_clipping_l, peak_value_l, adjust_l, &input_standby_r, &input_saturation_r, &output_clipping_r, peak_value_r, adjust_r); //each 500ms
    display_status(input_standby_l && input_standby_r, input_saturation_l || input_saturation_r, output_clipping_l || output_clipping_r);
}

// Lee las entradas analógicas de ambos canales y los almacena en la primera posición de un array
// Requiere:
//  value_l: array para el canal L, de tamaño BUFFER_SIZE
//  value_r: array para el canal R, de tamaño BUFFER_SIZE
void read_channel(unsigned int *value_l, unsigned int *value_r) {
    for (int i = BUFFER_SIZE - 2; i >= 0; i--) {
        value_l[i + 1] = value_l[i];
        value_r[i + 1] = value_r[i];
    }
    value_l[0] = analogRead(FW_L);
    value_r[0] = analogRead(FW_R);
}

// Lee las entradas del trimmer ADJ de ambos canales y las almacena en variables. Realiza una lectura cada 250ms
// Requiere:
//  adjust_l: puntero de la variable para guardar el valor del canal L
//  adjust_r: puntero de la variable para guardar el valor del canal R
void read_adjust(unsigned int *adjust_l, unsigned int *adjust_r) {
    static unsigned long t = 0;

    if (millis() - t >= 250) {
        t = millis();
        *adjust_l = analogRead(ADJ_L);
        *adjust_r = analogRead(ADJ_R);
    }
}

// Busca el valor de pico de las últimas lecturas de los canales analógicos de entrada. Tamaño del buffer de búsqueda BUFFER_SIZE² samples
// Requiere:
//  peak_l: puntero de la variable para guardar el valor de pico del canal L
//  value_l: array de muestras de entrada del canal L
//  peak_r: puntero de la variable para guardar el valor de pico del canal R
//  value_r: array de muestras de entrada del canal R
void search_peak_value(unsigned int *peak_l, unsigned int *value_l, unsigned int *peak_r, unsigned int *value_r) {
    unsigned int max_l = 0;
    unsigned int max_r = 0;
    static unsigned int counter = 0;
    static unsigned int max_value_l[BUFFER_SIZE];
    static unsigned int max_value_r[BUFFER_SIZE];

    counter++;
    if (counter == BUFFER_SIZE) {
        counter = 0;
        for (int i = 0; i < BUFFER_SIZE; i++) {
            if (value_l[i] > max_l) max_l = value_l[i];
            if (value_r[i] > max_r) max_r = value_r[i];
        }
        for (int i = BUFFER_SIZE - 2; i >= 0; i--) {
            max_value_l[i + 1] = max_value_l[i];
            max_value_r[i + 1] = max_value_r[i];
        }
        max_value_l[0] = max_l;
        max_value_r[0] = max_r;
    }
    *peak_l = 0;
    *peak_r = 0;
    for (int i = 0; i < BUFFER_SIZE; i++) {
        if (max_value_l[i] > *peak_l) *peak_l = max_value_l[i];
        if (max_value_r[i] > *peak_r) *peak_r = max_value_r[i];
    }
}

// Genera la señal de salida en función de los valores de entrada
// Requiere:
//  input_min: indicador de si ambas entradas están en reposo
//  value_l: array de muestras de entrada del canal L
//  adjust_l: valor del trimmer ADJ del canal L
//  value_r: array de muestras de entrada del canal R
//  adjust_r: valor del trimmer ADJ del canal R
void process_channel(boolean input_min, unsigned int *value_l , unsigned int adjust_l, unsigned int *value_r , unsigned int adjust_r) {
    boolean polarity_l = false;
    boolean polarity_r = false;
    unsigned char sample_l = 0;
    unsigned char sample_r = 0;

    if (!input_min) {
        digitalWrite(STBY, HIGH);
        polarity_l = digitalRead(TRG_L);
        digitalWrite(AIN1, !polarity_l);
        digitalWrite(AIN2, polarity_l);
        sample_l = constrain(map(value_l[0], 0, adjust_l, 0, 255), 0, 255);
        analogWrite(APWM, sample_l);
        polarity_r = digitalRead(TRG_R);
        digitalWrite(BIN1, !polarity_r);
        digitalWrite(BIN2, polarity_r);
        sample_r = constrain(map(value_r[0], 0, adjust_r, 0, 255), 0, 255);
        analogWrite(BPWM, sample_r);
    }
    else digitalWrite(STBY, LOW);
}

// Establece los indicadores de estado. Se actualiza cada 500ms
// Requiere:
//  input_min_l: puntero donde se guarda el estado de entrada en reposo para el canal L
//  input_max_l: puntero donde se guarda el estado de entrada saturada para el canal L
//  output_l: puntero donde se guarda el estado de clipping en salida para el canal L
//  peak_l: valor de pico de las muestras de entrada del canal L
//  adjust_l: valor del trimmer ADJ del canal L
//  input_min_r: puntero donde se guarda el estado de entrada en reposo para el canal R
//  input_max_r: puntero donde se guarda el estado de entrada saturada para el canal R
//  output_r: puntero donde se guarda el estado de clipping en salida para el canal R
//  peak_r: valor de pico de las muestras de entrada del canal R
//  adjust_r: valor del trimmer ADJ del canal R
void set_status(boolean *input_min_l, boolean *input_max_l, boolean *output_l, unsigned int peak_l, unsigned int adjust_l, boolean *input_min_r, boolean *input_max_r, boolean *output_r, unsigned int peak_r, unsigned int adjust_r) {
    static unsigned long t = 0;

    if (millis() - t >= 500) {
        t = millis();
        if (peak_l < STANDBY_THRESHOLD) *input_min_l = true;
        else *input_min_l = false;
        if (peak_r < STANDBY_THRESHOLD) *input_min_r = true;
        else *input_min_r = false;
        if (peak_l > SATURATION_THRESHOLD) *input_max_l = true;
        else *input_max_l = false;
        if (peak_r > SATURATION_THRESHOLD) *input_max_r = true;
        else *input_max_r = false;
        if (peak_l > adjust_l) *output_l = true;
        else *output_l = false;
        if (peak_r > adjust_r) *output_r = true;
        else *output_r = false;
    }
}

// Muestra el estado actual usando un LED
// Requiere:
//  input_min: indicador de si ambas entradas están en reposo
//  input_max: indicador de si alguna de las entradas está saturada
//  output: indicador de si alguna de las salidas hace clipping
void display_status(boolean input_min, boolean input_max, boolean output) {
    if (input_min) digitalWrite(DEBUG, HIGH);
    else if (input_max) digitalWrite(DEBUG, millis() & 0x20);
    else if (output) digitalWrite(DEBUG, millis() & 0x80);
    else digitalWrite(DEBUG, LOW);
}
