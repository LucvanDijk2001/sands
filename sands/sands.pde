Workspace currentWorkspace;
Globals globals;
HUD hud;


Workspace tempWorkspace;


void setup()
{
   fullScreen(P2D, 1);
   smooth(2);
   colorMode(HSB);
   tempWorkspace = new Workspace();/////temp/////
   currentWorkspace = tempWorkspace;
   globals = new Globals();
   hud = new HUD();
   textAlign(LEFT,CENTER);
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
  currentWorkspace.ZoomWorkspace(event.getCount());
}
