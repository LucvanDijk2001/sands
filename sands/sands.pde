Workspace currentWorkspace;
ArrayList<Workspace> workspaces = new ArrayList<Workspace>();
ArrayList<WorkspaceFolder> folders = new ArrayList<WorkspaceFolder>();
Globals globals;
HUD hud;

void setup()
{
  fullScreen(1);
  smooth(2);
  colorMode(HSB);
  WorkspaceFolder defaultFolder = new WorkspaceFolder("default");
  folders.add(defaultFolder);
  workspaces.add(new Workspace("workspace1",defaultFolder));
  workspaces.add(new Workspace("workspace2",defaultFolder));
  currentWorkspace = workspaces.get(0);
  globals = new Globals();
  hud = new HUD();
  textAlign(LEFT, CENTER);
}

void draw()
{
  background(0);
  //update global values
  globals.Update();

  //seperate workspace draw matrix
  pushMatrix();
  currentWorkspace.Update();
  currentWorkspace.Show();
  popMatrix();

  //HUD calls
  hud.Show();
}

void mouseWheel(MouseEvent event)
{
  boolean doZoom = true;
  PVector mousePos = globals.GetMouseHudPos();
  
  for(int i = 0; i < hud.menus.size(); i++)
  {
    HUDMenu currentMenu = hud.menus.get(i);
    if(mousePos.x > currentMenu.pos.x && mousePos.x < currentMenu.pos.x+currentMenu.size.x && mousePos.y > currentMenu.pos.y && mousePos.y < currentMenu.pos.y+currentMenu.size.y)
    {
       doZoom = false; 
    }
  }
  
  if(doZoom)
  {
    currentWorkspace.ZoomWorkspace(event.getCount());
  }
}

void ChangeWorkspace(int workspaceID)
{
  currentWorkspace = workspaces.get(workspaceID);
}
