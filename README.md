# Arduino Radar System

A mini radar system built using **Arduino Nano, HC-SR04 ultrasonic sensor, SG90 servo motor, I2C LCD, buzzer, and Processing IDE** for real-time object detection and visualization.

## Project Overview

This project simulates a basic radar system where an ultrasonic sensor continuously scans the surroundings using a servo motor. The system detects nearby objects and displays them on a live radar interface created using Processing IDE.

When an object enters the detection range, the system:
- Detects the object in real time
- Activates a buzzer alert
- Displays distance on the LCD
- Marks the detected area in red on the radar screen

---

## Features

- 180° radar scanning
- Real-time radar visualization
- Object detection within **15 cm**
- I2C LCD distance display
- Buzzer alert system
- Live angle and distance tracking
- Real-time serial communication between Arduino and Processing

---

## Components Used

- Arduino Nano
- HC-SR04 Ultrasonic Sensor
- SG90 Servo Motor
- 16x2 I2C LCD Display
- Buzzer
- Breadboard
- Jumper Wires
- USB Cable

---

## Software Used

- Arduino IDE
- Processing IDE

---

## Circuit Connections

### Ultrasonic Sensor (HC-SR04)

| HC-SR04 | Arduino Nano |
|----------|---------------|
| VCC | 5V |
| GND | GND |
| TRIG | D10 |
| ECHO | D11 |

### Servo Motor

| Servo Wire | Arduino Nano |
|------------|---------------|
| Signal | D9 |
| VCC | 5V |
| GND | GND |

### Buzzer

| Buzzer | Arduino Nano |
|---------|---------------|
| + | D7 |
| - | GND |

### I2C LCD

| LCD Pin | Arduino Nano |
|----------|---------------|
| SDA | A4 |
| SCL | A5 |
| VCC | 5V |
| GND | GND |

---

## Working Principle

The servo motor rotates the ultrasonic sensor from **0° to 180°**, continuously scanning the surrounding area.

The ultrasonic sensor measures the distance of nearby objects. If an object is detected within **15 cm**, the buzzer turns ON, the LCD displays the object distance, and the radar interface highlights the detected region in red.

The Arduino sends **angle and distance data** to Processing IDE through serial communication, creating a real-time radar display.

---

## Future Improvements

- Longer detection range
- Wireless monitoring
- Better radar UI design
- Object tracking system
- IoT-based remote monitoring

---

## Author

**Shivanshu**  
B.Tech Electrical and Electronics Engineering (EEE)
