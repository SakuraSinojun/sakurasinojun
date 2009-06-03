VERSION 5.00
Begin VB.Form frmChild 
   BackColor       =   &H80000007&
   BorderStyle     =   0  'None
   Caption         =   " 启动器"
   ClientHeight    =   480
   ClientLeft      =   0
   ClientTop       =   -30
   ClientWidth     =   2835
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   480
   ScaleWidth      =   2835
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  '窗口缺省
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   495
      Index           =   0
      Left            =   360
      MaskColor       =   &H0000FFFF&
      TabIndex        =   0
      Top             =   0
      UseMaskColor    =   -1  'True
      Width           =   2055
   End
End
Attribute VB_Name = "frmChild"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim FileName(100) As String

Private Sub Command1_Click(Index As Integer)
Shell FileName(Index), vbNormalFocus
End Sub

Private Sub Form_Load()


Dim fp As Integer

If Dir(App.Path & "\AppList.txt") = "" Then
    'MsgBox "AppList.txt文件不存在!"
    'Exit Sub
    
    fp = FreeFile
    Open App.Path & "\AppList.txt" For Output As #fp
    Close fp
    
End If

Open App.Path & "\AppList.txt" For Input As #1

Dim i As Long
Dim temp As String
Dim tmp() As String
ReDim tmp(1) As String
i = 0
While (Not EOF(1))
    Line Input #1, temp
    tmp = Split(temp, "???", -1)

    FileName(i) = tmp(1)
    
    If i > 0 Then
        Load Command1(i)
        Command1(i).Top = Command1(i - 1).Top + Command1(i).Height
        Command1(i).Left = Command1(i - 1).Left
        Command1(i).Height = Command1(i).Height
        Command1(i).Width = Command1(i).Width
        Command1(i).Visible = True
    End If
    Command1(i).Caption = tmp(0)
    If Dir(FileName(i)) = "" Then
        Command1(i).Enabled = False
    Else
        Command1(i).Enabled = True
    End If
    i = i + 1
Wend



    Close #1

If i > 0 Then
      i = i - 1
Else
      Command1(0).Visible = False
End If

Me.Height = Me.Height + Command1(i).Height * i

End Sub
