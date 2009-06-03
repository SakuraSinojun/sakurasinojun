Attribute VB_Name = "Module1"
Option Explicit

Public Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)


Public Declare Sub ZeroMemory Lib "kernel32" Alias "RtlZeroMemory" (dest As Any, ByVal numBytes As Long)


Public Declare Function lstrcpy Lib "kernel32" Alias "lstrcpyA" (ByVal lpString1 As String, ByVal lpString2 As String) As Long

Public Declare Function lstrcpyn Lib "kernel32" Alias "lstrcpynA" (ByVal lpString1 As String, ByVal lpString2 As String, ByVal iMaxLength As Long) As Long


Public Declare Function lstrcpyL2S Lib "kernel32" Alias "lstrcpyA" (ByVal lpString1 As String, ByVal lpString2 As Long) As Long
Public Declare Function lstrcpyS2L Lib "kernel32" Alias "lstrcpyA" (ByVal lpString1 As Long, ByVal lpString2 As String) As Long
Public Declare Function lstrcpyL2L Lib "kernel32" Alias "lstrcpyA" (ByVal lpString1 As Long, ByVal lpString2 As Long) As Long


Public Declare Function lstrcmp Lib "kernel32" Alias "lstrcmpA" (ByVal lpString1 As Long, ByVal lpString2 As Long) As Long

Public Declare Function lstrlen Lib "kernel32" Alias "lstrlenA" (ByVal lpString As String) As Long

Public Declare Function lstrlenL Lib "kernel32" Alias "lstrlenA" (ByVal lpString As Long) As Long

Public Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Public Const HWND_TOPMOST = -1
Public Const SWP_NOSIZE = &H1
Public Const SWP_NOMOVE = &H2

