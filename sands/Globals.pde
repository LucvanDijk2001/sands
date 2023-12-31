class Globals
{
  PImage workspaceBackground;

  float nmx;
  float nmy;
  float pnmx;
  float pnmy;

  boolean mouseInUse = false;
  boolean mouseOverMenu = false;

  //hud colors
  color HUDMenuColor = color(140, 10, 70);
  color HUDMenuBarColor = color(140, 5, 20);
  color HUDItemColor = color(140, 20, 40);
  color HUDItemDentColor = color(140, 30, 55);
  color HUDItemHeldColor = color(140, 5, 30);
  color MaskConversationColor = color(140, 30, 70);
  color MaskConversationHeldColor = color(140, 25, 50);
  color HUDStroke = color(140, 5, 20);
  color HUDHoverStroke = color(160, 20, 220);
  color HUDTextColor = color(160, 10, 240);
  color HUDSliderColor = color(140, 15, 30);
  color HUDSliderHandleColor = color(140, 25, 60);
  color HUDSliderHandleHeldColor = color(140, 25, 50);
  color HUDFolderColorClosed = color(140, 80, 50);
  color HUDFolderColorOpen = color(140, 100, 120);

  //node colors
  color NodeStrokeColor = color(160, 20, 40);
  color NodeBarColor = color(168, 96, 120);
  color NodeTextColor = color(168, 78, 180);
  color NodeColor = color(160, 28, 164, 200);

  Globals()
  {
    workspaceBackground = loadImage("images/bgGrid.png");
  }

  void Update()
  {
    nmx = ((mouseX-(currentWorkspace.windowPos.x*currentWorkspace.zoom))-width/2)/currentWorkspace.zoom;
    nmy = ((mouseY-(currentWorkspace.windowPos.y*currentWorkspace.zoom))-height/2)/currentWorkspace.zoom;
    pnmx = ((pmouseX-(currentWorkspace.windowPos.x*currentWorkspace.zoom))-width/2)/currentWorkspace.zoom;
    pnmy = ((pmouseY-(currentWorkspace.windowPos.y*currentWorkspace.zoom))-height/2)/currentWorkspace.zoom;
    CheckMouseOnMenu();
  }

  PVector GetMousePos()
  {
    return new PVector(nmx, nmy);
  }

  PVector GetPrevMousePos()
  {
    return new PVector(pnmx, pnmy);
  }

  PVector GetMouseHudPos()
  {
    return new PVector(mouseX, mouseY);
  }

  PVector GetMouseHudPos(int offsetX, int offsetY)
  {
    return new PVector(mouseX+offsetX, mouseY+offsetY);
  }

  PVector GetPrevMouseHudPos()
  {
    return new PVector(pmouseX, pmouseY);
  }

  PVector GetPrevMouseHudPos(int offsetX, int offsetY)
  {
    return new PVector(mouseX+offsetX, mouseY+offsetY);
  }

  boolean IsShift()
  {
    if (keyPressed)
    {
      if (keyCode == SHIFT)
      {
        return true;
      }
    }
    return false;
  }

  void CheckMouseOnMenu()
  {
    PVector mousePos = GetMouseHudPos();
    mouseOverMenu = false;
    ;

    for (int i = 0; i < hud.menus.size(); i++)
    {
      HUDMenu currentMenu = hud.menus.get(i);
      if (mousePos.x > currentMenu.pos.x && mousePos.x < currentMenu.pos.x+currentMenu.size.x && mousePos.y > currentMenu.pos.y && mousePos.y < currentMenu.pos.y+currentMenu.size.y)
      {
        mouseOverMenu = true;
        break;
      }
    }

    if (debug)
    {
      HUDMenu currentMenu = hud.debugMenu;
      if (mousePos.x > currentMenu.pos.x && mousePos.x < currentMenu.pos.x+currentMenu.size.x && mousePos.y > currentMenu.pos.y && mousePos.y < currentMenu.pos.y+currentMenu.size.y)
      {
        mouseOverMenu = true;
      }
    }
  }

  WorkspaceFolder GetFolder(String name)
  {
    for (int i = 0; i < folders.size(); i++)
    {
      if (folders.get(i).folderName == name)
      {
        return folders.get(i);
      }
    }
    return null;
  }
}
