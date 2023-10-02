class HUDToggable extends HUDClickable
{
  boolean toggled = false;
  String name = "Toggle";
  boolean isLeftText = false;
  String offText = "";
  String onText = "X";
  HUDToggable(int x, int y, int w, int h,String _name, HUDMenu menu)
  {
    super(x, y, w, h, menu);
    name = _name;
  }
  
  HUDToggable(int x, int y, int w, int h,String _name, boolean _isLeftText, HUDMenu menu)
  {
    super(x, y, w, h, menu);
    name = _name;
    isLeftText = _isLeftText;
  }

  void Show()
  {
     super.Show();
     
     if(isLeftText)
     {
       textAlign(RIGHT,CENTER);
       text(name,pos.x-5,pos.y+size.y/2);
     }
     else
     {
       textAlign(LEFT,CENTER);
       text(name,pos.x+size.x+5,pos.y+size.y/2);
     }
     
     textAlign(CENTER,CENTER);
     if(toggled)
     {
       text(onText,pos.x+size.x/2,pos.y+size.y/2);
     }
     else
     {
       text(offText,pos.x+size.x/2,pos.y+size.y/2);
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
