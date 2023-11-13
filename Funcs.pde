/*
Functions that return transformation matrix
*/
PMatrix2D scaleMatrix(float sx, float sy) {
  PMatrix2D scale = new PMatrix2D(sx, 0, 0, 0, sy, 0);
  return scale;
}


PMatrix2D translateMatrix(float tx, float ty) {
  PMatrix2D translation = new PMatrix2D(1, 0, tx, 0, 1, ty);
  return translation;
}


PMatrix2D rotateMatrix(float angle) {
  float cosVal = cos(angle);
  float sinVal = sin(angle);
  PMatrix2D rotation = new PMatrix2D(cosVal, -sinVal, 0, sinVal, cosVal, 0);
  return rotation;
}
