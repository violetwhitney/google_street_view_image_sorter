
class SortThumb implements Comparator {
  
  String metricToSortOn;
  
  SortThumb (String metricToSortOn_) {
    metricToSortOn = metricToSortOn_;
  }
  
  public int compare (Object a1, Object a2) {
    if (metricToSortOn == "lotArea") {
      Integer int1 = ((RowThumbnail) a1).lotArea; 
      Integer int2 = ((RowThumbnail) a2).lotArea;
      return int2.compareTo(int1);
    } else if (metricToSortOn == "chron"){ 
      Integer int1 = int(((RowThumbnail) a1).row); 
      Integer int2 = int(((RowThumbnail) a2).row);
      //Integer int1 = int(((RowThumbnail) a1).yearPublished); 
      //Integer int2 = int(((RowThumbnail) a2).yearPublished);
      return int1.compareTo(int2);
    } else if (metricToSortOn == "numPeople"){ 
      Integer int1 = int(((RowThumbnail) a1).numPeople); 
      Integer int2 = int(((RowThumbnail) a2).numPeople);
      return int2.compareTo(int1);
    } else if (metricToSortOn == "stopAndFrisk"){ 
      Integer int1 = int(((RowThumbnail) a1).stopAndFrisk); 
      Integer int2 = int(((RowThumbnail) a2).stopAndFrisk);
      return int2.compareTo(int1);
    } else if (metricToSortOn == "resFAR"){ 
      Integer int1 = int(((RowThumbnail) a1).resFAR); 
      Integer int2 = int(((RowThumbnail) a2).resFAR);
      return int1.compareTo(int2);
    } else if (metricToSortOn == "polPrct"){ 
      Integer int1 = int(((RowThumbnail) a1).polPrct); 
      Integer int2 = int(((RowThumbnail) a2).polPrct);
      return int1.compareTo(int2);
    } 
    return 0;
  }
}