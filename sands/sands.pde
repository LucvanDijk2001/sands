//program
Globals globals;
HUD hud;
Workspace currentWorkspace;
boolean debug = false;
int u = 0;

//project structure
ArrayList<Workspace> workspaces = new ArrayList<Workspace>();
ArrayList<WorkspaceFolder> folders = new ArrayList<WorkspaceFolder>();

void setup()
{
  //window
  fullScreen(1);
  smooth(2);
  colorMode(HSB);
  
  //default
  MakeDefaultProject();
  
  //program
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
  hud.Update();
}

void MakeDefaultProject()
{
  WorkspaceFolder defaultFolder = new WorkspaceFolder("default");
  WorkspaceFolder defaultFolder2 = new WorkspaceFolder("defaultNested");
  defaultFolder.folders.add(defaultFolder2);
  folders.add(defaultFolder);
  workspaces.add(new Workspace("workspace0", defaultFolder));
  workspaces.add(new Workspace("workspace1", defaultFolder2));
  currentWorkspace = workspaces.get(0);
}

void mouseWheel(MouseEvent event)
{
  if (!globals.mouseOverMenu)
  {
    currentWorkspace.ZoomWorkspace(event.getCount());
  }
  
  hud.explorer.ScrollArea(event.getCount());
}

void ChangeWorkspace(int workspaceID)
{
  currentWorkspace = workspaces.get(workspaceID);
}

void keyPressed()
{
  if (key == 'p')
  {
    //debug = !debug;
  }
}
