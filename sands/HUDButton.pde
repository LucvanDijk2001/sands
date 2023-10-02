class HUDButton extends HUDClickable
{
  //========================================VALUES==============================//
  String title = "Button";
  
  //========================================INIT==============================//
  HUDButton(int x, int y, int w, int h, String text, HUDMenu menu)
  {
    super(x,y,w,h,menu);
    title = text;
  }

  //========================================MAIN==============================//
  void Show()
  {
    super.Show();
    textAlign(CENTER,CENTER);
    text(title,pos.x+size.x/2,pos.y+size.y/2);
  }

  void Update()
  {
    super.Update();
  }
}
