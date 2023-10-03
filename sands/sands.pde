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
  WorkspaceFolder nestedFolder = new WorkspaceFolder("Nested");
  WorkspaceFolder nestedFolder2 = new WorkspaceFolder("Nested2");
  defaultFolder.folders.add(nestedFolder);
  nestedFolder.folders.add(nestedFolder2);
  folders.add(defaultFolder);
  
  for(int i = 0; i < 10; i++)
  {
   folders.add(new WorkspaceFolder("folder" + str(i))); 
  }
  workspaces.add(new Workspace("workspace1", nestedFolder2));
  workspaces.add(new Workspace("workspace2", defaultFolder));
  workspaces.add(new Workspace("workspace3", nestedFolder));
  workspaces.add(new Workspace("workspace4", nestedFolder));
  workspaces.add(new Workspace("workspace5", nestedFolder));
  workspaces.add(new Workspace("workspace6", folders.get(2)));
  workspaces.add(new Workspace("workspace7", folders.get(2)));
  workspaces.add(new Workspace("workspace8", folders.get(2)));
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
