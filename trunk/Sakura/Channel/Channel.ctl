VERSION 5.00
Begin VB.UserControl Channel 
   Appearance      =   0  'Flat
   BackColor       =   &H00FFFFC0&
   ClientHeight    =   1695
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   2580
   HasDC           =   0   'False
   InvisibleAtRuntime=   -1  'True
   ScaleHeight     =   1695
   ScaleWidth      =   2580
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   10
      Left            =   1725
      Top             =   630
   End
End
Attribute VB_Name = "Channel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

'用到的API.及常数.

Private Type SECURITY_ATTRIBUTES
        nLength As Long
        lpSecurityDescriptor As Long
        bInheritHandle As Long
End Type

Private Declare Function CreateFileMapping Lib "kernel32" Alias "CreateFileMappingA" (ByVal hFile As Long, lpFileMappigAttributes As SECURITY_ATTRIBUTES, ByVal flProtect As Long, ByVal dwMaximumSizeHigh As Long, ByVal dwMaximumSizeLow As Long, ByVal lpName As String) As Long
Private Declare Function OpenFileMapping Lib "kernel32" Alias "OpenFileMappingA" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal lpName As String) As Long
Private Declare Function MapViewOfFile Lib "kernel32" (ByVal hFileMappingObject As Long, ByVal dwDesiredAccess As Long, ByVal dwFileOffsetHigh As Long, ByVal dwFileOffsetLow As Long, ByVal dwNumberOfBytesToMap As Long) As Long
Private Declare Function UnmapViewOfFile Lib "kernel32" (lpBaseAddress As Any) As Long
Private Declare Function GetLastError Lib "kernel32" () As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Private Declare Function lstrcpyL2S Lib "kernel32" Alias "lstrcpyA" (ByVal lpString1 As String, ByVal lpString2 As Long) As Long
Private Declare Function lstrcpyS2L Lib "kernel32" Alias "lstrcpyA" (ByVal lpString1 As Long, ByVal lpString2 As String) As Long
Private Declare Function lstrcpy Lib "kernel32" Alias "lstrcpyA" (ByVal lpString1 As String, ByVal lpString2 As String) As Long
Private Declare Function lstrlen Lib "kernel32" Alias "lstrlenA" (ByVal lpString As String) As Long

Private Const PAGE_NOACCESS = &H1
Private Const PAGE_READONLY = &H2
Private Const PAGE_READWRITE = &H4
Private Const PAGE_WRITECOPY = &H8
Private Const PAGE_EXECUTE = &H10
Private Const PAGE_EXECUTE_READ = &H20
Private Const PAGE_EXECUTE_READWRITE = &H40
Private Const PAGE_EXECUTE_WRITECOPY = &H80
Private Const PAGE_GUARD = &H100
Private Const PAGE_NOCACHE = &H200
Private Const PAGE_WRITECOMBINE = &H400
Private Const STANDARD_RIGHTS_REQUIRED = &HF0000

Private Const SECTION_EXTEND_SIZE = &H10
Private Const SECTION_MAP_EXECUTE = &H8
Private Const SECTION_MAP_READ = &H4
Private Const SECTION_MAP_WRITE = &H2
Private Const SECTION_QUERY = &H1
Private Const SECTION_ALL_ACCESS = STANDARD_RIGHTS_REQUIRED Or SECTION_QUERY Or SECTION_MAP_WRITE Or SECTION_MAP_READ Or SECTION_MAP_EXECUTE Or SECTION_EXTEND_SIZE

Private Const FILE_MAP_ALL_ACCESS = SECTION_ALL_ACCESS
Private Const FILE_MAP_COPY = SECTION_QUERY
Private Const FILE_MAP_READ = SECTION_MAP_READ
Private Const FILE_MAP_WRITE = SECTION_MAP_WRITE




'事件
Event DataArrival(data As Long)
Event DataArrivalS(data As String)



'变量
Private Const m_MapFile = "{A2EE168A-E017-478d-9630-721F32B557B0}"
Private m_MapHandle As Long
Private m_RMapHandle As Long

Private m_lFilePtr As Long
Private m_lRFilePtr As Long

Private m_Channel As Integer
Private m_RChannel As Integer

Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal length As Long)
Private Declare Sub ZeroMemory Lib "kernel32" Alias "RtlZeroMemory" (ByVal dest As Long, ByVal numBytes As Long)

Private Declare Function lstrlenL Lib "kernel32" Alias "lstrlenA" (ByVal lpString As Long) As Long







'读取当前程序所用通道
'通道号存于App.Path 下的"channel.conf"文件中

Private Function ReadChannel() As Integer

Dim msg As String
Dim pIniFile As New clsTIniFile

pIniFile.Initialize App.path & "\channel.config"

msg = pIniFile.ReadString("CHANNEL", "SendChannel", "0")

m_Channel = Val(msg)

msg = pIniFile.ReadString("CHANNEL", "RecvChannel", "0")

m_RChannel = Val(msg)


End Function



Public Function SendDataToChannel(ByVal data As Long, ByVal length As Long) As Long

'lstrcpyS2L m_lFilePtr, ByVal data
      
      Dim l As Long
      
      l = length
      
      CopyMemory ByVal m_lFilePtr, ByVal VarPtr(l), 4
      CopyMemory ByVal (m_lFilePtr + 4), ByVal data, ByVal length

End Function


Public Function SendDataToChannelS(data As String) As Long

lstrcpyS2L m_lFilePtr, ByVal data

End Function




Private Sub Timer1_Timer()

Dim i As Integer
Dim szCont As String * 1024
szCont = String(1024, " ")

Dim bCont(1024) As Byte
ZeroMemory ByVal VarPtr(bCont(0)), ByVal 1024


CopyMemory bCont(0), m_lRFilePtr, 1024

lstrcpyL2S ByVal szCont, m_lRFilePtr
szCont = Trim(szCont)

i = lstrlen(szCont)

If i >= 1 Then
    RaiseEvent DataArrivalS(Trim(Left(szCont, i - 1)))
    'lstrcpyS2L m_lRFilePtr, ""
End If

If lstrlenL(ByVal VarPtr(bCont(0))) > 0 Then
    RaiseEvent DataArrival(VarPtr(bCont(0)))
    'lstrcpyS2L m_lRFilePtr, ""
End If



End Sub


Public Sub ClearR()
      ZeroMemory m_lRFilePtr, 1024
      
End Sub

Private Sub UserControl_Initialize()

Dim i As Integer

Dim Security As SECURITY_ATTRIBUTES

Dim path As String

Timer1.Enabled = False


With Security
    .bInheritHandle = 1
    .lpSecurityDescriptor = 0
    .nLength = Len(Security)
End With


ReadChannel

'初始化共享文件
      '发送信道
      If m_Channel = 0 Then GoTo inti2
      path = m_MapFile & "S" & Trim(Str(m_Channel))
      m_MapHandle = OpenFileMapping(FILE_MAP_ALL_ACCESS, PAGE_READWRITE, path)
      If m_MapHandle = 0 Then
          m_MapHandle = CreateFileMapping(&HFFFFFFFF, Security, PAGE_READWRITE, 0, 1024, path)
          If m_MapHandle = 0 Then
              Exit Sub
          End If
      End If
      m_lFilePtr = MapViewOfFile(m_MapHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0)
      'CloseHandle m_MapHandle
      
inti2:

      '接收信道
      If m_RChannel = 0 Then Exit Sub
      path = m_MapFile & "R" & Trim(Str(m_RChannel))
      m_RMapHandle = OpenFileMapping(FILE_MAP_ALL_ACCESS, PAGE_READWRITE, path)
      If m_RMapHandle = 0 Then
          m_RMapHandle = CreateFileMapping(&HFFFFFFFF, Security, PAGE_READWRITE, 0, 1024, path)
          If m_RMapHandle = 0 Then
              Exit Sub
          End If
      End If
      m_lRFilePtr = MapViewOfFile(m_RMapHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0)
      'CloseHandle m_RMapHandle
      
Timer1.Enabled = True

End Sub

Private Sub UserControl_Resize()

Width = 2580 / 2
Height = 2580 / 4

End Sub
