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
}
