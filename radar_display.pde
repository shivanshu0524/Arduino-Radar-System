import processing.serial.*;

// ===== Serial Communication =====
Serial myPort;

// ===== Radar Variables =====
String data = "";
float pixelDistance;
int angle = 0;
int distance = 999;

// ===== Detection Settings =====
final int DETECTION_RANGE = 15;

void setup() {

  // Window size
  size(1200, 700);
  smooth();

  // Connect to Arduino Serial Port
  myPort = new Serial(this, "COM7", 9600);

  // Read incoming serial data line by line
  myPort.bufferUntil('\n');
}

void draw() {

  // Motion blur effect
  noStroke();
  fill(0, 20);
  rect(0, 0, width, height);

  // Draw radar components
  drawRadarGrid();
  drawSweepLine();
  drawDetectedObject();
  drawRadarText();
}

// ===== Receive Arduino Data =====
void serialEvent(Serial myPort) {

  data = myPort.readStringUntil('\n');

  if (data != null) {

    data = trim(data);

    String[] values = split(data, ',');

    if (values.length == 2) {

      angle = int(values[0]);
      distance = int(values[1]);
    }
  }
}

// ===== Radar Background Grid =====
void drawRadarGrid() {

  pushMatrix();

  translate(width / 2, height - 80);

  stroke(98, 245, 31);
  strokeWeight(2);
  noFill();

  // Radar arcs
  arc(0, 0, 1000, 1000, PI, TWO_PI);
  arc(0, 0, 800, 800, PI, TWO_PI);
  arc(0, 0, 600, 600, PI, TWO_PI);
  arc(0, 0, 400, 400, PI, TWO_PI);

  // Horizontal line
  line(-500, 0, 500, 0);

  // Angle guide lines
  for (int i = 30; i <= 150; i += 30) {

    line(
      0,
      0,
      (-500) * cos(radians(i)),
      (-500) * sin(radians(i))
    );
  }

  popMatrix();
}

// ===== Radar Sweep Line =====
void drawSweepLine() {

  pushMatrix();

  translate(width / 2, height - 80);

  strokeWeight(7);

  // Turn line red when object detected
  if (distance <= DETECTION_RANGE) {
    stroke(255, 0, 0);
  } else {
    stroke(30, 250, 60);
  }

  line(
    0,
    0,
    500 * cos(radians(angle)),
    -500 * sin(radians(angle))
  );

  popMatrix();
}

// ===== Detected Object =====
void drawDetectedObject() {

  if (distance <= DETECTION_RANGE) {

    pushMatrix();

    translate(width / 2, height - 80);

    // Convert cm to pixels
    pixelDistance = distance * 25;

    float objectX =
      pixelDistance * cos(radians(angle));

    float objectY =
      -pixelDistance * sin(radians(angle));

    // Draw red detection line
    stroke(255, 0, 0);
    strokeWeight(5);

    line(0, 0, objectX, objectY);

    // Draw object point
    strokeWeight(12);
    point(objectX, objectY);

    popMatrix();
  }
}

// ===== Radar Information Text =====
void drawRadarText() {

  fill(0);
  noStroke();

  rect(0, 0, 350, 180);

  textSize(28);

  fill(98, 245, 31);

  text("RADAR SYSTEM", 30, 40);
  text("Angle: " + angle + "°", 30, 80);

  if (distance <= DETECTION_RANGE) {

    fill(255, 0, 0);

    text("OBJECT DETECTED", 30, 120);
    text("Distance: " + distance + " cm", 30, 160);

  } else {

    fill(98, 245, 31);

    text("NO OBJECT", 30, 120);
  }
}
