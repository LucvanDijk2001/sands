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
  int windowHeight = 0;
  PGraphics mask;
  boolean init = false;

  SimpleMaskGraphic smg; //==temp

  //==================================================CONSTRUCT================================
  HUDConExplorer(int y, int _h)
  {
    pos.y = y;
    windowHeight = _h;
  }

  //==================================================UPDATE================================
  void Show()
  {
    CheckInit();

    fill(globals.HUDItemDentColor);
    stroke(globals.HUDStroke);
    rect(menu.pos.x, pos.y, menu.size.x, windowHeight);

    mask.beginDraw();
    mask.clear();



    mask.endDraw();
    image(mask, menu.pos.x, pos.y);
  }

  //==================================================FUNCTIONS================================
  void CheckInit()
  {
    if (!init)
    {
      init = true;
      mask = createGraphics((int)menu.size.x, windowHeight);
      smg = new SimpleMaskGraphic(10, 10, 50, 50, mask);//==temp
    }
  }

  //==================================================CLASSES================================
  class MaskGraphic
  {
    PGraphics mask;
    MaskGraphic(PGraphics m)
    {
      mask = m;
    }

    void Show() {
    };
    void Update() {
    };
  }

  class SimpleMaskGraphic extends MaskGraphic
  {
    int x, y, w, h;
    SimpleMaskGraphic(int _x, int _y, int _w, int _h, PGraphics m)
    {
      super(m);
      x = _x;
      y = _y;
      w = _w;
      h = _h;
    }

    void Show()
    {
      mask.rect(x, y, w, h, 5);
    }

    void Update()
    {
      y ++;
      w ++;
    }
  }
}
