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
  hud.Update();
}

void MakeDefaultProject()
{
  WorkspaceFolder defaultFolder = new WorkspaceFolder("default");
  WorkspaceFolder defaultFolder2 = new WorkspaceFolder("defaultNested");
  WorkspaceFolder defaultFolder3 = new WorkspaceFolder("defaultNested");
  WorkspaceFolder defaultFolder4 = new WorkspaceFolder("defaultNested");
  WorkspaceFolder defaultFolder5 = new WorkspaceFolder("defaultNested");
  WorkspaceFolder defaultFolder6 = new WorkspaceFolder("defaultNested");
  defaultFolder.folders.add(defaultFolder2);
  defaultFolder2.folders.add(defaultFolder3);
  defaultFolder3.folders.add(defaultFolder4);
  defaultFolder4.folders.add(defaultFolder5);
  defaultFolder5.folders.add(defaultFolder6);
  folders.add(defaultFolder);
  workspaces.add(new Workspace("workspace0", defaultFolder));
  workspaces.add(new Workspace("workspace1", defaultFolder2));
  workspaces.add(new Workspace("workspace2", defaultFolder3));
  workspaces.add(new Workspace("workspace3", defaultFolder4));
  workspaces.add(new Workspace("workspace4", defaultFolder5));
  workspaces.add(new Workspace("workspace5", defaultFolder6));
  workspaces.add(new Workspace("workspace6", defaultFolder6));
  workspaces.add(new Workspace("workspace7", defaultFolder6));
  workspaces.add(new Workspace("workspace8", defaultFolder6));
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
