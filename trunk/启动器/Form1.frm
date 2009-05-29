VERSION 5.00
Begin VB.Form Form1 
   BackColor       =   &H80000007&
   Caption         =   " 启动器"
   ClientHeight    =   3120
   ClientLeft      =   60
   ClientTop       =   420
   ClientWidth     =   2835
   LinkTopic       =   "Form1"
   ScaleHeight     =   3120
   ScaleWidth      =   2835
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
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim FileName(100) As String

Private Sub Form_Load()

If Dir(App.Path & "\AppList.txt") = "" Then
    MsgBox "AppList.txt文件不存在!"
    Exit Sub
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
        Form1.Height = Command1(i).Height * i + 20
    End If
    Command1(i).Caption = tmp(0)
    If Dir(FileName(i)) = "" Then Command1(i).Enabled = False
    i = i + 1
Wend

    Close #1

End Sub
