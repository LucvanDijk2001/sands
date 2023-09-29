class HUD
{
  HUDMenu menu;///MAINMENU================
  //MouseMenu mouseMenu;
  HUDButton loadProject;
  HUDButton saveProject;
  HUDHDivider d1;
  
  HUDMenu conversationMenu;
  HUDConExplorer explorer;
  HUDHDivider d2;
  
  HUDMenu nodeMenu;
  HUDButton w1;
  HUDButton w2;
  
  HUDMenu debugMenu;///DEBUGMENU=================
  HUDButton b;
  
  HUD()
  {
    menu = new HUDMenu(0, 0, 350, 100,20, "HUD menu", false);
    conversationMenu = new HUDMenu(0,100,350,500,20,"Conversation explorer",false);
    nodeMenu = new HUDMenu(0, 600,350,height-600,20,"Nodes",false);
    debugMenu = new HUDMenu(width-200,0,200,200,20,"DEBUG menu",false);
    //mouseMenu = new MouseMenu(200,300);
    b = debugMenu.AddHUDButton(new HUDButton(10, 100, 100, 50,"Cool button"),"Button");
    loadProject = menu.AddHUDButton(new HUDButton(0,0,(int)menu.GetWidth()/2,60,"Load project"),"LoadProject");
    saveProject = menu.AddHUDButton(new HUDButton((int)menu.GetWidth()/2,0,(int)menu.GetWidth()/2,60,"Save project"),"SaveProject");
    d1 = menu.AddHUDHDivider(new HUDHDivider(70),"Divider1");
    w1 = nodeMenu.AddHUDButton(new HUDButton(10, 100, 100, 50,"Workspace 1"),"Button2");
    w2 = nodeMenu.AddHUDButton(new HUDButton(10, 225, 100, 50,"Workspace 2"),"Button3");
    explorer = conversationMenu.AddHUDConExplorer(new HUDConExplorer(0,460),"Explorer");
    d2 = conversationMenu.AddHUDHDivider(new HUDHDivider(470),"Divider2");
  }

  void Show()
  {
    menu.Show();
    menu.Update();
    conversationMenu.Show();
    conversationMenu.Update();
    nodeMenu.Show();
    nodeMenu.Update();
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
