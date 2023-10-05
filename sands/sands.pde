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
  WorkspaceFolder defaultFolder = new WorkspaceFolder("1");
  WorkspaceFolder defaultFolder2 = new WorkspaceFolder("2");
  WorkspaceFolder defaultFolder3 = new WorkspaceFolder("3");
  WorkspaceFolder defaultFolder4 = new WorkspaceFolder("4");
  WorkspaceFolder defaultFolder5 = new WorkspaceFolder("5");
  WorkspaceFolder defaultFolder6 = new WorkspaceFolder("6");
  WorkspaceFolder defaultFolder7 = new WorkspaceFolder("7");
  WorkspaceFolder defaultFolder8 = new WorkspaceFolder("8");
  WorkspaceFolder defaultFolder9 = new WorkspaceFolder("9");
  WorkspaceFolder defaultFolder10 = new WorkspaceFolder("10");
  defaultFolder.folders.add(defaultFolder2);
  defaultFolder2.folders.add(defaultFolder3);
  defaultFolder3.folders.add(defaultFolder4);
  defaultFolder4.folders.add(defaultFolder5);
  defaultFolder5.folders.add(defaultFolder6);
  defaultFolder7.folders.add(defaultFolder8);
  defaultFolder8.folders.add(defaultFolder9);
  defaultFolder9.folders.add(defaultFolder10);
  
  folders.add(defaultFolder);
  folders.add(defaultFolder7);
  workspaces.add(new Workspace("workspace0", defaultFolder));
  workspaces.add(new Workspace("workspace1", defaultFolder2));
  workspaces.add(new Workspace("workspace2", defaultFolder3));
  workspaces.add(new Workspace("workspace3", defaultFolder4));
  workspaces.add(new Workspace("workspace4", defaultFolder5));
  workspaces.add(new Workspace("workspace5", defaultFolder6));
  workspaces.add(new Workspace("workspace6", defaultFolder6));
  workspaces.add(new Workspace("workspace7", defaultFolder6));
  workspaces.add(new Workspace("workspace8", defaultFolder6));
  workspaces.add(new Workspace("workspace9", defaultFolder7));
  workspaces.add(new Workspace("workspace10", defaultFolder8));
  workspaces.add(new Workspace("workspace11", defaultFolder9));
  workspaces.add(new Workspace("workspace12", defaultFolder9));
  workspaces.add(new Workspace("workspace13", defaultFolder10));
  workspaces.add(new Workspace("workspace14", defaultFolder10));
  workspaces.add(new Workspace("workspace15", defaultFolder10));
  workspaces.add(new Workspace("workspace16", defaultFolder10));
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
