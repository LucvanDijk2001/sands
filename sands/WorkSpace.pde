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
    AddNode(0,0,200,100,20);
    AddNode(0,0,300,500,40);
    AddNode(0,0,500,200,100);
  }

  //========================================MAIN==============================//
  void Update()
  {
    PositionScaleWorkspace();
    PanWorkspace();
    
    for(int i = nodes.size(); i > 0; i--)
    {
      Node cn = nodes.get(i-1);
      cn.Update();
    }
  }

  void Show()
  {
    DrawGrid();
    
    for(int i = 0; i < nodes.size(); i++)
    {
      Node cn = nodes.get(i);
      cn.Show();
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
  
  void AddNode(int x, int y, int w, int h, int bm)
  {
    nodes.add(new Node(x,y,w,h,bm,this));
  }
}
