class HUDSlider extends HUDItem
{
  PVector size = new PVector(0, 0);
 
  HUDSliderHandle handle;
  int contentSize = 600;
  
  HUDSlider(int _x, int _y, int _w, int _h, HUDMenu menu)
  {
    super(menu);
    pos.x = _x;
    pos.y = _y;
    size.x = _w;
    size.y = _h;
    handle = new HUDSliderHandle(_x, _y, _w, 50,this, menu);
    handle.SetItemColor(globals.HUDSliderHandleColor);
    handle.SetItemHeldColor(globals.HUDSliderHandleHeldColor);
    handle.SetKeepHoverOnHeld(false);
  }

  void Show()
  {
    fill(globals.HUDSliderColor);
    stroke(globals.HUDStroke);
    rect(pos.x,pos.y,size.x,size.y);
    handle.Show();
  }

  void Update()
  {
    handle.SetHandleSize((int)constrain((size.y/contentSize)*size.y,0,size.y));
    handle.Update();
  }
  
  boolean HandlePressed() {
    return handle.pressed;
  }
  boolean HandleHeld() {
    return handle.held;
  }
  boolean HandleReleased() {
    return handle.released;
  }
  float GetHandleScrollMargin()
  {
    return((handle.pos.y-pos.y)/(size.y-handle.size.y));
  }
  
  void UpdateHandlePosition(float _margin)
  {
    handle.SetHandleMargin(_margin);
  }
}

class HUDSliderHandle extends HUDClickable
{
  HUDSlider parent;
  
  HUDSliderHandle(int _x, int _y, int _w, int _h,HUDSlider _parent, HUDMenu menu)
  {
    super(_x, _y, _w, _h, menu);
    parent = _parent;
  }

  void Update()
  {
    super.Update();
    
    PVector mp = globals.GetMouseHudPos();
    PVector pmp = globals.GetPrevMouseHudPos();
    
    if(held && mp.y > parent.pos.y && mp.y < parent.pos.y+parent.size.y)
    {
      
      pos.y += mp.y-pmp.y;
      pos.y = constrain(pos.y,parent.pos.y,parent.pos.y+parent.size.y-size.y);
    }
  }
  
  void SetHandleSize(int newSize)
  {
    size.y = newSize; 
  }
  
  void SetHandleMargin(float _margin)
  {
    pos.y = (parent.size.y-size.y)*_margin + parent.pos.y;
  }
}
