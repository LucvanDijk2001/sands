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

  HUDMenu debugMenu;///DEBUGMENU==========================
  HUDButton spawnNodeButton;
  HUDButton printFileStructureButton;

  ArrayList<HUDMenu> menus = new ArrayList<HUDMenu>();

  HUD()
  {
    int WHOneP = height/100;
    int mainmenuwidth = 350;
    int menubars = 20;
    int menux  = 0, menuy  = 0, menuw  = mainmenuwidth, menuh  = 80, menubm  = menubars;
    int cmenux = 0, cmenuy = 0+menuh, cmenuw = mainmenuwidth, cmenuh = WHOneP * 45, cmenubm = menubars;
    int nmenux = 0, nmenuy = 0+menuh+cmenuh, nmenuw = mainmenuwidth, nmenuh = height-menuh-cmenuh, nmenubm = menubars;
    int dmenux = width-200, dmenuy = 0, dmenuw = 200, dmenuh = 500, dmenubm = menubars;

    menu             = new HUDMenu(menux, menuy, menuw, menuh, menubm, "HUD menu", true);
    conversationMenu = new HUDMenu(cmenux, cmenuy, cmenuw, cmenuh, cmenubm, "Conversation explorer", false);
    nodeMenu         = new HUDMenu(nmenux, nmenuy, nmenuw, nmenuh, nmenubm, "Nodes", false);
    debugMenu        = new HUDMenu(dmenux, dmenuy, dmenuw, dmenuh, dmenubm, "DEBUG menu", false);
    //mouseMenu      = new MouseMenu(200,300);

    menus.add(menu);
    menus.add(conversationMenu);
    menus.add(nodeMenu);

    //================================mainmenu=============================================
    loadProject   = menu.AddHUDButton(0, 0, (int)menu.GetWidth()/3-1, 40, "Load project");
    saveProject   = menu.AddHUDButton((int)menu.GetWidth()/3, 0, (int)menu.GetWidth()/3-1, 40, "Save project");
    exportProject = menu.AddHUDButton((int)menu.GetWidth()/3*2, 0, (int)menu.GetWidth()/3+1, 40, "Export project");
    mainDivider   = menu.AddHUDHDivider(50);

    //================================Conversationmenu=====================================
    explorer            = conversationMenu.AddHUDConExplorer(0, 0, cmenuw, cmenuh-20);
    conversationDivider = conversationMenu.AddHUDHDivider(470);

    //================================Nodemenu=============================================

    //================================Debugmenu============================================
    spawnNodeButton          = debugMenu.AddHUDButton(0, dmenuh-50, (int)debugMenu.size.x/2, 30, "Spawn node");
    printFileStructureButton = debugMenu.AddHUDButton((int)debugMenu.size.x/2, dmenuh-50, (int)debugMenu.size.x/2, 30, "print fs");
  }

  void Show()
  {
    for (int i = 0; i < menus.size(); i++)
    {
      HUDMenu currentMenu = menus.get(i);
      currentMenu.Show();
    }

    if (debug)
    {
      debugMenu.Show();
    }
  }

  void Update()
  {
    for (int i = 0; i < menus.size(); i++)
    {
      HUDMenu currentMenu = menus.get(i);
      currentMenu.Update();
    }

    if (debug)
    {
      debugMenu.Update();
    }

    MainMenu();
    ConversationMenu();
    NodeMenu();
    
    if(debug)
    {
      DebugMenu();
    }
  }

  void MainMenu()
  {
  }

  void ConversationMenu()
  {
  }

  void NodeMenu()
  {

  }

  void DebugMenu()
  {
    //live hud items
    debugMenu.ShowText(10, 10, "workspace: " + currentWorkspace.workspaceName,color(30,220,240));
    debugMenu.ShowText(10, 35, "workspacesition x: " + round(currentWorkspace.windowPos.x * -1),color(30,220,240));
    debugMenu.ShowText(10, 50, "workspace position y: " + round(currentWorkspace.windowPos.y * -1),color(30,220,240));
    debugMenu.ShowText(10, 65, "workspace zoom: " + nf(currentWorkspace.zoom, 0, 1),color(30,220,240));
    debugMenu.ShowText(10, 80, "Nodes in workspace: " + currentWorkspace.nodes.size(),color(30,220,240));
    
    debugMenu.ShowText(10, 105, "Folder amount: " + folders.size(), color(70, 200, 200));
    debugMenu.ShowText(10, 120, "Workspace amount: " + workspaces.size(), color(70, 200, 200));

    debugMenu.ShowText(10, int(debugMenu.size.y-debugMenu.barMargin-55), "Background drawCalls: " + currentWorkspace.bgDrawCalls, color(30, 200, 200));
    debugMenu.ShowText(10, int(debugMenu.size.y-debugMenu.barMargin-40), "FPS: " + frameRate, color(30, 200, 200));
    
    

    if (spawnNodeButton.Released())
    {
      for(int i = 0; i < 50; i++)
      {
      currentWorkspace.AddNode((int)random(-3000,3000), (int)random(-3000,3000), 200, 100, 20);
      }
    }

    if (printFileStructureButton.Released())
    {
      for (int i = 0; i < folders.size(); i++)
      {
        WorkspaceFolder folder = folders.get(i);
        folder.PrintContent(0);
      }
      print("\n\n\n");
    }
  }
}
