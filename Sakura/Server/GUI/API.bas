Attribute VB_Name = "API"
Option Explicit

Public Declare Function GetTickCount Lib "kernel32" () As Long

Public Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long



Public Declare Function RegCloseKey Lib "advapi32.dll" (ByVal hKey As Long) As Long


Public Declare Function RegEnumValue Lib "advapi32.dll" Alias "RegEnumValueA" _
      (ByVal hKey As Long, _
      ByVal dwIndex As Long, _
      ByVal lpValueName As String, _
      lpcbValueName As Long, _
      ByVal lpReserved As Long, _
      lpType As Long, _
      lpData As Byte, _
      lpcbData As Long) As Long

Public Declare Function RegOpenKeyEx Lib "advapi32.dll" Alias "RegOpenKeyExA" _
      (ByVal hKey As Long, _
      ByVal lpSubKey As String, _
      ByVal ulOptions As Long, _
      ByVal samDesired As Long, _
      phkResult As Long) As Long
Public Declare Function RegOpenKey Lib "advapi32.dll" Alias "RegOpenKeyA" _
      (ByVal hKey As Long, _
      ByVal lpSubKey As String, _
      phkResult As Long) As Long


Public Const HKEY_LOCAL_MACHINE = &H80000002
Public Const REG_SZ = 1


Public Declare Function RegQueryValue Lib "advapi32.dll" Alias "RegQueryValueA" _
      (ByVal hKey As Long, _
      ByVal lpSubKey As String, _
      ByVal lpValue As String, _
      lpcbValue As Long) As Long
Public Declare Function RegQueryValueEx Lib "advapi32.dll" Alias "RegQueryValueExA" _
      (ByVal hKey As Long, _
      ByVal lpValueName As String, _
      ByVal lpReserved As Long, _
      lpType As Long, _
      lpData As Any, _
      lpcbData As Long) As Long         ' Note that if you declare the lpData parameter as String, you must pass it By Value.





Private Declare Function WriteSharedComm Lib "ShareDLL.dll" (ByVal CommPort As Integer, ByVal data As String, ByVal Length As Integer) As Integer
Private Declare Function ReadSharedComm Lib "ShareDLL.dll" (ByVal CommPort As Integer, ByVal data As String) As Integer

























Public Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)


