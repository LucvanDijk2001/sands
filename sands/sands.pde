//program
Globals globals;
HUD hud;
Workspace currentWorkspace;
boolean debug = false;

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
}

void MakeDefaultProject()
{
  WorkspaceFolder defaultFolder = new WorkspaceFolder("default");
  folders.add(defaultFolder);
  workspaces.add(new Workspace("workspace1", defaultFolder));
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
