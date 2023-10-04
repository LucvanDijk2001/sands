class HUDConExplorer extends HUDItem
{
  //needs
  //open/close folders
  //folder items
  //scrollbar based on amount of content vertically
  //vertical items probably need a set size to calculate scrollbar size
  //need some sort of mask
  //items need to be clickable and dragable?

  //make area in menu
  //put some content in area
  //make it so area has a vertical offset, masks anything outside of the area
  //make scrollbar for offset
  //make folder object
  //make folder item object

  //==================================================DATA================================
  //explorer window
  PVector size = new PVector(0, 0);
  boolean onWindow = false;
  boolean onExplorer = false;
  int explorerBarHeight = 30;
  MaskFolder currentInteractedFolder;
  MaskConversation currentInteractedConversation;

  //explorer bar
  HUDButton addFolderButton;
  HUDButton addConversationButton;

  //explorer area
  HUDSlider slider;
  int sliderWidth = 20;
  int contentSize = 0;
  int areaOffset = 0;
  int scrollSpeed = 15;
  int maxScroll = 0;

  //explorer graphic
  PGraphics mask;
  ArrayList<MaskGraphic> maskGraphics = new ArrayList<MaskGraphic>();

  SimpleMaskGraphic g1;
  SimpleMaskClickable g2;
  MaskToggable t1;
  MaskVFolderLayout layout;
  //==================================================CONSTRUCT================================
  HUDConExplorer(int x, int y, int w, int h, HUDMenu menu)
  {
    super(menu);
    pos.x = x;
    pos.y = y;
    size.x = w;
    size.y = h;
    mask = createGraphics((int)size.x-sliderWidth, (int)size.y-explorerBarHeight);

    //buttons
    addFolderButton       = new HUDButton((int)menu.pos.x, (int)(menu.pos.y+menu.barMargin), (int)menu.size.x/2-1, explorerBarHeight, "add folder", menu);
    addConversationButton = new HUDButton((int)menu.pos.x+(int)menu.size.x/2, (int)(menu.pos.y+menu.barMargin), (int)menu.size.x/2, explorerBarHeight, "add conversation", menu);
    slider                = new HUDSlider((int)menu.pos.x, (int)menu.pos.y+explorerBarHeight+(int)menu.barMargin, sliderWidth, (int)menu.size.y-explorerBarHeight-(int)menu.barMargin, menu);

    g1 = new SimpleMaskGraphic(0, 600, 100, 100, mask, this);
    g2 = new SimpleMaskClickable(0, 120, 100, 30, mask, this);
    t1 = new MaskToggable(100, 800, 20, 20, "masktoggle", true, mask, this);
    layout = new MaskVFolderLayout(0, 0, mask, this);

    for (int i = 0; i < folders.size(); i++)
    {
      MaskFolder folder = new MaskFolder(0, 100+i*100, 100, 20, folders.get(i), null, mask, this);
      RecurseCreateFolder(folders.get(i), folder);
      layout.AddItem(folder);
    }

    maskGraphics.add(layout);
    //maskGraphics.add(g2);
    //maskGraphics.add(t1);
  }

  void RecurseCreateFolder(WorkspaceFolder folder, MaskFolder maskFolder)
  {
    if (folder.folders.size() > 0)
    {
      for (int i = 0; i < folder.folders.size(); i++)
      {
        MaskFolder newMaskFolder = new MaskFolder(0, 0, 100, 20, folder.folders.get(i), maskFolder, mask, this);
        maskFolder.folders.add(newMaskFolder);
        RecurseCreateFolder(folder.folders.get(i), newMaskFolder);
      }
    }
  }
  //==================================================UPDATE================================
  void Show()
  {
    CheckOnWindow();
    CheckOnExplorer();
    fill(globals.HUDItemDentColor);
    stroke(globals.HUDStroke);
    rect(pos.x, pos.y, size.x, size.y);

    mask.beginDraw();
    mask.clear();

    for (int i = 0; i < maskGraphics.size(); i++)
    {
      maskGraphics.get(i).Show(areaOffset);
    }

    mask.endDraw();
    image(mask, menu.pos.x+sliderWidth, pos.y+explorerBarHeight);
    ShowButtons();
    slider.Show();
    slider.Update();
  }

  void Update()
  {
    if (addFolderButton.Released())
    {
      WorkspaceFolder newFolder = new WorkspaceFolder("folder" + folders.size());
      layout.AddItem(new MaskFolder(0, 0, 100, 20, newFolder, null, mask, this));
      folders.add(newFolder);
    }

    if (addConversationButton.Released())
    {
      Workspace newWorkspace = new Workspace("workspace" + workspaces.size(), folders.get(folders.size()-1));
      MaskConversation mc = new MaskConversation(0, 0, 100, 20, newWorkspace, folders.get(folders.size()-1).connectedFolder, mask, this);
      folders.get(folders.size()-1).connectedFolder.conversations.add(mc);
      workspaces.add(newWorkspace);
    }

    for (int i = 0; i < maskGraphics.size(); i++)
    {
      maskGraphics.get(i).Update();
    }

    maxScroll = (int)constrain((size.y-explorerBarHeight)-contentSize, -100000, 0);

    if (areaOffset  > 0 || areaOffset < maxScroll)
    {
      areaOffset = (int)constrain(areaOffset, maxScroll, 0);
      if (areaOffset < 0)
      {
        slider.UpdateHandlePosition((float)areaOffset/(float)maxScroll);
      } else
      {
        slider.handle.pos.y = slider.pos.y;
      }
    }

    CheckContentSize();
    slider.contentSize = contentSize;

    if (slider.HandleHeld())
    {
      areaOffset = (int)(maxScroll*slider.GetHandleScrollMargin());
    }
  }

  //==================================================FUNCTIONS================================
  void ScrollArea(int amount)
  {
    if (!slider.HandleHeld())
    {
      PVector mp = globals.GetMouseHudPos();
      if (mp.x > pos.x+sliderWidth && mp.x < pos.x+size.x && mp.y > pos.y && mp.y < pos.y+size.y)
      {
        areaOffset -= amount * scrollSpeed;
        areaOffset = (int)constrain(areaOffset, maxScroll, 0);
        if (areaOffset < 0)
        {
          slider.UpdateHandlePosition((float)areaOffset/(float)maxScroll);
        }
      }
    }
  }

  void CheckContentSize()
  {
    int maxy = 0;
    for (int i = 0; i < maskGraphics.size(); i++)
    {
      MaskGraphic mg = maskGraphics.get(i);
      if (mg.enabled)
      {
        float myReach = mg.pos.y+mg.size.y;
        if (myReach > maxy)
        {
          maxy = (int)myReach;
        }
      }
    }
    contentSize = maxy+ 50;
  }

  void ShowButtons()
  {
    addFolderButton.Show();
    addFolderButton.Update();
    addConversationButton.Show();
    addConversationButton.Update();
  }

  void CheckOnWindow()
  {
    onWindow = false;
    PVector mousePos = globals.GetMouseHudPos();
    if (mousePos.x > pos.x && mousePos.x < pos.x+size.x && mousePos.y > pos.y && mousePos.y < pos.y + size.y)
    {
      onWindow = true;
    }
  }
  void CheckOnExplorer()
  {
    onExplorer = false;
    PVector mousePos = globals.GetMouseHudPos();
    if (mousePos.x > pos.x && mousePos.x < pos.x+size.x && mousePos.y > pos.y+explorerBarHeight && mousePos.y < pos.y + size.y)
    {
      onExplorer = true;
    }
  }
}

//==================================================CLASSES================================
class MaskGraphic
{
  PGraphics mask;
  boolean enabled = true;
  PVector pos = new PVector(0, 0);
  PVector size = new PVector(0, 0);
  HUDConExplorer owner;
  MaskGraphic(int _x, int _y, int _w, int _h, PGraphics _mask, HUDConExplorer _owner)
  {
    pos.x = _x;
    pos.y = _y;
    size.x = _w;
    size.y = _h;
    mask = _mask;
    owner = _owner;
  }

  void Show(int offset) {
  };
  void Update() {
  };
}

class MaskVFolderLayout extends MaskGraphic
{
  ArrayList<MaskFolder> items = new ArrayList<MaskFolder>();
  MaskVFolderLayout(int _x, int _y, PGraphics _mask, HUDConExplorer _owner)
  {
    super(_x, _y, 0, 0, _mask, _owner);
  }

  void Show(int offset)
  {
    for (int i = 0; i < items.size(); i++)
    {
      if (items.get(i) != owner.currentInteractedFolder)
      {
        items.get(i).Show(offset);
      }
    }

    if (owner.currentInteractedFolder != null)
    {
      owner.currentInteractedFolder.Show(offset);
    }

    if (owner.currentInteractedConversation != null)
    {
      owner.currentInteractedConversation.Show(offset);
    }
  }

  void Update()
  {
    int newPos=0;
    for (int i = 0; i < items.size(); i++)
    {
      items.get(i).Update();
      if (!items.get(i).held)
      {
        items.get(i).pos.x = pos.x;
        items.get(i).pos.y = pos.y + newPos;
        newPos += items.get(i).CalculateSize();
      }
    }
    size.y = newPos;
  }

  void AddItem(MaskFolder item)
  {
    items.add(item);
  }
}

class MaskFolder extends MaskClickable
{
  WorkspaceFolder connectedFolder;
  MaskFolderButton button;
  MaskFolder parent = null;
  ArrayList<MaskFolder> folders = new ArrayList<MaskFolder>();
  ArrayList<MaskConversation> conversations = new ArrayList<MaskConversation>();
  String folderName = "folder";
  int sizeY = 0;
  boolean open = false;
  boolean drag = false;
  PVector pressedMouseOffset = new PVector(0, 0);
  PVector pressedMouseStart = new PVector(0, 0);

  MaskFolder(int _x, int _y, int _w, int _h, WorkspaceFolder _folder, MaskFolder _parent, PGraphics _mask, HUDConExplorer _owner)
  {
    super(_x, _y, _w, _h, _mask, _owner); 
    SetHoverEnabled(false);
    parent = _parent;
    connectedFolder = _folder;
    folderName = _folder.folderName;
    _folder.connectedFolder = this;
    button = new MaskFolderButton(_x, _y, _h, _h, _mask, _owner);
    SetClickMarginLeft((int)button.size.x);

    for (int i = 0; i < connectedFolder.workspaces.size(); i++)
    {
      conversations.add(new MaskConversation(0, 0, 100, 20, connectedFolder.workspaces.get(i), this, mask, owner));
    }
  }

  void Show(int offset)
  {
    super.Show(offset);
    if (open)
    {
      PVector itemPos = new PVector(pos.x+20, pos.y+size.y);
      for (int i = 0; i < folders.size(); i++)
      {
        MaskFolder folder = folders.get(i);
        if (!folder.drag)
        {
          folder.pos.x = itemPos.x;
          folder.pos.y = itemPos.y;
          itemPos.y += folder.CalculateSize();
        }

        if (folder != owner.currentInteractedFolder)
        {
          folder.Show(offset);
        }
      }

      for (int i = 0; i < conversations.size(); i++)
      {
        MaskConversation conversation = conversations.get(i);
        if (!conversation.drag)
        {
          conversation.pos.x = itemPos.x;
          conversation.pos.y = itemPos.y;
          itemPos.y += conversation.size.y;
        }

        if (conversation != owner.currentInteractedConversation)
        {
          conversation.Show(offset);
        }
      }
    }
    mask.textAlign(LEFT, CENTER);
    mask.text(folderName, pos.x+button.size.x+5, pos.y+size.y/2+offset);
    button.Show(offset);
  }

  void Update()
  {
    size.x = mask.width-pos.x;
    if (owner.onExplorer)
    {
      super.Update();
    } else
    {
      hover = false;
    }
    if (open)
    {
      for (int i = 0; i < folders.size(); i++)
      {
        folders.get(i).Update();
      }

      for (int i = 0; i < conversations.size(); i++)
      {
        conversations.get(i).Update();
      }
    }

    if (Pressed())
    {
      pressedMouseOffset = globals.GetMouseHudPos(-(int)(owner.pos.x+owner.sliderWidth), -(int)(owner.pos.y+owner.explorerBarHeight));
      pressedMouseStart = globals.GetMouseHudPos(-(int)(owner.pos.x+owner.sliderWidth), -(int)(owner.pos.y+owner.explorerBarHeight));
      pressedMouseOffset.x -= pos.x;
      pressedMouseOffset.y -= pos.y;
      owner.currentInteractedFolder = this;
    }

    if (drag)
    {
      PVector mp = globals.GetMouseHudPos(-(int)(owner.pos.x+owner.sliderWidth), -(int)(owner.pos.y+owner.explorerBarHeight));
      pos.x = mp.x - pressedMouseOffset.x;
      pos.y = mp.y - pressedMouseOffset.y;
    }

    if (Released())
    {      
      drag = false;
      if (owner.currentInteractedFolder == this)
      {
        owner.currentInteractedFolder = null;
      }
    }

    if (Held())
    {
      PVector mp = globals.GetMouseHudPos(-(int)(owner.pos.x+owner.sliderWidth), -(int)(owner.pos.y+owner.explorerBarHeight));
      PVector dragDif = PVector.sub(pressedMouseStart, mp);
      if (dragDif.mag() > 15)
      {
        drag = Held();
        owner.currentInteractedFolder = this;
      }
    }

    if (!drag)
    {
      open = button.toggled;
      button.Update();
    }
    else
    {
      open = false; 
    }
    button.pos.x = pos.x;
    button.pos.y = pos.y;
  }

  int CalculateSize()
  {
    int totalY = (int)size.y;
    if (open)
    {
      for (int i = 0; i < folders.size(); i++)
      {
        if (folders.get(i) != owner.currentInteractedFolder)
        {
          totalY += folders.get(i).CalculateSize();
        }
      }
      for (int i = 0; i < conversations.size(); i++)
      {
        if (conversations.get(i) != owner.currentInteractedConversation)
        {
          totalY += conversations.get(i).size.y;
        }
      }
    }
    return totalY;
  }
}

class MaskFolderButton extends MaskToggable
{
  MaskFolderButton(int _x, int _y, int _w, int _h, PGraphics _mask, HUDConExplorer _owner)
  {
    super(_x, _y, _w, _h, "", _mask, _owner); 
    SetOnText("V"); 
    SetOffText(">");
  }

  void Update()
  {
    if (owner.onExplorer)
    {
      super.Update();
    } else
    {
      hover = false;
    }
  }
}

class MaskConversation extends MaskClickable
{
  Workspace connectedWorkspace;
  MaskFolder connectedFolder;
  String name = "ws";
  boolean drag = false;
  PVector pressedMouseOffset = new PVector(0, 0);
  PVector pressedMouseStart = new PVector(0, 0);

  MaskConversation (int _x, int _y, int _w, int _h, Workspace ws, MaskFolder _connectedFolder, PGraphics _mask, HUDConExplorer _owner)
  {
    super(_x, _y, _w, _h, _mask, _owner);
    connectedFolder = _connectedFolder;
    connectedWorkspace = ws;
    name = ws.workspaceName;
    ws.connectedConversation = this;
    SetItemColor(globals.MaskConversationColor);
    SetItemHeldColor(globals.MaskConversationHeldColor);
  }

  void Show(int offset)
  {
    super.Show(offset);
    mask.textAlign(LEFT, CENTER);
    mask.text(name, pos.x+5, pos.y+size.y/2+offset);
  }

  void Update()
  {
    if (owner.onExplorer)
    {
      super.Update();
    } else
    {
      hover = false;
    }
    size.x = mask.width-pos.x;
    if (Released())
    {
      if (!drag)
      {
        currentWorkspace = connectedWorkspace;
      } else
      {
        drag = false;
      }

      if (owner.currentInteractedConversation == this)
      {
        owner.currentInteractedConversation = null;
      }
    }

    if (Pressed())
    {
      pressedMouseOffset = globals.GetMouseHudPos(-(int)(owner.pos.x+owner.sliderWidth), -(int)(owner.pos.y+owner.explorerBarHeight));
      pressedMouseStart = globals.GetMouseHudPos(-(int)(owner.pos.x+owner.sliderWidth), -(int)(owner.pos.y+owner.explorerBarHeight));
      pressedMouseOffset.x -= pos.x;
      pressedMouseOffset.y -= pos.y;
    }
    if (Held())
    {
      PVector mp = globals.GetMouseHudPos(-(int)(owner.pos.x+owner.sliderWidth), -(int)(owner.pos.y+owner.explorerBarHeight));
      PVector dragDif = PVector.sub(pressedMouseStart, mp);
      if (dragDif.mag() > 15)
      {
        drag = Held();
        owner.currentInteractedConversation = this;
      }
    }

    if (drag)
    {
      PVector mp = globals.GetMouseHudPos(-(int)(owner.pos.x+owner.sliderWidth), -(int)(owner.pos.y+owner.explorerBarHeight));
      pos.x = mp.x - pressedMouseOffset.x;
      pos.y = mp.y - pressedMouseOffset.y;
    }
  }
}

class SimpleMaskGraphic extends MaskGraphic
{
  SimpleMaskGraphic(int _x, int _y, int _w, int _h, PGraphics _mask, HUDConExplorer _owner)
  {
    super(_x, _y, _w, _h, _mask, _owner);
  }

  void Show(int offset)
  {
    mask.rect(pos.x, pos.y+offset, size.x, size.y);
  }
}

class SimpleMaskClickable extends MaskClickable
{
  SimpleMaskClickable(int _x, int _y, int _w, int _h, PGraphics _mask, HUDConExplorer _owner)
  {
    super(_x, _y, _w, _h, _mask, _owner);
  }

  void Show(int offset)
  {
    super.Show(offset);
  }

  void Update()
  {
    super.Update();
  }
}
