#include <Servo.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

// ===== LCD Configuration =====
LiquidCrystal_I2C lcd(0x27, 16, 2);

// ===== Servo =====
Servo radarServo;

// ===== Pin Definitions =====
#define trigPin 10
#define echoPin 11
#define servoPin 9
#define buzzerPin 7

// ===== Detection Settings =====
const int detectionRange = 15;

long duration;
int distance;

void setup() {

  Serial.begin(9600);

  // Configure pins
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(buzzerPin, OUTPUT);

  digitalWrite(buzzerPin, LOW);

  // Attach servo
  radarServo.attach(servoPin);

  // Initialize LCD
  lcd.init();
  lcd.backlight();

  lcd.setCursor(0, 0);
  lcd.print("RADAR SYSTEM");

  lcd.setCursor(0, 1);
  lcd.print("Starting...");
  delay(2000);

  lcd.clear();
}

void loop() {

  // Sweep from 0° to 180°
  for (int angle = 0; angle <= 180; angle++) {

    radarServo.write(angle);
    delay(15);

    distance = getDistance();

    processData(distance, angle);
  }

  // Sweep from 180° to 0°
  for (int angle = 180; angle >= 0; angle--) {

    radarServo.write(angle);
    delay(15);

    distance = getDistance();

    processData(distance, angle);
  }
}

// ===== Distance Measurement =====
int getDistance() {

  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);

  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH, 30000);

  int dist = duration * 0.034 / 2;

  // Ignore invalid readings
  if (dist <= 0 || dist > 400) {
    dist = 999;
  }

  return dist;
}

// ===== Radar Logic =====
void processData(int dist, int angle) {

  // Object detected within range
  if (dist <= detectionRange) {

    // Turn buzzer ON
    digitalWrite(buzzerPin, HIGH);

    // Update LCD
    lcd.setCursor(0, 0);
    lcd.print("OBJECT FOUND  ");

    lcd.setCursor(0, 1);
    lcd.print("Dist: ");
    lcd.print(dist);
    lcd.print(" cm   ");
  }

  else {

    // Turn buzzer OFF
    digitalWrite(buzzerPin, LOW);

    // Update LCD
    lcd.setCursor(0, 0);
    lcd.print("NO OBJECT    ");

    lcd.setCursor(0, 1);
    lcd.print("Scanning...  ");
  }

  // Send data to Processing
  Serial.print(angle);
  Serial.print(",");
  Serial.println(dist);
}
