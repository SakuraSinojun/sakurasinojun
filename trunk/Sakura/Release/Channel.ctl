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
      Left            =   1830
      Top             =   300
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
Event DataArrival(data As String)




'变量
Private Const m_MapFile = "{A2EE168A-E017-478d-9630-721F32B557B0}"
Private m_MapHandle As Long
Private m_lFilePtr As Long

Private m_Maker As String
Private m_ReadMaker As String


'读取当前程序所用通道
'通道号存于App.Path 下的"channel.config"文件中

Private Function ReadChannel() As Integer


Dim msg As String
Dim fp As Integer


If Dir("channel.config") <> "" Then
    fp = FreeFile
    msg = ""
    Open "channel.config" For Input As #fp
    Line Input #fp, msg
    Close #fp
    ReadChannel = Val(Trim(msg))
Else
    ReadChannel = 0
End If



End Function


Public Function SendDataToChannel(data As String) As Long

Dim szCont As String

szCont = m_Maker
szCont = szCont & String(100 - Len(m_Maker), " ")
szCont = szCont & data

lstrcpyS2L m_lFilePtr, ByVal szCont

End Function


Public Sub SetMaker(maker As String)

If Len(maker) > 100 Then maker = Left(maker, 100)

m_Maker = maker

End Sub


Public Function ReadMaker()

    ReadMaker = m_ReadMaker
    
End Function


Private Sub Timer1_Timer()

Dim i As Integer
Dim szCont As String * 1024
szCont = String(1024, " ")

lstrcpyL2S ByVal szCont, m_lFilePtr

szCont = Trim(szCont)

i = lstrlen(szCont)

If i >= 100 Then
    m_ReadMaker = Left(szCont, 100)
    m_ReadMaker = Trim(m_ReadMaker)
ElseIf i >= 1 Then
    m_ReadMaker = Trim(szCont)
End If

If m_ReadMaker <> m_Maker Then Exit Sub

If i >= 101 Then
    RaiseEvent DataArrival(Mid(szCont, 101))
End If

lstrcpyS2L m_lFilePtr, ByVal m_Maker

End Sub





Private Sub UserControl_Initialize()

Dim i As Integer

Dim Security As SECURITY_ATTRIBUTES

Dim path As String

Timer1.Enabled = False


m_ReadMaker = "NONMAKER"

i = ReadChannel

If i = 0 Then Exit Sub

path = m_MapFile & Trim(Str(i))


With Security
    .bInheritHandle = 1
    .lpSecurityDescriptor = 0
    .nLength = Len(Security)
End With

m_MapHandle = OpenFileMapping(FILE_MAP_ALL_ACCESS, PAGE_READWRITE, path)

If m_MapHandle = 0 Then
    
    m_MapHandle = CreateFileMapping(&HFFFFFFFF, Security, PAGE_READWRITE, 0, 1024, path)
    If m_MapHandle = 0 Then
        Exit Sub
    End If

End If

m_lFilePtr = MapViewOfFile(m_MapHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0)

CloseHandle m_MapHandle

Timer1.Enabled = True

End Sub

Private Sub UserControl_Resize()

Width = 2580 / 2
Height = 2580 / 4

End Sub
