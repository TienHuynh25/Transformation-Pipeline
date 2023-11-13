class alien {
  final color BLACK = color(0);
  final color WHITE = color(255);
  final color PINK = color(255, 192, 203);
  final color GRAY = color(169, 169, 169);

  final float BODY_WIDTH = 0.5;
  final float BODY_HEIGHT = 0.3;
  final float HEAD_SIZE = 0.25;
  final float EAR_SIZE = 0.08;
  final float EYE_SIZE = 0.03;
  final float MOUTH_SIZE = 0.05;
  final float LEG_SIZE = 0.15;
  final float TAIL_LENGTH = 0.15;

  float x, y;
  float scale;

  alien(float x, float y, float scale) {
    this.x = x;
    this.y = y;
    this.scale = scale;
  }

  void draw() {
    myPush();
    myTranslate(x, y);
    myScale(scale,scale);

    drawBody();
    drawHead();
    drawEars();
    drawEyes();
    drawMouth();
    drawLegs();
    drawTail();

    myPop();
  }

  void drawBody() {
    fill(GRAY);
    stroke(BLACK);
    beginShape();
    myVertex(-BODY_WIDTH / 2, 0);
    myVertex(BODY_WIDTH / 2, 0);
    myVertex(BODY_WIDTH / 2, BODY_HEIGHT);
    myVertex(-BODY_WIDTH / 2, BODY_HEIGHT);
    endShape(CLOSE);
  }

  void drawHead() {
    fill(GRAY);
    stroke(BLACK);
    beginShape();
    float halfHeadSize = HEAD_SIZE / 2;
    for (float a = -PI/4; a <= PI/4; a += 0.02) {
      float x = cos(a) * halfHeadSize;
      float y = sin(a) * halfHeadSize;
      myVertex(x, -BODY_HEIGHT / 2 - halfHeadSize + y);
    }
    endShape(CLOSE);
  }

  void drawEars() {
    fill(GRAY);
    stroke(BLACK);
    float halfEarSize = EAR_SIZE / 2;
    for (int i = -1; i <= 1; i += 2) {
      beginShape(TRIANGLE_STRIP);
      float earX = i * (BODY_WIDTH / 2 + halfEarSize);
      for (float a = -PI/4; a <= PI/4; a += 0.02) {
        float x = cos(a) * halfEarSize;
        float y = sin(a) * halfEarSize;
        myVertex(earX + x, -BODY_HEIGHT / 2 + y);
      }
      endShape(CLOSE);
    }
  }

  void drawEyes() {
    fill(WHITE);
    stroke(BLACK);
    for (int i = -1; i <= 1; i += 2) {
      float eyeX = i * (HEAD_SIZE / 4);
      beginShape(LINE);
      for (float a = 0; a < TWO_PI; a += 0.02) {
        float x = cos(a) * (EYE_SIZE / 2);
        float y = sin(a) * (EYE_SIZE / 2);
        myVertex(eyeX + x, -BODY_HEIGHT / 2 - HEAD_SIZE / 4 + y);
      }
      endShape(CLOSE);
    }
  }

  void drawMouth() {
    noFill();
    stroke(PINK);
    strokeWeight(2);
    beginShape(TRIANGLE_FAN);
    for (float a = -PI/6; a <= PI/6; a += 0.02) {
      float x = cos(a) * (MOUTH_SIZE / 2);
      float y = sin(a) * (MOUTH_SIZE / 2);
      myVertex(x, -BODY_HEIGHT / 2 - HEAD_SIZE / 4 - MOUTH_SIZE / 2 + y);
    }
    endShape();
  }

  void drawLegs() {
    fill(GRAY);
    stroke(BLACK);
    float legY = BODY_HEIGHT / 2;
    for (int i = -1; i <= 1; i += 2) {
      float legX = i * (BODY_WIDTH / 4);
      beginShape();
      myVertex(legX, legY);
      myVertex(legX + LEG_SIZE, legY);
      myVertex(legX + LEG_SIZE, legY + LEG_SIZE * 2);
      myVertex(legX, legY + LEG_SIZE * 2);
      endShape(CLOSE);
    }
  }

  void drawTail() {
    fill(GRAY);
    stroke(BLACK);
    float tailX = BODY_WIDTH / 2;
    float tailY = BODY_HEIGHT / 2;
    beginShape(TRIANGLE_STRIP);
    myVertex(tailX, tailY);
    myVertex(tailX + TAIL_LENGTH, tailY);
    myVertex(tailX + TAIL_LENGTH, tailY + LEG_SIZE / 2);
    myVertex(tailX, tailY + LEG_SIZE / 2);
    endShape(CLOSE);
  }
}
