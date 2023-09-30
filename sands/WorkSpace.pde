class Workspace
{
  //========================================VALUES==============================//
  float zoom = 1;
  String workspaceName = "workspace";
  WorkspaceFolder owner;
  PVector windowPos= new PVector(0, 0);
  int gridsize = 20;

  int bgDrawCalls = 0;

  ArrayList<Node> nodes;

  //========================================INIT==============================//
  Workspace(String name, WorkspaceFolder folder)
  {
    owner = folder;
    workspaceName = name;
    owner.AddWorkspace(this);
    nodes = new ArrayList<Node>();
    AddNode(0, 0, 200, 100, 20);
    AddNode(0, 0, 200, 60, 20);
    AddNode(0, 0, 240, 200, 20);
  }

  //========================================MAIN==============================//
  void Update()
  {
    PositionScaleWorkspace();
    PanWorkspace();

    for (int i = nodes.size(); i > 0; i--)
    {
      Node cn = nodes.get(i-1);
      cn.Update();
    }
  }

  void Show()
  {
    DrawGrid();
    strokeWeight(1);
    for (int i = 0; i < nodes.size(); i++)
    {
      Node cn = nodes.get(i);
      cn.Show();
    }
  }

  //========================================FUNCTIONS==============================//
  void DrawGrid()
  {
    gridsize = 20;
    strokeWeight(1);
    if (zoom > 2.99)
    {
      strokeWeight(0.5);
      gridsize = 10;
    }
    if (zoom < 0.71)
    {
      gridsize = 40;
      strokeWeight(2);
    }
    if (zoom < 0.41)
    {
      gridsize = 80;
      strokeWeight(4);
    }
    stroke(0, 0, 70);
    fill(0, 0, 36);
    int xmargin = 2;
    int ymargin = 2;
    float xmg = width/2/zoom;
    float ymg = height/2/zoom;
    float xleft = xmg%gridsize;
    float yleft = ymg%gridsize;
    int xoff = int(xmg-xleft);
    int yoff = int(ymg-yleft);
    int xstart = (int)(-(windowPos.x) + (windowPos.x%gridsize) - (gridsize*xmargin)) - xoff;
    int ystart = (int)(-(windowPos.y) + (windowPos.y%gridsize) - (gridsize*ymargin)) - yoff;

    //int xstart = -(int)((windowPos.x) / zoom) - (200*xmargin) + (int)(windowPos.x / zoom % 200);
    //int ystart = -(int)((windowPos.y) / zoom) - (200*ymargin) + (int)(windowPos.y / zoom % 200);
    int xiter = ceil((width)/(gridsize*zoom)) + (xmargin*2);
    int yiter = ceil(height/(gridsize*zoom)) + (ymargin*2);
    bgDrawCalls = 0;
    for (int x = 0; x < xiter; x++)
    {
      for (int y = 0; y < yiter; y++)
      {
        bgDrawCalls ++;
        rect(xstart+gridsize*x, ystart+gridsize*y, gridsize, gridsize);
        //image(globals.workspaceBackground, xstart+gridsize*x, ystart+gridsize*y);
      }
    }
  }

  void PositionScaleWorkspace()
  {
    translate(width/2, height/2);
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
    nodes.add(new Node(x, y, w, h, bm, this));
  }
}
