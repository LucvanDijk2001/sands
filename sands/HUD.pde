class HUD
{
  HUDMenu menu;///MAINMENU================
  //MouseMenu mouseMenu;
  HUDButton loadProject;
  HUDButton saveProject;
  HUDHDivider d1;
  
  HUDButton w1;
  HUDButton w2;
  
  HUDMenu debugMenu;///DEBUGMENU=================
  HUDButton b;
  
  HUD()
  {
    menu = new HUDMenu(0, 0, 350, height,20, "HUD menu", false);
    debugMenu = new HUDMenu(width-200,0,200,200,20,"DEBUG menu",false);
    //mouseMenu = new MouseMenu(200,300);
    b = debugMenu.AddHUDButton(new HUDButton(10, 100, 100, 50,"Cool button"),"Button");
    loadProject = menu.AddHUDButton(new HUDButton(0,0,(int)menu.GetWidth()/2,60,"Load project"),"LoadProject");
    saveProject = menu.AddHUDButton(new HUDButton((int)menu.GetWidth()/2,0,(int)menu.GetWidth()/2,60,"Save project"),"SaveProject");
    d1 = menu.AddHUDHDivider(new HUDHDivider(70),"Divider1");
    w1 = menu.AddHUDButton(new HUDButton(10, 175, 100, 50,"Workspace 1"),"Button2");
    w2 = menu.AddHUDButton(new HUDButton(10, 250, 100, 50,"Workspace 2"),"Button3");
  }

  void Show()
  {
    menu.Show();
    menu.Update();
    debugMenu.Show();
    debugMenu.Update();
    //mouseMenu.Show();
    //mouseMenu.Update();
    
    //live hud items
    debugMenu.ShowText(10, 10, "workspacesition x: " + round(currentWorkspace.windowPos.x * -1));
    debugMenu.ShowText(10, 25, "workspace position y: " + round(currentWorkspace.windowPos.y * -1));
    debugMenu.ShowText(10, 50, "workspace zoom: " + nf(currentWorkspace.zoom, 0, 1));
    debugMenu.ShowText(10, 65, "FPS: " + frameRate);


    if(b.Pressed())
    {
      currentWorkspace.AddNode(0,0,200,100,20);
    }
    
    if(w1.Pressed())
    {
     currentWorkspace = tempWorkspace; 
    }
    if(w2.Pressed())
    {
      currentWorkspace = tempWorkspace2;
    }
  }
}
