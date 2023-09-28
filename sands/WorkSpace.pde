class Workspace
{
  //========================================VALUES==============================//
  float zoom = 1;
  PVector windowPos= new PVector(0, 0);

  ArrayList<Node> nodes;

  //========================================INIT==============================//
  Workspace()
  {
    nodes = new ArrayList<Node>();
    nodes.add(new Node(200,100,20));
    nodes.add(new Node(300,500,40));
    nodes.add(new Node(500,200,100));
    windowPos.x = width/2;
    windowPos.y = height/2;
  }

  //========================================MAIN==============================//
  void Update()
  {
    PositionScaleWorkspace();
    PanWorkspace();
  }

  void Show()
  {
    DrawGrid();
    for(int i = 0; i < nodes.size(); i++)
    {
      Node cn = nodes.get(i);
      cn.Show();
      cn.Update();
    }
  }

  //========================================FUNCTIONS==============================//
  void DrawGrid()
  {
    int xmargin = 2;
    int ymargin = 2;
    float xmg = width/2/zoom;
    float ymg = height/2/zoom;
    float xleft = xmg%200;
    float yleft = ymg%200;
    int xoff = int(xmg-xleft);
    int yoff = int(ymg-yleft);
    int xstart = (int)(-(windowPos.x /*+ (width/2/zoom)*/) + (windowPos.x%200) - (200*xmargin)) - xoff;
    int ystart = (int)(-(windowPos.y /*+ (height/2/zoom)*/) + (windowPos.y%200) - (200*ymargin)) - yoff;
    //int xstart = -(int)((windowPos.x) / zoom) - (200*xmargin) + (int)(windowPos.x / zoom % 200);
    //int ystart = -(int)((windowPos.y) / zoom) - (200*ymargin) + (int)(windowPos.y / zoom % 200);
    int xiter = ceil(width/(200*zoom)) + (xmargin*2);
    int yiter = ceil(height/(200*zoom)) + (ymargin*2);
    for (int x = 0; x < xiter; x++)
    {
      for (int y = 0; y < yiter; y++)
      {
        image(globals.workspaceBackground, xstart+200*x, ystart+200*y);
      }
    }
}

  void PositionScaleWorkspace()
  {
    translate(width/2,height/2);
    scale(zoom);
    translate(windowPos.x, windowPos.y);
  }

  void PanWorkspace()
  {
    if (mousePressed)
    {
      if (mouseButton == RIGHT)
      {
        windowPos.x -= (pmouseX-mouseX)*(1/zoom);
        windowPos.y -= (pmouseY-mouseY)*(1/zoom);
      }
    }
  }

  void ZoomWorkspace(float change)
  {
    zoom -= change*0.1;
    zoom = constrain(zoom, 0.3, 5);
  }
  
  void AddNode(int w, int h, int bm)
  {
    nodes.add(new Node(w,h,bm));
  }
}
