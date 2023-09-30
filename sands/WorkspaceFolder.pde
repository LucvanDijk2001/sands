class WorkspaceFolder
{
  String folderName;
  ArrayList<Workspace> workspaces = new ArrayList<Workspace>();

  WorkspaceFolder(String name)
  {
    folderName = name;
  }

  void AddWorkspace(Workspace ws)
  {
    workspaces.add(ws);
  }
}
