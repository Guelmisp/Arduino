/* Coleta de Dados - Trabalho de Fisica 4
 * Miguel Pessoa
 * Leitura de Sensor de Temperatura e Luminosidade
 * Rele para ativar luz incandescente AC 120V
 * Salva resultado em Arquivo
*/

// After collect the data we need to change it for Celsius
// Temp in Celsius
// temperatura = (float(analogRead(LM35))*5/(1023))/0.01
#define aref_voltage 3.3

const int LM35 = A1;
float tempReading;

void setup() {
  Serial.begin(9600);
}

void loop() {
  
    tempReading = float(analogRead(LM35));
    //Print the voltage
    //value will be read from Matlab to get rhe values.
    Serial.println(tempReading);

    delay(100);
}
