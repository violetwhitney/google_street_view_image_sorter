class GoogleThumbnail {
  PImage thumbnail;
  
  GoogleThumbnail(String location, int index, int direction) {
    String filename = location + "-" + index + "-" + direction + ".jpg";
    this.thumbnail = loadImage(filename);
  }
  
  void thumbnailDraw() {
    float top = screenY(0, 0);
    float bottom = screenY(thumbnailWidth, thumbnailHeight);
    
    // Are you sure you're on the screen?
    if (top > 0 - thumbnailHeight && bottom < height + thumbnailHeight) {
      image(this.thumbnail, 0, 0, thumbnailWidth, thumbnailHeight);
      this.checkForMouseover();      
    }
  }
  
  void checkForMouseover() {
    float startX = screenX(0, 0);
    float startY = screenY(0, 0);
    float endX = screenX(thumbnailWidth, thumbnailHeight);
    float endY = screenY(thumbnailWidth, thumbnailHeight);
    
    if (startX < mouseX && mouseX < endX && startY < mouseY && mouseY < endY) {
      // Draw highlight.
      fill(255, 0, 0, 200);
      rect(0, 0, thumbnailWidth, thumbnailHeight);
    }
  }
} //end of GoogleThumbnail Class