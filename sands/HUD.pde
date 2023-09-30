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
  HUDButton printFileStructureButton;

  ArrayList<HUDMenu> menus = new ArrayList<HUDMenu>();

  HUD()
  {
    int mainmenuwidth = 350;
    int menubars = 20;
    int menux  = 0, menuy  = 0, menuw  = mainmenuwidth, menuh  = 80, menubm  = menubars;
    int cmenux = 0, cmenuy = 0+menuh, cmenuw = mainmenuwidth, cmenuh = 500, cmenubm = menubars;
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
    explorer            = conversationMenu.AddHUDConExplorer(0, 0, cmenuw, 460);
    conversationDivider = conversationMenu.AddHUDHDivider(470);

    //================================Nodemenu=============================================
    workspace1Button = nodeMenu.AddHUDButton(10, 100, 100, 50, "Workspace 1");
    workspace2Button = nodeMenu.AddHUDButton(10, 225, 100, 50, "Workspace 2");

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
      currentMenu.Update();
    }

    if (debug)
    {
      debugMenu.Show();
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
    if (workspace1Button.Pressed())
    {
      ChangeWorkspace(0);
    }
    if (workspace2Button.Pressed())
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
    debugMenu.ShowText(10, 75, "Folder amount: " + folders.size(), color(70, 200, 200));
    debugMenu.ShowText(10, 90, "Workspace amount: " + workspaces.size(), color(70, 200, 200));

    debugMenu.ShowText(10, int(debugMenu.size.y-debugMenu.barMargin-55), "Background drawCalls: " + currentWorkspace.bgDrawCalls, color(30, 200, 200));
    debugMenu.ShowText(10, int(debugMenu.size.y-debugMenu.barMargin-40), "FPS: " + frameRate, color(30, 200, 200));

    if (spawnNodeButton.Released())
    {
      currentWorkspace.AddNode(0, 0, 200, 100, 20);
    }

    if (printFileStructureButton.Released())
    {
      for (int i = 0; i < folders.size(); i++)
      {
        WorkspaceFolder folder = folders.get(i);
        print(folder.folderName + "\n");
        for (int j = 0; j < folder.workspaces.size(); j++)
        {
          print("   - " + folder.workspaces.get(j).workspaceName + "\n");
        }
      }
      print("\n\n\n");
    }
  }
}
