import java.util.Stack;  // for your matrix stack
Stack<PMatrix2D> matrixStack = new Stack<PMatrix2D>();
PMatrix2D currentTransform = new PMatrix2D(); // Initialize as an identity matrix

//initialization
PMatrix2D V;  // View matrix
PMatrix2D Pr; // Projection matrix
PMatrix2D Vp; // Viewport matrix
PMatrix2D M;  // Model matrix

PVector cameraCenter;  // Center of the camera in world coordinates
PVector cameraUp;      // Up vector for the camera
PVector cameraPerp;    // Perpendicular vector for the camera
float cameraZoom = 1.0; // Initial zoom level
float cameraRotation = 0.0; // Initial rotation angle

alien alien1, alien2, alien3, alien4, alien5, alien6;

void setup() {
  size(600, 600);  // don't change, and don't use the P3D renderer
  colorMode(RGB, 1.0f);

  // put additional setup here
  // Initialize the projection matrix (Pr)
  float left = -200;   // Left boundary of the orthographic projection
  float right = 200;   // Right boundary
  float bottom = -200; // Bottom boundary
  float top = 200;     // Top boundary
  Pr = getOrtho(left, right, bottom, top);
  
  // Initialize the camera matrix (V)
  cameraCenter = new PVector(0, 0); // Camera center position
  cameraUp = new PVector(0, 1);    // Up vector
  cameraPerp = new PVector(-1, 0);  // Perpendicular vector
  V = getCamera(cameraCenter, cameraUp, cameraPerp, cameraZoom);
  
  // Initialize the viewport matrix (Vp)
  Vp = getViewPort();
  
  // Initialize the model matrix (M) as the identity matrix
  M = new PMatrix2D(); // Identity matrix
  
  // Initialize the current transformation matrix
  currentTransform = new PMatrix2D();
  
  
  alien1 = new alien(100, 200, 100);
  alien2 = new alien(250, 250, 100);
  alien3 = new alien(50, 250, 100);
  alien4 = new alien(400, 200, 500);
  alien5 = new alien(250, 950, 1000);
  alien6 = new alien(200, 350, 1000);
  
}

void draw() {
  background(0); // you can change this if you create a BLACK constant

  switch (testMode) {
  case PATTERN:
    drawTest(1000);
    drawTest(100);
    drawTest(1);
    break;

  case SCENE:
    background(255,10,200);
    drawScene();
    break;
    
  case SQUARES:
    moveSquares();
    drawSquares();
    break;
  }
}

// feel free to add a new file for drawing your scene

void drawScene() {
  // First level of nesting
  myPush();
  myFlip(true, true);
  myScale(10, 50);
  drawObject2(); // Calls the second level of nesting
  myPop();

  myPush();
  myTranslate(1, 0);
  myScale(0.5, 0.5);
  drawObject(); // Calls the second level of nesting
  myPop();
  
  myPush();
  myFlip(false, true);
  myScale(1, 0.7);
  drawObject(); // Calls the second level of nesting
  myPop();
}

void drawObject() {
  // Second level of nesting
  myPush();
  myFlip(true,false);
  myScale(0.7, 0.7);
  drawAlien();
  myPop();

  myPush();
  myTranslate(0.2, 0.2);
  myScale(500, 1000);
  myRotate(PI/4);
  drawAlien();
  myPop();
  
  myPush();
  myTranslate(0.5, -0.5);
  myScale(5000, 500);
  myRotate(PI/8);
  drawObject2();
  myPop();
}

void drawObject2(){
  alien1.draw();
  alien4.draw();
  alien5.draw();
  alien6.draw();
}

void drawAlien(){
  alien1.draw();
  alien2.draw();
  alien3.draw();
  alien4.draw();
  alien5.draw();
  alien6.draw();
}

void mouseDragged() {
  /*
   how much the mouse has moved between this frame and the previous one,
   measured in viewport coordinates - you will have to do further
   calculations with these numbers
   */
  float xMove = mouseX - pmouseX;
  float yMove = mouseY - pmouseY;

  // Implement click-and-drag panning
  // Update the camera center based on the mouse drag (convert viewport to world coordinates)
  float worldXMove = xMove / cameraZoom;
  float worldYMove = yMove / cameraZoom;

  cameraCenter.x -= worldXMove;
  cameraCenter.y += worldYMove;

  // Update the camera view matrix using the updated center
  currentTransform = getCamera(cameraCenter, cameraUp, cameraPerp, cameraZoom, cameraRotation);
}
