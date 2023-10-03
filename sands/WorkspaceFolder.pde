class WorkspaceFolder
{
  String folderName;
  ArrayList<WorkspaceFolder> folders = new ArrayList<WorkspaceFolder>();
  ArrayList<Workspace> workspaces = new ArrayList<Workspace>();

  WorkspaceFolder(String name)
  {
    folderName = name;
  }

  void AddWorkspace(Workspace ws)
  {
    workspaces.add(ws);
  }

  void PrintContent(int depth)
  {
    for (int i = 0; i < depth; i++)
    {
      print("  ");
    }
    print(folderName + "\n");
    for (int i = 0; i < folders.size(); i++)
    {
      folders.get(i).PrintContent(depth+1);
    }

    for (int i = 0; i < workspaces.size(); i++)
    {
      for (int j = 0; j < depth; j++)
      {
        print("  ");
      }
      print("  - " + workspaces.get(i).workspaceName + "\n");
    }
  }
}
