// don't change these keys
final char KEY_ROTATE_CW = ']';
final char KEY_ROTATE_CCW = '[';
final char KEY_ZOOM_IN = '='; // plus sign without the shift
final char KEY_ZOOM_OUT = '-';
final char KEY_ORTHO_MODE = 'o';
final char KEY_DISPLAY_MODE = 'd';

enum OrthoMode {
  IDENTITY, // straight to viewport with no transformations (Pr, V and M are all the identity)
    CENTER600, // bottom left is (-300,-300), top right is (300,300), center is (0,0)
    TOPRIGHT600, // bottom left is (0,0), top right is (600,600)
    FLIPX, // same as CENTER600 but reflected through y axis (x -> -x)
    ASPECT // uneven aspect ratio: x is from -300 to 300, y is from -100 to 100
}
OrthoMode orthoMode = OrthoMode.IDENTITY;

enum DisplayMode {
  PATTERN, 
    SCENE,
    SQUARES
}
DisplayMode testMode = DisplayMode.PATTERN;

void keyPressed() {
  if (key == KEY_ZOOM_IN) {
    cameraZoom *= 1.1; // Adjust the zoom factor as desired
  } else if (key == KEY_ZOOM_OUT) {
    cameraZoom /= 1.1; // Adjust the zoom factor as desired
  } else if (key == KEY_ROTATE_CW) {
    cameraRotation += radians(5); // Rotate clockwise by 5 degrees (adjust as needed)
  } else if (key == KEY_ROTATE_CCW) {
    cameraRotation -= radians(5); // Rotate counterclockwise by 5 degrees (adjust as needed)
  } else if (key == '1'){
    testMode = DisplayMode.PATTERN;
  } else if (key == '2'){
    testMode = DisplayMode.SCENE;
  } else if (key == '3'){
    testMode = DisplayMode.SQUARES;
  }

  // Update the camera view matrix using the updated parameters
  currentTransform = getCamera(cameraCenter, cameraUp, cameraPerp, cameraZoom, cameraRotation);
}

final int NUM_LINES = 11;
// draw a test pattern, centered on (0,0), with the given scale
void drawTest(float scale) {
  float left, right, top, bottom;
  left = bottom = -scale/2;
  right = top = scale/2;

  strokeWeight(1);
  beginShape(LINES);
  for (int i=0; i<NUM_LINES; i++) {
    float x = left + i*scale/(NUM_LINES-1);
    float y = bottom + i*scale/(NUM_LINES-1);

    setHorizontalColor(i);
    myVertex(left, y);
    myVertex(right, y);

    setVerticalColor(i);
    myVertex(x, bottom);
    myVertex(x, top);
  }
  endShape(LINES);
}

void setHorizontalColor(int i) {
  int r, g, b;
  r = (i > NUM_LINES/2) ? 0 : 1;
  g = (i > NUM_LINES/2) ? 1 : 0;
  b = (i > NUM_LINES/2) ? 0 : 1;
  stroke(r, g, b);
}

void setVerticalColor(int i) {
  int r, g, b;
  r = (i > NUM_LINES/2) ? 1 : 0;
  g = (i > NUM_LINES/2) ? 1 : 0;
  b = (i > NUM_LINES/2) ? 0 : 1;
  stroke(r, g, b);
}
