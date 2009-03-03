VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.Form Form1 
   Appearance      =   0  'Flat
   BackColor       =   &H00D67563&
   Caption         =   "信道维护"
   ClientHeight    =   5730
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   12615
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   ScaleHeight     =   5730
   ScaleWidth      =   12615
   StartUpPosition =   3  '窗口缺省
   Begin VB.CommandButton btnCancel 
      Appearance      =   0  'Flat
      BackColor       =   &H00D67563&
      Caption         =   "清除"
      Enabled         =   0   'False
      Height          =   405
      Left            =   11460
      TabIndex        =   3
      Top             =   5250
      Width           =   1080
   End
   Begin MSComDlg.CommonDialog CD 
      Left            =   8565
      Top             =   5175
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.ListBox s 
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
      ItemData        =   "chnTest.frx":0000
      Left            =   0
      List            =   "chnTest.frx":0037
      TabIndex        =   1
      Top             =   30
      Width           =   12525
   End
   Begin VB.TextBox Text1 
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
      Height          =   405
      Left            =   15
      Locked          =   -1  'True
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   5235
      Width           =   10290
   End
   Begin VB.CommandButton btnBrowser 
      Appearance      =   0  'Flat
      BackColor       =   &H00D67563&
      Caption         =   "浏览"
      Enabled         =   0   'False
      Height          =   405
      Left            =   10350
      TabIndex        =   2
      Top             =   5250
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


CD.CancelError = True
CD.Filter = "*.exe|*.exe"

CD.ShowOpen
path = CD.FileName
Text1.Text = path

i = List1.ListIndex + 1
pIniFile.WriteString "List", Format(i, "信道00"), path
List1.List(List1.ListIndex) = Format(List1.ListIndex + 1, "信道00") & "    " & path


Exit Sub
wher:
    Err.Clear
End Sub

Private Sub btnCancel_Click()
Dim i As Integer

i = List1.ListIndex + 1

pIniFile.WriteString "List", Format(i, "信道00"), ""

List1.List(i - 1) = Format(i, "信道00")

End Sub

Private Sub Form_Load()

Dim i As Integer
Dim path As String
Dim msg As String


pIniFile.Initialize "channellist.ini"

path = App.path
List1.Clear

If Right(path, 1) <> "\" Then path = path & "\"
path = path & App.EXEName & ".exe"
Text1.Text = path


For i = 1 To 18
    msg = pIniFile.ReadString("List", Format(i, "信道00"), "")
    If Dir(Trim(msg)) = "" Then
        pIniFile.WriteString "List", Format(i, "信道00"), ""
        msg = ""
    End If
    List1.AddItem Format(i, "信道00") & "    " & msg
Next i


End Sub

Private Sub List1_Click()

btnBrowser.Enabled = True
btnCancel.Enabled = True
Text1.Text = Trim(Mid(List1.Text, 5))

End Sub

Private Sub List1_DblClick()

Call btnBrowser_Click

End Sub
