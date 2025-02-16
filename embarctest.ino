#include "Mouse.h"
#include <WiFi.h>

#define BTA 5
#define BTB 6
#define MIC 28

WiFiServer server(80);

// seta os números do pino do botão e joystick
const int switchPin = 22;    // botão para acionar ou desacionar o controle
const int mouseButton = 22;  // pino de entrada para o botão do mouse
const int xAxis = 27;        // joystick X axis GPIO27
const int yAxis = 26;        // joystick Y axis GPIO26

//parâmetros de conexão
const char *ssid = "SSID";
const char *pw = "PASSWORD";

// parâmetros para ler o joystick
int range = 12;             // output range of X or Y movement
int responseDelay = 5;      // response delay of the mouse, in ms
int threshold = range / 4;  // resting threshold
int center = range / 2;     // resting position value

bool mouseIsActive = false;  // whether or not to control the mouse
int lastSwitchState = LOW;   // previous switch state
int valormic, estadoBTA, estadoBTB;
int flagA, flagB = 0;
String txt = "";

int deBounce(int estado, int pino) {
  int estadoatual = digitalRead(pino);

  if (estado != estadoatual) {
    delay(5);
    estadoatual = digitalRead(pino);
  }
  return estadoatual;
}
void setup() {
  pinMode(switchPin, INPUT_PULLUP);  //o botão de troca
  pinMode(BTA, INPUT_PULLUP);        //configura GPIO5 como pino de entrada e habilita o resistor pull-up interno
  pinMode(BTB, INPUT_PULLUP);        //configura GPIO6 como pino de entrada e habilita o resistor pull-up interno
  pinMode(MIC, INPUT);

  Serial.begin(115200);
  WiFi.begin(ssid, pw);
  //Checa o estado de conexão
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("tentando conectar");
  }
  Serial.println("Conectado");
  delay(500);
  Serial.println(WiFi.localIP());  //exibe o ip local
  delay(500);
  server.begin();
  // toma o controle do mouse
  Mouse.begin();
}

void loop() {
  //WiFiClient client = server.accept();
  WiFiClient client = server.available();  //vê se o servidor está disponível
  valormic = analogRead(MIC);              //variável que armazena a leitura do microfone

  if (client) {
    while (client.connected()) {
      //recebe o input dos botões, armazena e envia o comando pro godot
      if (flagA == 0 and deBounce(flagA, BTA) == HIGH) {
        flagA = 1;
        client.print("bta Adesligado\n");
        delay(500);
        Serial.println("BTA desligado");
      } else if (flagA == 1 and deBounce(flagA, BTA) == LOW) {
        client.print("bta Aligado\n");
        flagA = 0;
        Serial.println("BTA ligado");
        delay(500);
      }
      if (flagB == 0 and deBounce(flagB, BTB) == HIGH) {
        flagB = 1;
        client.print("btb Bdesligado\n");
        Serial.println("BTB desligado");
        delay(500);
      } else if (flagB == 1 and deBounce(flagB, BTB) == LOW) {
        client.print("btb Bligado\n");
        flagB = 0;
        Serial.println("BTB ligado");
        delay(500);
      }
      if (valormic >= 600){
        client.print("pulo\n");
      }

      //abaixo é a funçao de receção de mensagens do godot
      if (client.available()) {
        String s = client.readStringUntil('\n');
        if (s == "olhamensagem") {
          Serial.println("mensagem do godot");
        }
      }
    }
  }
  // read the switch:
  int switchState = digitalRead(switchPin);
  // if it's changed and it's high, toggle the mouse state:
  if (switchState != lastSwitchState) {
    if (switchState == HIGH) {
      mouseIsActive = !mouseIsActive;
      // turn on LED to indicate mouse state:
      Serial.println("ativaçao do mouse muda de estado");
    }
  }
  // save switch state for next comparison:
  lastSwitchState = switchState;

  // read and scale the two axes:
  int xReading = readAxis(27);
  int yReading = readAxis(26);

  // if the mouse control state is active, move the mouse:
  if (mouseIsActive) {
    Mouse.move(xReading, yReading, 0);
  }

  // read the mouse button and click or not click:
  // if the mouse button is pressed:
  if (digitalRead(mouseButton) == HIGH) {
    // if the mouse is not pressed, press it:
    if (!Mouse.isPressed(MOUSE_LEFT)) {
      Mouse.press(MOUSE_LEFT);
    }
  }
  // else the mouse button is not pressed:
  else {
    // if the mouse is pressed, release it:
    if (Mouse.isPressed(MOUSE_LEFT)) {
      Mouse.release(MOUSE_LEFT);
    }
  }

  delay(responseDelay);
}
/*
  reads an axis (0 or 1 for x or y) and scales the analog input range to a range
  from 0 to <range>
*/

int readAxis(int thisAxis) {
  // read the analog input:
  int reading = analogRead(thisAxis);

  // map the reading from the analog input range to the output range:
  reading = map(reading, 0, 1023, 0, range);

  // if the output reading is outside from the rest position threshold, use it:
  int distance = reading - center;

  if (abs(distance) < threshold) {
    distance = 0;
  }

  // return the distance for this axis:
  return distance;
}
