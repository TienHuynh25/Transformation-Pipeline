# COMP 3490 - Computer Graphics 1
## Transformation Pipeline and Advanced Camera Models

### Prerequisites
- Processing 4.3

### Installation
1. Download and install Processing from [processing.org](https://processing.org/download/).

### 1. Transformation Pipeline

Implement the full transformation pipeline from object space to viewport space. Utilize the following matrices:

- **Vp:** Viewport matrix - Transform from NDC to the Processing viewport.
- **Pr:** Projection matrix - Transform from camera coordinates to NDC using an orthographic projection.
- **V:** View matrix - Transform from world coordinates to camera coordinates.
- **M:** Model matrix - Transform from model coordinates to world coordinates.

### 2. Advanced Camera Models

Implement the ability to change the camera model using the provided hotkeys in `DrawingModesA3.pde`.

- **Zoom In/Out:** Modify how much the camera scales the image. Zooming in should make the image appear larger, and zooming out should make it appear smaller.
