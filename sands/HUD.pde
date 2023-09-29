class HUD
{
  HUDMenu menu;///MAINMENU================================
  HUDButton loadProject;
  HUDButton saveProject;
  HUDHDivider mainDivider;
  
  //MouseMenu mouseMenu;///MOUSEMENU======================
  
  HUDMenu conversationMenu;//CONVERSATIONMENU=============
  HUDConExplorer explorer;
  HUDHDivider conversationDivider;
  
  HUDMenu nodeMenu;///NODEMENU============================
  HUDButton workspace1Button;
  HUDButton workspace2Button;
  
  HUDMenu debugMenu;///DEBUGMENU==========================
  HUDButton spawnNodeButton;
  
  HUD()
  {
    int mainmenuwidth = 350;
    int menubars = 20;
    int menux  = 0,         menuy  = 0,              menuw  = mainmenuwidth, menuh  = 100,                 menubm  = menubars;
    int cmenux = 0,         cmenuy = 0+menuh,        cmenuw = mainmenuwidth, cmenuh = 500,                 cmenubm = menubars;
    int nmenux = 0,         nmenuy = 0+menuh+cmenuh, nmenuw = mainmenuwidth, nmenuh = height-menuh-cmenuh, nmenubm = menubars;
    int dmenux = width-200, dmenuy = 0,              dmenuw = 200,           dmenuh = 200,                 dmenubm = menubars;
    
    menu             = new HUDMenu(menux,  menuy,  menuw,  menuh,  menubm, "HUD menu", false);
    conversationMenu = new HUDMenu(cmenux, cmenuy, cmenuw, cmenuh, cmenubm,"Conversation explorer",false);
    nodeMenu         = new HUDMenu(nmenux, nmenuy, nmenuw, nmenuh, nmenubm,"Nodes",false);
    debugMenu        = new HUDMenu(dmenux, dmenuy, dmenuw, dmenuh, dmenubm,"DEBUG menu",false);
    
    //mouseMenu = new MouseMenu(200,300);
    //================================mainmenu=============================================
    loadProject = menu.AddHUDButton(new HUDButton(0,0,(int)menu.GetWidth()/2,60,"Load project"));
    saveProject = menu.AddHUDButton(new HUDButton((int)menu.GetWidth()/2,0,(int)menu.GetWidth()/2,60,"Save project"));
    mainDivider = menu.AddHUDHDivider(new HUDHDivider(70));
    
    //================================Conversationmenu=====================================
    explorer            = conversationMenu.AddHUDConExplorer(new HUDConExplorer(0,460));
    conversationDivider = conversationMenu.AddHUDHDivider(new HUDHDivider(470));
    
    //================================Nodemenu=============================================
    workspace1Button = nodeMenu.AddHUDButton(new HUDButton(10, 100, 100, 50,"Workspace 1"));
    workspace2Button = nodeMenu.AddHUDButton(new HUDButton(10, 225, 100, 50,"Workspace 2"));
    
    //================================Debugmenu============================================
    spawnNodeButton = debugMenu.AddHUDButton(new HUDButton(10, 100, 100, 50,"Cool button"));
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
    
    MainMenu();
    ConversationMenu();
    NodeMenu();
    DebugMenu();
  }
  
  void MainMenu()
  {
    
  }
  
  void ConversationMenu()
  {
    
  }
  
  void NodeMenu()
  {
    if(workspace1Button.Pressed())
    {
     currentWorkspace = tempWorkspace; 
    }
    if(workspace2Button.Pressed())
    {
      currentWorkspace = tempWorkspace2;
    }
  }
  
  void DebugMenu()
  {
    //live hud items
    debugMenu.ShowText(10, 10, "workspacesition x: " + round(currentWorkspace.windowPos.x * -1));
    debugMenu.ShowText(10, 25, "workspace position y: " + round(currentWorkspace.windowPos.y * -1));
    debugMenu.ShowText(10, 50, "workspace zoom: " + nf(currentWorkspace.zoom, 0, 1));
    debugMenu.ShowText(10, 65, "FPS: " + frameRate);
    
    if(spawnNodeButton.Pressed())
    {
      currentWorkspace.AddNode(0,0,200,100,20);
    }
  }
}
