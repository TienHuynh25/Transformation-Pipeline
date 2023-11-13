// construct viewport matrix using width and height of canvas
PMatrix2D getViewPort() {
  // Create a transformation matrix
  return new PMatrix2D(width/2.0,0,width/2.0, 0,-height/2.0,height/2.0);
}

// construct projection matrix using 2D boundaries
PMatrix2D getOrtho(float left, float right, float bottom, float top) {
  return new PMatrix2D(2/(right-left),0,-((right+left)/(right-left)), 0,2/(top-bottom),-((top+bottom)/(top-bottom)));
}

// construct camera matrix using camera position, up vector, and zoom setting
PMatrix2D getCamera(PVector center, PVector up, PVector perp, float zoom) {
  up.normalize();
  perp.normalize();
  if(up.dot(perp) != 0){
    println("ERROR in getCamera: up and perp vectors are not perpendicular");
    return null;
  }
  PMatrix2D b = new PMatrix2D(perp.x,perp.y,0 ,up.x,up.y,0);
  PMatrix2D t = new PMatrix2D(1,0,-center.x, 0,1,-center.y);
  PMatrix2D s = new PMatrix2D(zoom,0,0 ,0,zoom,0);
  
  // Calculate the matrix product s * b * t
  PMatrix2D result = new PMatrix2D();
  result.apply(s);
  result.apply(b);
  result.apply(t);

  return result;
}
PMatrix2D getCamera(PVector center, PVector up, PVector perp, float zoom, float rotation) {
  up.normalize();
  perp.normalize();

  // Calculate the rotation matrix based on the rotation angle
  PMatrix2D rotateMatrix = new PMatrix2D(cos(rotation), -sin(rotation), 0, sin(rotation), cos(rotation), 0);
  
  PMatrix2D b = new PMatrix2D(perp.x, perp.y, 0, up.x, up.y, 0);
  PMatrix2D t = new PMatrix2D(1, 0, -center.x, 0, 1, -center.y);
  PMatrix2D s = new PMatrix2D(zoom, 0, 0, 0, zoom, 0);

  // Calculate the matrix product s * b * t * rotateMatrix
  PMatrix2D result = new PMatrix2D();
  result.apply(s);
  result.apply(b);
  result.apply(t);
  result.apply(rotateMatrix);

  return result;
}

/*
Functions that manipulate the matrix stack
 */

void myPush() {
  // Push a copy of the current transformation matrix onto the stack
  PMatrix2D matrixCopy = currentTransform.get(); // Create a copy of the current matrix
  matrixStack.push(matrixCopy); // Push the copy onto the stack
}

void myPop() {
  if (!matrixStack.empty()) {
    // Pop the last saved matrix from the stack and set it as the current matrix
    PMatrix2D savedMatrix = matrixStack.pop();
    currentTransform.set(savedMatrix);
  } else {
    println("ERROR in myPop: Transformation matrix stack is empty.");
  }
}


/*
Functions that update the model matrix
 */

void myScale(float sx, float sy) {
  PMatrix2D scaleMatrix = new PMatrix2D(sx, 0, 0, 0, sy, 0);
  currentTransform.apply(scaleMatrix);
}

void myTranslate(float tx, float ty) {
  PMatrix2D translateMatrix = new PMatrix2D(1, 0, tx, 0, 1, ty);
  currentTransform.apply(translateMatrix);
}

void myRotate(float theta) {
  PMatrix2D rotateMatrix = new PMatrix2D(cos(theta), -sin(theta), 0, sin(theta), cos(theta), 0);
  currentTransform.apply(rotateMatrix);
}
void myFlip(boolean horizontal, boolean vertical) {
  if (horizontal && vertical) {
    PMatrix2D flipMatrix = new PMatrix2D(-1, 0, 0, 0, -1, 0);
    currentTransform.apply(flipMatrix);
  } else if (horizontal) {
    PMatrix2D flipMatrix = new PMatrix2D(-1, 0, 0, 0, 1, 0);
    currentTransform.apply(flipMatrix);
  } else if (vertical) {
    PMatrix2D flipMatrix = new PMatrix2D(1, 0, 0, 0, -1, 0);
    currentTransform.apply(flipMatrix);
  }
}

/*
Receives a point in object space and applies the complete transformation
 pipeline, Vp.Pr.V.M.point, to put the point in viewport coordinates.
 Then calls vertex to plot this point on the raster
 */
void myVertex(float x, float y) {
  // Create a PVector representing the point in object space
  PVector objectPoint = new PVector(x, y, 1); // Homogeneous coordinates

  // Apply transformations in the following order: Vp.Pr.V.M
  PVector cameraPoint = new PVector();
  currentTransform.mult(objectPoint, cameraPoint); // M
  PVector worldPoint = new PVector();
  V.mult(cameraPoint, worldPoint); // V
  PVector ndcPoint = new PVector();
  Pr.mult(worldPoint, ndcPoint); // Pr
  PVector viewportPoint = new PVector();
  Vp.mult(ndcPoint, viewportPoint); // Vp

  // this is the only place in your program where you are allowed
  // to use the vertex command
  vertex(viewportPoint.x, viewportPoint.y);
}

// overload for convenience
void myVertex(PVector vertex) {
  myVertex(vertex.x, vertex.y);
}
