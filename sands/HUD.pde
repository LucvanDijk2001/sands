class HUD
{
  HUDMenu menu;///MAINMENU================================
  HUDButton loadProject;
  HUDButton saveProject;
  HUDButton exportProject;
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
  
  ArrayList<HUDMenu> menus = new ArrayList<HUDMenu>();
  
  HUD()
  {
    int mainmenuwidth = 350;
    int menubars = 20;
    int menux  = 0,         menuy  = 0,              menuw  = mainmenuwidth, menuh  = 80,                 menubm  = menubars;
    int cmenux = 0,         cmenuy = 0+menuh,        cmenuw = mainmenuwidth, cmenuh = 500,                 cmenubm = menubars;
    int nmenux = 0,         nmenuy = 0+menuh+cmenuh, nmenuw = mainmenuwidth, nmenuh = height-menuh-cmenuh, nmenubm = menubars;
    int dmenux = width-200, dmenuy = 0,              dmenuw = 200,           dmenuh = 200,                 dmenubm = menubars;
    
    menu             = new HUDMenu(menux,  menuy,  menuw,  menuh,  menubm, "HUD menu", false);
    conversationMenu = new HUDMenu(cmenux, cmenuy, cmenuw, cmenuh, cmenubm,"Conversation explorer",false);
    nodeMenu         = new HUDMenu(nmenux, nmenuy, nmenuw, nmenuh, nmenubm,"Nodes",false);
    debugMenu        = new HUDMenu(dmenux, dmenuy, dmenuw, dmenuh, dmenubm,"DEBUG menu",false);
    //mouseMenu      = new MouseMenu(200,300);
    
    menus.add(menu);
    menus.add(conversationMenu);
    menus.add(nodeMenu);
    menus.add(debugMenu);
    
    //================================mainmenu=============================================
    loadProject   = menu.AddHUDButton(new HUDButton(0,0,(int)menu.GetWidth()/3,40,"Load project"));
    saveProject   = menu.AddHUDButton(new HUDButton((int)menu.GetWidth()/3,0,(int)menu.GetWidth()/3,40,"Save project"));
    exportProject = menu.AddHUDButton(new HUDButton((int)menu.GetWidth()/3*2,0,(int)menu.GetWidth()/3,40,"Export project"));
    mainDivider   = menu.AddHUDHDivider(new HUDHDivider(50));
    
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
    for(int i = 0; i < menus.size(); i++)
    {
       HUDMenu currentMenu = menus.get(i);
       currentMenu.Show();
       currentMenu.Update();
    }
    
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
     ChangeWorkspace(0);
    }
    if(workspace2Button.Pressed())
    {
      ChangeWorkspace(1);
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
