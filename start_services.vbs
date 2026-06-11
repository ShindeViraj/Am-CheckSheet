Set WshShell = CreateObject("WScript.Shell")

' Set the working directory to the folder where this script is located
WshShell.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)

' Setup WMI to check running processes
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")

' Run the Python Flask application only if python is not already running
Set colPython = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'python.exe'")
If colPython.Count = 0 Then
    WshShell.Run "cmd /c python app.py", 0, False
End If

' Run Node-RED only if node is not already running
Set colNode = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'node.exe'")
If colNode.Count = 0 Then
    WshShell.Run "cmd /c node-red", 0, False
End If
