VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.Form Form2 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "应用程序登记"
   ClientHeight    =   6765
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   11550
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6765
   ScaleWidth      =   11550
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  '窗口缺省
   Begin VB.CommandButton Command3 
      Caption         =   "取消"
      Height          =   345
      Left            =   9510
      TabIndex        =   4
      Top             =   6210
      Width           =   1890
   End
   Begin VB.CommandButton Command2 
      Caption         =   "确定"
      Default         =   -1  'True
      Height          =   345
      Left            =   7455
      TabIndex        =   3
      Top             =   6210
      Width           =   1890
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   10065
      Top             =   4170
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "..."
      Height          =   300
      Left            =   10875
      TabIndex        =   2
      Top             =   5070
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      Height          =   270
      Left            =   240
      TabIndex        =   1
      Text            =   "Text1"
      Top             =   5100
      Visible         =   0   'False
      Width           =   10245
   End
   Begin MSComctlLib.ListView ListView1 
      Height          =   5955
      Left            =   135
      TabIndex        =   0
      Top             =   120
      Width           =   11265
      _ExtentX        =   19870
      _ExtentY        =   10504
      View            =   3
      LabelEdit       =   1
      MultiSelect     =   -1  'True
      LabelWrap       =   0   'False
      HideSelection   =   -1  'True
      FlatScrollBar   =   -1  'True
      FullRowSelect   =   -1  'True
      GridLines       =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      NumItems        =   0
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Dim m_row As Integer
Dim m_col As Integer


Private Sub Command1_Click()

On Error GoTo whr

    Dim path As String
    Dim i As Integer
    Dim j As Integer
    Dim tmp As String
    
    Text1.Visible = True
    CommonDialog1.CancelError = True
    CommonDialog1.ShowOpen
    
    path = CommonDialog1.FileName
    
    
    Text1.Text = path
    
 
    
    ListView1.SetFocus
    
    
    Exit Sub
whr:
    Err.Clear
    

End Sub

Private Sub Command1_LostFocus()

    Text1.Visible = False
    Command1.Visible = False
    
End Sub

Private Sub Command2_Click()


    If CheckExe = False Then Exit Sub
    
    WriteToConfigFile

    'InitLocalExeConfig
    
    Form1.m_client.Initialize
    Form1.UpdateLocalExe
    
    Unload Me
    
    
    
End Sub

Private Sub WriteToConfigFile()
    
    '
    Dim i As Integer
    Dim tmp As String
    Dim fp As Integer
    
    fp = FreeFile
    Open App.path & "\AppList.txt" For Output As #fp
    For i = 1 To ListView1.ListItems.Count - 1
        tmp = ListView1.ListItems(i).Text & "???" & ListView1.ListItems(i).ListSubItems(1).Text
        Print #fp, tmp
    Next i

    Close fp
    
    
End Sub
Private Function CheckExe() As Boolean
    
 '   Dim result As Boolean
    Dim i As Integer
    Dim j As Integer
    
    
    For i = 1 To ListView1.ListItems.Count - 1
        For j = 1 To i - 1
            If ListView1.ListItems(j).Text = ListView1.ListItems(i).Text Then
                MsgBox "Exe标识重复:" & vbCrLf & ListView1.ListItems(i).Text, vbInformation
                CheckExe = False
                Exit Function
            End If
            If ListView1.ListItems(j).ListSubItems(1).Text = ListView1.ListItems(i).ListSubItems(1).Text Then
                MsgBox "应用程序重复" & vbCrLf & ListView1.ListItems(i).ListSubItems(1).Text, vbInformation
                CheckExe = False
                Exit Function
            End If
        Next j
    Next i
                
      
    CheckExe = True
    

End Function

Private Sub Command3_Click()
    
    Unload Me
    
End Sub

Private Sub ReadConfigFile()


    Dim msg As String
    Dim tmp As String
    Dim i As Integer
    
    Dim fp As Integer
    
    fp = FreeFile
    Open App.path & "\AppList.txt" For Input As #fp

    While Not EOF(fp)
        Line Input #fp, msg
        i = InStr(1, msg, "???")
        If (i <= 0) Then
        Else
            tmp = Left(msg, i - 1)
            ListView1.ListItems.Add , , tmp
            tmp = Mid(msg, i + 3)
            ListView1.ListItems(ListView1.ListItems.Count).ListSubItems.Add , , tmp
        End If
    Wend
    Close #fp
    
    ListView1.ListItems.Add , , "新增"
    ListView1.ListItems(ListView1.ListItems.Count).ListSubItems.Add , , "新增"
     
    
End Sub

Private Sub Form_GotFocus()
        SetWindowPos Form1.hwnd, Me.hwnd, 0, 0, 0, 0, SWP_NOSIZE + SWP_NOMOVE
End Sub

Private Sub Form_Load()

    Me.Show
    
    SetWindowPos Form1.hwnd, Me.hwnd, 0, 0, 0, 0, SWP_NOSIZE + SWP_NOMOVE
    
    ListView1.ColumnHeaders.Clear
    ListView1.ListItems.Clear
              
    m_row = 0
    m_col = 0

    ListView1.ColumnHeaders.Add , , "程序标识", ListView1.Width / 5
    ListView1.ColumnHeaders.Add , , "路径", 4 * ListView1.Width / 5

    
    ReadConfigFile

    'ListView1.ListItems.Add i, , m_ProInfo.Desc(i)
    'ListView1.ListItems(i).ListSubItems.Add , , m_ProInfo.RequestData(i)

            
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    Form1.Enabled = True
    
End Sub

Private Sub ListView1_GotFocus()

    Text1_LostFocus
    
    Text1.Visible = False
    Command1.Visible = False

End Sub

Private Sub ListView1_KeyDown(KeyCode As Integer, Shift As Integer)

    If ListView1.SelectedItem.index >= ListView1.ListItems.Count Then Exit Sub
    If ListView1.SelectedItem.index < 0 Then Exit Sub
    
    If KeyCode = 46 Then
        ListView1.ListItems.Remove ListView1.SelectedItem.index
        ListView1.Refresh
    End If
    
    
End Sub

Private Sub ListView1_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)

On Error GoTo whr

    
    Dim i As Integer
    
    i = ListView1.HitTest(x, y).index
    
    'MsgBox i & vbCrLf & ListView1.ListItems.Count


    If x < ListView1.ColumnHeaders(2).Left Then
        '点击程序标识列
        Text1.Left = ListView1.HitTest(x, y).Left + ListView1.Left
        Text1.Top = ListView1.ListItems(ListView1.HitTest(x, y).index).Top + ListView1.Top
        Text1.Height = ListView1.ListItems(ListView1.HitTest(x, y).index).Height
        Text1.Width = ListView1.ColumnHeaders(1).Width
        Text1.Visible = True
        Text1.Text = ListView1.HitTest(x, y).Text
        Text1.Visible = True
        Text1.SetFocus
        Text1.SelStart = 0
        Text1.SelLength = Len(Text1.Text)
        Text1.Locked = False
        
        m_col = 1
        m_row = ListView1.HitTest(x, y).index
        
    Else
        '点击路径列
        Text1.Left = ListView1.Left + ListView1.ColumnHeaders(2).Left
        Text1.Top = ListView1.ListItems(ListView1.HitTest(x, y).index).Top + ListView1.Top
        Text1.Height = ListView1.ListItems(ListView1.HitTest(x, y).index).Height
        Text1.Width = ListView1.ColumnHeaders(2).Width - Command1.Width
        Text1.Visible = True
        
        Command1.Left = Text1.Left + Text1.Width
        Command1.Top = Text1.Top
        'Command1.Width = ListView1.ColumnHeaders(2).Width - Command1.Width - Text1.Width
        Command1.Height = Text1.Height
        Command1.Visible = True
        
        Text1.Text = ListView1.HitTest(x, y).ListSubItems(1).Text
        Text1.Visible = True
        Text1.SetFocus
        Text1.SelStart = 0
        Text1.SelLength = Len(Text1.Text)
        Text1.Locked = True
        
        m_col = 2
        m_row = ListView1.HitTest(x, y).index
        
    End If
    
Exit Sub

whr:
    Err.Clear
    
End Sub

Private Sub Text1_DblClick()

    If Text1.Locked = True Then
        Call Command1_Click
    End If
    
End Sub

Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)

    If m_row = ListView1.ListItems.Count Then Exit Sub

    If KeyCode = 46 Then
        Text1.Text = ""
        ListView1.ListItems.Remove m_row
        ListView1.Refresh
        Text1.Visible = False
        Command1.Visible = False
    End If
    
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

    If KeyAscii = Asc("?") Then
        Beep
        KeyAscii = 0
    End If
    
    
End Sub

Private Sub Text1_LostFocus()

On Error GoTo whr
    
    
    Dim i As Integer, j As Integer
    Dim tmp As String
    
    Text1.Visible = False
    
    If Text1.Text = "" Then
        Exit Sub
    End If
    
    If Text1.Text = "新增" Then
        Exit Sub
    End If
    
    If m_col = 1 Then
        ListView1.ListItems(m_row).Text = Text1.Text
    Else
        ListView1.ListItems(m_row).ListSubItems(1).Text = Text1.Text
        For i = Len(Text1.Text) To 1 Step -1
            If Mid(Text1.Text, i, 1) = "\" Then
                Exit For
            End If
        Next i
        For j = Len(Text1.Text) To 1 Step -1
            If Mid(Text1.Text, j, 1) = "." Then
                Exit For
            End If
        Next j
        If i = 0 Or j = 0 Or i = j Then
            Exit Sub
        End If
        If i < j Then
            tmp = Mid(Text1.Text, i + 1, j - i - 1)
        Else
            tmp = Mid(Text1.Text, i + 1)
        End If
        ListView1.ListItems(m_row).Text = tmp
        
        
    End If
    
    
    If m_row = ListView1.ListItems.Count Then
        ListView1.ListItems.Add , , "新增"
        'ListView1.ListItems(ListView1.ListItems.Count).ListSubItems(2) = "新增"
        ListView1.ListItems(ListView1.ListItems.Count).ListSubItems.Add , , "新增"
    End If
    
    'ListView1.SelectedItem.index = ListView1.ListItems.Count

Exit Sub

whr:
    Err.Clear
   
End Sub



















