VERSION 5.00
Begin VB.UserControl Channel 
   Appearance      =   0  'Flat
   BackColor       =   &H00FFFFC0&
   ClientHeight    =   3600
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4800
   HasDC           =   0   'False
   InvisibleAtRuntime=   -1  'True
   ScaleHeight     =   3600
   ScaleWidth      =   4800
   Begin VB.Timer Timer1 
      Interval        =   10
      Left            =   2445
      Top             =   990
   End
End
Attribute VB_Name = "Channel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Private Declare Function WriteSharedComm Lib "ShareDLL.dll" (ByVal CommPort As Integer, ByVal data As String, ByVal length As Integer) As Integer
Private Declare Function ReadSharedComm Lib "ShareDLL.dll" (ByVal CommPort As Integer, ByVal data As String) As Integer



Event DataArrival(data As String)

Public m_Channel As Integer



Public Function SendDataToChannel(data As String) As Long

On Error Resume Next

Dim path As String
Dim fp As Integer

path = "channel.config"


If Dir(path) <> "" Then

    fp = FreeFile
    path = ""
    Open "channel.config" For Input As #fp
    Line Input #fp, path
    Close #fp
    
    m_Channel = Val(Trim(path))

Else
    m_Channel = 0
End If

If m_Channel = 0 Then
    SendDataToChannel = 0
    Exit Function
End If

fp = WriteSharedComm(m_Channel, data, Len(data))

    
SendDataToChannel = fp


End Function

Private Sub Timer1_Timer()

Dim str As String
Dim i As Integer
Dim path As String
Dim fp As Integer

path = "channel.config"


If Dir(path) <> "" Then

    fp = FreeFile
    path = ""
    Open "channel.config" For Input As #fp
    Line Input #fp, path
    Close #fp
    
    i = Val(Trim(path))

Else
    i = 0
End If


m_Channel = i

str = String(1025, " ")
i = ReadSharedComm(m_Channel, str)
'MsgBox str

If i > 0 Then
    RaiseEvent DataArrival(str)
    WriteSharedComm m_Channel, "", 0
End If


End Sub









Private Sub Timer2_Timer()

End Sub

Private Sub UserControl_Initialize()

Dim path As String
Dim fp As Integer

path = "channel.config"


If Dir(path) <> "" Then

    fp = FreeFile
    path = ""
    Open "channel.config" For Input As #fp
    Line Input #fp, path
    Close #fp
    
    m_Channel = Val(Trim(path))

Else
    m_Channel = 0
End If

End Sub
