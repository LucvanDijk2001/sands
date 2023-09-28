class HUD
{
  HUDMenu menu;
  HUDButton b;
  
  HUD()
  {
    menu = new HUDMenu(0, 0, 200, 500,20, "HUD menu", false);
    b = menu.AddHUDButton(new HUDButton(10, 100, 100, 50,"Cool button"),"Button");
  }

  void Show()
  {
    menu.Show();
    menu.Update();
    
    //live hud items
    menu.ShowText(10, 10, "workspacesition x: " + round(currentWorkspace.windowPos.x * -1));
    menu.ShowText(10, 25, "workspace position y: " + round(currentWorkspace.windowPos.y * -1));
    menu.ShowText(10, 50, "workspace zoom: " + nf(currentWorkspace.zoom, 0, 1));
    

    if(b.Pressed())
    {
     print("Pressed"); 
    }
    if(b.Held())
    {
     print("Held"); 
    }
     if(b.Released())
    {
     print("Released"); 
    }
  }
}
