class HUD
{
  void Show()
  {
    fill(55);
    rect(0,0,200,500); 
    fill(255);
    text("workspace position x: " + round(currentWorkspace.windowPos.x * -1),10,10);
    text("workspace position y: " + round(currentWorkspace.windowPos.y * -1),10,25);
    text("workspace zoom: " + nf(currentWorkspace.zoom,0,1),10,50);
  }
}
