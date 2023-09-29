class HUDConExplorer extends HUDItem
{
  //needs
  //open/close folders
  //folder items
  //scrollbar based on amount of content vertically
  //vertical items probably need a set size to calculate scrollbar size
  //need some sort of mask
  //items need to be clickable and dragable?
  
  //make area in menu
  //put some content in area
  //make it so area has a vertical offset, masks anything outside of the area
  //make scrollbar for offset
  //make folder object
  //make folder item object
  
  int yp = 0;
  int h = 0;
  
  HUDConExplorer(int y, int _h)
  {
   yp = y;
   h = _h;
  }
  
  void Show()
  {
    fill(globals.HUDItemDentColor);
    stroke(globals.HUDStroke);
    rect(menu.pos.x,pos.y,menu.pos.x+menu.size.x,h);
  }
}
