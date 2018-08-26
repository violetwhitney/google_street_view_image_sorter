import controlP5.*;
import java.util.*;

ControlP5 cp5;

RadioButton buttonSortBy;
int CHRON = 0;
int LOT_AREA = 1;
int NUM_PEOPLE = 2;
int STOP_AND_FRISK = 3;
int RES_FAR = 4;
int POLICE_PRCT = 5;
PFont neutraFont;
PFont verdanaFont;

int variableY = 0;
int ySpeed = 200;
int thumbnailWidth = 0;
int thumbnailHeight = 0;
//int rowWidth = 815;
//int widthRightScreen = 1180;
//int widthEnd = 2000;
int rowWidth = 590;
int widthRightScreen = 850;
int widthEnd = 1440;

String [] data;
String [] dataB;

ArrayList<String> uwsLotAreas;
ArrayList<String> uwsAddress;
ArrayList<String> uwsNumPeople;
ArrayList<String> uwsStopAndFrisk;
ArrayList<String> uwsResFAR;
ArrayList<String> uwsPolPrct;


ArrayList<String> brownsvilleLotAreas;
ArrayList<String> brownsvilleAddress;
ArrayList<String> brownsvilleNumPeople;
ArrayList<String> brownsvilleStopAndFrisk;
ArrayList<String> brownsvilleResFAR;
ArrayList<String> brownsvillePolPrct;

ArrayList<RowThumbnail> uwsRows;
ArrayList<RowThumbnail> brownsvilleRows;

//.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)


//------------------------------------------------------------------------------------------------------------------------

void setup() {
  size(1440, 900);
  
  neutraFont = createFont("NeutraDisp-Bold", 20);
  verdanaFont = createFont("Verdana", 18);
  
  cp5 = new ControlP5(this);
  buttonSortBy = cp5.addRadioButton("buttonSortBy")
                    .setPosition(0, 0)
                    .setSize(240, 80)
                    //hover color
                    .setColorForeground(color(255, 10, 10))
                    .setColorBackground(color(128, 128, 128))
                    //active color
                    .setColorActive(color(255, 0, 0))
                    //not sure what the hell this does
                    .setColorLabel(color(255, 0, 0))
                    .setItemsPerRow(10)
                    .setSpacingColumn(0)
                    //.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
                    .setFont(createFont("arial", 20))
                    
                    .addItem("Chron", CHRON)
                    .addItem("Lot Area", LOT_AREA)
                    .addItem("Num People", NUM_PEOPLE)
                    .addItem("Stop And Frisk", STOP_AND_FRISK)
                    .addItem("Res FAR", RES_FAR)
                    .addItem("Police Precinct", POLICE_PRCT)
                    ;       
                    
  
     
 for(Toggle t:buttonSortBy.getItems()) {
       t.getCaptionLabel().setColor(color(255, 255, 255));
       t.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
       //t.getCaptionLabel().style().moveMargin(-7,0,0,-3);
       //t.getCaptionLabel().style().movePadding(7,0,0,3);
       //t.getCaptionLabel().style().backgroundWidth = 45;
       //t.getCaptionLabel().style().backgroundHeight = 13;
     }
  
  thumbnailWidth = width / 10;
  thumbnailHeight = int(thumbnailWidth * 400.0 / 640.0);
  widthRightScreen = width-thumbnailWidth*4;
  widthEnd = width;
  
  uwsRows = new ArrayList<RowThumbnail>();
  uwsLotAreas = new ArrayList<String>();
  uwsAddress = new ArrayList<String>();
  uwsNumPeople = new ArrayList<String>();
  uwsStopAndFrisk = new ArrayList<String>();
  uwsResFAR = new ArrayList<String>();
  uwsPolPrct = new ArrayList<String>();
  
  brownsvilleRows = new ArrayList<RowThumbnail>();
  brownsvilleLotAreas = new ArrayList<String>();
  brownsvilleAddress = new ArrayList<String>();
  brownsvilleNumPeople = new ArrayList<String>();
  brownsvilleStopAndFrisk = new ArrayList<String>();
  brownsvilleResFAR = new ArrayList<String>();
  brownsvillePolPrct = new ArrayList<String>();
  
  loadDataTable();
  loadRows();
  
  buttonSortBy.activate(CHRON);
}


void draw() {
  background(255);
  //drawButtons();
  
  pushMatrix();
  
  translate(0, -(frameCount+variableY));

  for (int row = 0; row < uwsRows.size(); row++ ){
    pushMatrix();
    translate(0, row * (thumbnailHeight + 20));
    
    RowThumbnail rt = uwsRows.get(row);
    rt.rowDraw(LEFTSIDE);
    if (mousePressed && rt.isMouseOver() && mouseY > 100) {
      selectRow(rt);
    }
    
    popMatrix();
  }
  //brownsvilleRows.size();
  for (int row = 0; row < brownsvilleRows.size(); row++ ){
    pushMatrix();
    translate(widthRightScreen, row * (thumbnailHeight + 20));
    
    RowThumbnail rt = brownsvilleRows.get(row);
    rt.rowDraw(RIGHTSIDE);
    if (mousePressed && rt.isMouseOver() && mouseY > 100) {
      selectRow(rt);
    }
    
    popMatrix();
  }

  popMatrix();
  
  // ---- showing the thumbnails in the selected row ----
  if (selectedRow != null) {
    selectedRow.drawBig();
  }
  
  //-------header------
  
  noStroke();
  fill(230, 230, 230);
  rect(0, 80, 1440, 30);
  fill(230,230,230);
  rect(0, 80, 590, 30);
  rect(860, 80, 590, 30);
  //stroke(153);
  fill(255);
  textFont(neutraFont);
  textSize(20);
  textAlign(LEFT);
  text("UPPER WEST SIDE", 200, 100);
  text("BROWNSVILLE", 1100, 100);
  textAlign(LEFT, LEFT);
  textFont(verdanaFont);
  
  
}


void loadDataTable() {
  Table data = loadTable("upperWestSide_vacantLot_processing.csv", "header");
  for (TableRow row : data.rows()) {
    String n = row.getString("LotArea");
    String dla = new String(n);
    uwsLotAreas.add(dla);
    String a = row.getString("Address");
    String da = new String(a);
    uwsAddress.add(da);
    String p = row.getString("NumPeople");
    String np = new String(p);
    uwsNumPeople.add(np);
    String sf = row.getString("StopAndFrisk");
    String saf = new String(sf);
    uwsStopAndFrisk.add(saf);
    String rf = row.getString("ResidFAR");
    String rfar = new String(rf);
    uwsResFAR.add(rfar);
    String pp = row.getString("PolicePrct");
    String polp = new String(pp);
    uwsPolPrct.add(polp);
  }
  
  Table dataB = loadTable("brownsville_vacantLot_processing.csv", "header");
  for (TableRow row : dataB.rows()) {
    String n = row.getString("LotArea");
    String dla = new String(n);
    brownsvilleLotAreas.add(dla);
    String a = row.getString("Address");
    String da = new String(a);
    brownsvilleAddress.add(da);
    String p = row.getString("NumPeople");
    String np = new String(p);
    brownsvilleNumPeople.add(np);
    String sf = row.getString("StopAndFrisk");
    String saf = new String(sf);
    brownsvilleStopAndFrisk.add(saf);
    String rf = row.getString("ResidFAR");
    String rfar = new String(rf);
    brownsvilleResFAR.add(rfar);
    String pp = row.getString("PolicePrct");
    String polp = new String(pp);
    brownsvillePolPrct.add(polp);
  }
}

void loadRows() {
  int numUwsRows = uwsLotAreas.size();
  for (int i = 0; i < numUwsRows; i++){
    int lotArea = int(uwsLotAreas.get(i));
    int numPeople = int(uwsNumPeople.get(i));
    int stopAndFrisk = int(uwsStopAndFrisk.get(i));
    int polPrct = int(uwsPolPrct.get(i));
    float resFAR = float(uwsResFAR.get(i));
    String address = uwsAddress.get(i);
    RowThumbnail rt = new RowThumbnail(i + 2, address, lotArea, numPeople, stopAndFrisk, polPrct, resFAR, "uwsVacantLot");
    uwsRows.add(rt);
  }
  //brownsvilleLotAreas.size()
  int numBrownsvilleRows = brownsvilleLotAreas.size();
  for (int i = 0; i < numBrownsvilleRows; i++) {
    int lotArea = int(brownsvilleLotAreas.get(i));
    int numPeople = int(brownsvilleNumPeople.get(i));
    int stopAndFrisk = int(brownsvilleStopAndFrisk.get(i));
    int polPrct = int(brownsvillePolPrct.get(i));
    float resFAR = float(brownsvilleResFAR.get(i));
    String address = brownsvilleAddress.get(i);
    RowThumbnail rt = new RowThumbnail(i + 2, address, lotArea, numPeople, stopAndFrisk, polPrct, resFAR, "brownsvilleVacantLot");
    brownsvilleRows.add(rt);
  }
}  

void keyPressed(){
  if (keyCode == DOWN) {
    variableY = variableY + ySpeed;
  } if (keyCode == UP) {
    variableY = variableY - ySpeed;
  } if (key == ' ') {
    selectedRow = null;
  }
}


//-----------Buttons--------------------------------------------------------------------------------------------------


void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(buttonSortBy)) {
    sortThumbnails();
  }
}

void sortThumbnails() {
  int selectedButton = (int) buttonSortBy.getValue();
  if (selectedButton == CHRON) {
    Collections.sort(uwsRows, new SortThumb("chron"));
    Collections.sort(brownsvilleRows, new SortThumb("chron"));
  } else if (selectedButton == LOT_AREA) {
    Collections.sort(uwsRows, new SortThumb("lotArea"));
    Collections.sort(brownsvilleRows, new SortThumb("lotArea"));
  } else if (selectedButton == NUM_PEOPLE) {
    Collections.sort(uwsRows, new SortThumb("numPeople"));
    Collections.sort(brownsvilleRows, new SortThumb("numPeople"));
  } else if (selectedButton == STOP_AND_FRISK) {
    Collections.sort(uwsRows, new SortThumb("stopAndFrisk"));
    Collections.sort(brownsvilleRows, new SortThumb("stopAndFrisk"));
  } else if (selectedButton == RES_FAR) {
    Collections.sort(uwsRows, new SortThumb("resFAR"));
    Collections.sort(brownsvilleRows, new SortThumb("resFAR"));
  } else if (selectedButton == POLICE_PRCT) {
    Collections.sort(uwsRows, new SortThumb("polPrct"));
    Collections.sort(brownsvilleRows, new SortThumb("polPrct"));
  }
}

RowThumbnail selectedRow = null;

void selectRow(RowThumbnail row) {
  if (selectedRow != row) {
    selectedRow = row;
  }
}