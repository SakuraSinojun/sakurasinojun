VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.Form Form1 
   Appearance      =   0  'Flat
   BackColor       =   &H00D67563&
   Caption         =   "信道维护"
   ClientHeight    =   5760
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   12615
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   5760
   ScaleWidth      =   12615
   StartUpPosition =   3  '窗口缺省
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "设定"
      Enabled         =   0   'False
      Height          =   300
      Left            =   6015
      TabIndex        =   7
      Top             =   5325
      Width           =   1590
   End
   Begin VB.ComboBox Combo2 
      Appearance      =   0  'Flat
      BackColor       =   &H00D67563&
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   4320
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   5310
      Width           =   1590
   End
   Begin VB.TextBox Text2 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00D67563&
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   3015
      Locked          =   -1  'True
      TabIndex        =   5
      Text            =   "接收"
      Top             =   5310
      Width           =   1245
   End
   Begin VB.ComboBox Combo1 
      Appearance      =   0  'Flat
      BackColor       =   &H00D67563&
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      ItemData        =   "chnTest.frx":0000
      Left            =   1365
      List            =   "chnTest.frx":0002
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   5310
      Width           =   1590
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00D67563&
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   60
      TabIndex        =   3
      Text            =   "发送"
      Top             =   5310
      Width           =   1245
   End
   Begin VB.CommandButton btnCancel 
      Appearance      =   0  'Flat
      BackColor       =   &H00D67563&
      Caption         =   "删除"
      Enabled         =   0   'False
      Height          =   405
      Left            =   11460
      TabIndex        =   2
      Top             =   5295
      Width           =   1080
   End
   Begin MSComDlg.CommonDialog CD 
      Left            =   8565
      Top             =   4725
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.ListBox List1 
      Appearance      =   0  'Flat
      BackColor       =   &H00D67563&
      BeginProperty Font 
         Name            =   "Comic Sans MS"
         Size            =   10.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   5160
      ItemData        =   "chnTest.frx":0004
      Left            =   45
      List            =   "chnTest.frx":0006
      TabIndex        =   0
      Top             =   45
      Width           =   12525
   End
   Begin VB.CommandButton btnBrowser 
      Appearance      =   0  'Flat
      BackColor       =   &H00D67563&
      Caption         =   "添加"
      Height          =   405
      Left            =   10350
      TabIndex        =   1
      Top             =   5295
      Width           =   1080
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private pIniFile As New clsTIniFile



Private Sub btnBrowser_Click()
On Error GoTo wher

Dim path As String
Dim i As Integer
Dim fp As Integer


CD.CancelError = True
CD.Filter = "*.exe|*.exe"

CD.ShowOpen
path = CD.FileName

For i = 0 To List1.ListCount - 1
      If path = List1.List(i) Then
            MsgBox "当前文件设置已存在"
            List1.ListIndex = i
            Exit Sub
      End If
Next i

List1.AddItem path


fp = FreeFile
Open "channellist.list" For Output As #fp
For i = 0 To List1.ListCount - 1
      
      Print #fp, List1.List(i)
      
Next i

Close #fp


Exit Sub
wher:
      
      MsgBox Err.Description
    Err.Clear
End Sub

Private Sub btnCancel_Click()
Dim fp As Integer
Dim i As Integer

Command1.Enabled = False
btnCancel.Enabled = False

List1.RemoveItem List1.ListIndex

fp = FreeFile
Open "channellist.list" For Output As #fp
For i = 0 To List1.ListCount - 1
      Print #fp, List1.List(i)
Next i
Close #fp

End Sub

Private Sub Command1_Click()
Dim pIniFile As New clsTIniFile
Dim path As String
Dim i As Integer

path = List1.Text

For i = Len(path) To 1 Step -1
      
      If Mid(path, i, 1) = "\" Then Exit For

Next i

If i = 0 Then Exit Sub

path = Left(path, i)
path = path & "channel.config"
pIniFile.Initialize path

pIniFile.WriteString "CHANNEL", "SendChannel", Trim(Str(Combo1.ListIndex))

pIniFile.WriteString "CHANNEL", "RecvChannel", Trim(Str(Combo2.ListIndex))

End Sub

Private Sub Form_Load()

Dim i As Integer
Dim fp As Integer
Dim path As String
Dim msg As String



path = "channellist.list"

If Dir(path) = "" Then
      fp = FreeFile
      Open path For Output As #fp
      Close #fp
Else
      fp = FreeFile
      Open path For Input As #fp
      While Not EOF(fp)
            Line Input #fp, msg
            If msg <> "" And Dir(msg) <> "" Then
                  List1.AddItem msg
            End If
      Wend
      Close #fp
End If


For i = 0 To 18
    Combo1.AddItem (Format(i, "信道00"))
    Combo2.AddItem (Format(i, "信道00"))
Next i


Combo1.Text = "信道00"
Combo2.Text = "信道00"





End Sub

Private Sub List1_Click()

Dim pIniFile As New clsTIniFile
Dim path As String
Dim i As Integer


btnCancel.Enabled = True
Command1.Enabled = True


path = List1.Text

For i = Len(path) To 1 Step -1
      
      If Mid(path, i, 1) = "\" Then Exit For

Next i

If i = 0 Then Exit Sub

path = Left(path, i)

path = path & "channel.config"

pIniFile.Initialize path

path = pIniFile.ReadString("CHANNEL", "SendChannel", "0")
Combo1.ListIndex = Val(path)

path = pIniFile.ReadString("CHANNEL", "RecvChannel", "0")

Combo2.ListIndex = Val(path)



End Sub

Private Sub List1_DblClick()

Call btnBrowser_Click

End Sub
