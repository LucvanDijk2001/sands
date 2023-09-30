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

  //==================================================DATA================================
  PVector size = new PVector(0, 0);
  PGraphics mask;
  boolean onWindow = false;

  //==================================================CONSTRUCT================================
  HUDConExplorer(int x, int y, int w, int h)
  {
    pos.x = x;
    pos.y = y;
    size.x = w;
    size.y = h;
    mask = createGraphics((int)size.x, (int)size.y);
  }

  //==================================================UPDATE================================
  void Show()
  {
    CheckOnWindow();

    fill(globals.HUDItemDentColor);
    stroke(globals.HUDStroke);
    rect(pos.x,pos.y,size.x,size.y);

    mask.beginDraw();
    mask.clear();

    mask.endDraw();
    image(mask, menu.pos.x, pos.y);
  }

  //==================================================FUNCTIONS================================
  void CheckOnWindow()
  {
    onWindow = false;
    PVector mousePos = globals.GetMouseHudPos();
    if (mousePos.x > pos.x && mousePos.x < pos.x+size.x && mousePos.y > pos.y && mousePos.y < pos.y + size.y)
    {
      onWindow = true;
    }
  }

  //==================================================CLASSES================================
  class MaskGraphic
  {
    PGraphics mask;
    PVector gpos = new PVector(0, 0);
    PVector gsize = new PVector(0, 0);
    MaskGraphic(PGraphics m)
    {
      mask = m;
    }

    void Show() {
    };
    void Update() {
    };
  }
}
