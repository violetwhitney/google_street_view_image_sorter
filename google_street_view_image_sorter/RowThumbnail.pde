int LEFTSIDE = 0;
int RIGHTSIDE = 1;

class RowThumbnail {
  int row;
  int lotArea;
  int numPeople;
  int stopAndFrisk;
  int polPrct;
  float resFAR;
  String address;
  String location;

  ArrayList<GoogleThumbnail> thumbnails;
  
  RowThumbnail(int row, String address, int lotArea, int numPeople, int stopAndFrisk, int polPrct, float resFAR, String location) {
    this.row = row;
    this.address = address;
    this.lotArea = lotArea;
    this.numPeople = numPeople;
    this.stopAndFrisk = stopAndFrisk;
    this.polPrct = polPrct;
    this.resFAR = resFAR;
    this.location = location;
    
    this.thumbnails = new ArrayList<GoogleThumbnail>();
    loadThumbnails();
  }
  
  void loadThumbnails() {
    this.thumbnails.add(new GoogleThumbnail(location, row, 0));
    this.thumbnails.add(new GoogleThumbnail(location, row, 90));
    this.thumbnails.add(new GoogleThumbnail(location, row, 180));
    this.thumbnails.add(new GoogleThumbnail(location, row, 270));
  }
  
  void rowDraw(int side) {
    for (int i = 0; i < this.thumbnails.size(); i++) {
      pushMatrix();
      translate(i * (thumbnailWidth + 5), 0);
      
      GoogleThumbnail thumb = this.thumbnails.get(i);
      thumb.thumbnailDraw();
      
      popMatrix();
    }
    
    float top = screenY(0, 0);
    float bottom = screenY(rowWidth, thumbnailHeight);
    
    //Are you sure you're on the screen?
    if (top > 0 - thumbnailHeight && bottom < height + thumbnailHeight) {
      this.checkForMouseover(side);
    }
  }
  
  void checkForMouseover(int side) {
    float startX = screenX(0, 0);
    float endX = screenX(rowWidth, thumbnailHeight);
    
    float startY = screenY(0, 0);
    float endY = screenY(rowWidth, thumbnailHeight);
   
    
    if (startX < mouseX && mouseX < endX && startY < mouseY && mouseY < endY) {
      fill(255, 0, 0, 150);
      rect(0, 0, rowWidth, thumbnailHeight);
      
      fill(255, 255, 255);
      for (int i = 0; i < numPeople; i++){
          float personPosition = i*9 + rowWidth;
          ellipse(personPosition-430, (3 * thumbnailHeight / 3)-15, 5, 5);
          rect(personPosition -432.5, (3 * thumbnailHeight / 3)-12.5, 5, 10);
        }
        for (int i = 0; i < stopAndFrisk; i++){
          float sfPersonPosition = i*9 + rowWidth;
          ellipse(sfPersonPosition-430, (3 * thumbnailHeight / 3)-35, 5, 5);
          rect(sfPersonPosition -432.5, (3 * thumbnailHeight / 3)-32.5, 5, 10);
        }
        
      fill(255, 0, 0);
      if (side == LEFTSIDE) {
        ellipse(rowWidth+40, thumbnailHeight/2, lotArea/thumbnailHeight, lotArea/thumbnailHeight);
      fill(255, 0, 0);
      } else {
        ellipse(-40, thumbnailHeight/2, lotArea/thumbnailHeight, lotArea/thumbnailHeight);
        fill(255, 255, 255);
      }
      
       //Draw text.
      fill(255,255,255);
      textSize(24);
      text(address, 20, (thumbnailHeight / 3)-5); 
      textSize(12);
      text("Lot Area:: " + str(lotArea) + " SQ FT      Resid FAR:" + str(resFAR) + "      Pol Prec: " + str(polPrct), 20, (3 * thumbnailHeight / 3)-45); 
      text("Stop and Frisk: " + stopAndFrisk, 20, (3 * thumbnailHeight / 3)-25); 
      text("Num People: " + numPeople, 20, (3 * thumbnailHeight / 3)-5); 
    } 
  }
  
  boolean isMouseOver() {
    float startX = screenX(0, 0);
    float endX = screenX(rowWidth, thumbnailHeight);
    
    float startY = screenY(0, 0);
    float endY = screenY(rowWidth, thumbnailHeight);
    
    return startX < mouseX && mouseX < endX && startY < mouseY && mouseY < endY;
  }
  
  void drawBig() {
    float x = 0;
    float thumbWidth = width / 4.0;
    
    for (GoogleThumbnail thumb: this.thumbnails) {
      PImage img = thumb.thumbnail;
      float thumbHeight = float(img.height) / float(img.width) * thumbWidth;
      image(img, x, height / 2.0 - thumbHeight / 2.0, thumbWidth, thumbHeight);
      x += thumbWidth;
    }
  }
} //end of RowThumbnail Class