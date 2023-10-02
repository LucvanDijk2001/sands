class MaskToggable extends MaskClickable
{
  boolean toggled = false;
  String name = "Toggle";
  boolean isLeftText = false;
  String offText = "";
  String onText = "X";
  
  MaskToggable(int _x, int _y, int _w, int _h, String _name, PGraphics _mask, HUDConExplorer _owner)
  {
    super(_x, _y, _w, _h, _mask, _owner);
    name = _name;
  }
  
  MaskToggable(int _x, int _y, int _w, int _h, String _name, boolean _isLeftText, PGraphics _mask, HUDConExplorer _owner)
  {
    super(_x, _y, _w, _h, _mask, _owner);
    name = _name;
    isLeftText = _isLeftText;
  }
  
  void Show(int offset)
  {
     super.Show(offset);
     
     if(isLeftText)
     {
       mask.textAlign(RIGHT,CENTER);
       mask.text(name,pos.x-5,pos.y+size.y/2+offset);
     }
     else
     {
       mask.textAlign(LEFT,CENTER);
       mask.text(name,pos.x+size.x+5,pos.y+size.y/2+offset);
     }
     
     mask.textAlign(CENTER,CENTER);
     if(toggled)
     {
       mask.text(onText,pos.x+size.x/2,pos.y+size.y/2+offset);
     }
     else
     {
       mask.text(offText,pos.x+size.x/2,pos.y+size.y/2+offset);
     }
  }

  void Update()
  {
    super.Update();
    if (released)
    {
      toggled = !toggled;
    }
  }

  boolean GetToggled()
  {
    return toggled;
  }
  
  void SetOnText(String txt)
  {
     onText = txt; 
  }
  
  void SetOffText(String txt)
  {
     offText = txt; 
  }
}
