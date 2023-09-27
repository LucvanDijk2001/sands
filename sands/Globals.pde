class Globals
{
  PImage workspaceBackground;

  float nmx;
  float nmy;
  float pnmx;
  float pnmy;

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
  }
  
  PVector GetMousePos()
  {
   return new PVector(nmx,nmy); 
  }
  
  PVector GetPrevMousePos()
  {
   return new PVector(pnmx,pnmy); 
  }
  
  PVector GetMouseHudPos()
  {
     return new PVector(mouseX,mouseY); 
  }
  
  PVector GetPrevMouseHudPos()
  {
    return new PVector(pmouseX,pmouseY);
  }  
  
  boolean IsShift()
  {
     if(keyPressed)
     {
        if(keyCode == SHIFT)
        {
         return true; 
        }
     }
     return false;
  }
}
