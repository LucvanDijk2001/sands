class Workspace
{
  //========================================VALUES==============================//
  float zoom = 1;
  String workspaceName = "workspace";
  WorkspaceFolder owner;
  MaskConversation connectedConversation;
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
    AddNode((int)random(-300,300), (int)random(-300,300), 200, 100, 20);
    AddNode((int)random(-300,300), (int)random(-300,300), 200, 60, 20);
    AddNode((int)random(-300,300), (int)random(-300,300), 240, 200, 20);
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

    //TEMP=======================================
    noFill();

    for (int i = 0; i < nodes.size()-1; i++)
    {
      strokeWeight(constrain(2/zoom, 1, 100));
      stroke(170, 80, 120);
      Node n1 = nodes.get(i);
      Node n2 = nodes.get(i+1);
      int amt = constrain((int)abs(n1.pos.x-n2.pos.x), 100, 1000000);
      float ydif = abs(n1.pos.y-n2.pos.y);
      ydif /= 500;
      amt *= constrain(ydif, 0, 1);
      bezier(n1.pos.x+n1.size.x, n1.pos.y, n1.pos.x+n1.size.x+amt, n1.pos.y, n2.pos.x-amt, n2.pos.y, n2.pos.x, n2.pos.y);

      if (debug)
      {
        strokeWeight(constrain(0.4/zoom, 0.2, 100));
        stroke(240, 200, 200);
        circle(n1.pos.x+n1.size.x, n1.pos.y, 10);
        circle(n1.pos.x+n1.size.x+amt, n1.pos.y, 10);
        circle(n2.pos.x-amt, n2.pos.y, 10);
        circle(n2.pos.x, n2.pos.y, 10);
        stroke(40, 200, 200);
        line(n1.pos.x+n1.size.x, n1.pos.y, n1.pos.x+n1.size.x+amt, n1.pos.y);
        line(n1.pos.x+n1.size.x+amt, n1.pos.y, n2.pos.x-amt, n2.pos.y);
        line(n2.pos.x-amt, n2.pos.y, n2.pos.x, n2.pos.y);
      }
    }

    strokeWeight(1);
    //TEMP=======================================
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
      strokeWeight(1.5);
    }
    if (zoom < 0.41)
    {
      gridsize = 80;
      strokeWeight(2);
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
    if (!globals.mouseOverMenu)
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
