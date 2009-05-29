VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "网络配置"
   ClientHeight    =   7905
   ClientLeft      =   150
   ClientTop       =   540
   ClientWidth     =   10665
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   ScaleHeight     =   7905
   ScaleWidth      =   10665
   StartUpPosition =   2  '屏幕中心
   Begin VB.PictureBox picStatusBar 
      Align           =   2  'Align Bottom
      AutoRedraw      =   -1  'True
      Height          =   240
      Left            =   0
      ScaleHeight     =   180
      ScaleWidth      =   10605
      TabIndex        =   6
      Top             =   7665
      Width           =   10665
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Command2"
      Height          =   540
      Left            =   345
      TabIndex        =   5
      Top             =   7890
      Width           =   1395
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      ForeColor       =   &H80000008&
      Height          =   7680
      Left            =   4155
      ScaleHeight     =   7650
      ScaleWidth      =   6405
      TabIndex        =   4
      Top             =   0
      Width           =   6435
      Begin MSComctlLib.TreeView TreeView3 
         Height          =   3105
         Left            =   135
         TabIndex        =   11
         Top             =   3960
         Width           =   6090
         _ExtentX        =   10742
         _ExtentY        =   5477
         _Version        =   393217
         LineStyle       =   1
         Style           =   7
         Checkboxes      =   -1  'True
         Appearance      =   0
      End
      Begin MSComctlLib.TreeView TreeView2 
         Height          =   3270
         Left            =   120
         TabIndex        =   10
         Top             =   345
         Width           =   6090
         _ExtentX        =   10742
         _ExtentY        =   5768
         _Version        =   393217
         LineStyle       =   1
         Style           =   7
         Checkboxes      =   -1  'True
         Appearance      =   0
      End
      Begin VB.CommandButton Command3 
         Appearance      =   0  'Flat
         Caption         =   "设置网络"
         Height          =   360
         Left            =   3270
         TabIndex        =   7
         Top             =   7155
         Width           =   2985
      End
      Begin VB.Label Label2 
         Caption         =   "将从以下应用程序读入数据"
         Height          =   240
         Left            =   105
         TabIndex        =   9
         Top             =   3690
         Width           =   6120
      End
      Begin VB.Label Label1 
         Caption         =   "数据将发往以下应用程序"
         Height          =   240
         Left            =   105
         TabIndex        =   8
         Top             =   105
         Width           =   6120
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2685
      Top             =   5385
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      MaskColor       =   12632256
      _Version        =   393216
   End
   Begin VB.TextBox Text2 
      Height          =   315
      Left            =   5340
      TabIndex        =   3
      Text            =   "Text2"
      Top             =   8070
      Width           =   2850
   End
   Begin VB.TextBox Text1 
      Height          =   315
      Left            =   2325
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   8010
      Width           =   2775
   End
   Begin VB.Timer TimerRefresher 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   1530
      Top             =   3375
   End
   Begin VB.Timer Timer1 
      Interval        =   500
      Left            =   990
      Top             =   3390
   End
   Begin MSWinsockLib.Winsock CSocket 
      Left            =   2730
      Top             =   3375
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      Protocol        =   1
   End
   Begin MSWinsockLib.Winsock BSocket 
      Left            =   2250
      Top             =   3375
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      Protocol        =   1
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   345
      Left            =   8445
      TabIndex        =   1
      Top             =   8040
      Width           =   1710
   End
   Begin MSComctlLib.TreeView TreeView1 
      Height          =   7680
      Left            =   75
      TabIndex        =   0
      Top             =   0
      Width           =   4050
      _ExtentX        =   7144
      _ExtentY        =   13547
      _Version        =   393217
      HideSelection   =   0   'False
      Indentation     =   265
      LineStyle       =   1
      Style           =   7
      BorderStyle     =   1
      Appearance      =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Comic Sans MS"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Menu mnFile 
      Caption         =   "文件(&F)"
      Enabled         =   0   'False
      Begin VB.Menu mnNew 
         Caption         =   "新建(&N)"
      End
      Begin VB.Menu mnSave 
         Caption         =   "保存(&S)"
      End
   End
   Begin VB.Menu mnSetup 
      Caption         =   "设置(&S)"
      Begin VB.Menu mnRegisterExe 
         Caption         =   "登记本地程序(&R)"
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit



Private Declare Function CopyFile Lib "kernel32" Alias "CopyFileA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String, ByVal bFailIfExists As Long) As Long


Private Declare Function FindFirstFile Lib "kernel32" Alias "FindFirstFileA" (ByVal lpFileName As String, lpFindFileData As WIN32_FIND_DATA) As Long

Private Const MAX_PATH = 260

Private Type FILETIME
        dwLowDateTime As Long
        dwHighDateTime As Long
End Type

Private Type WIN32_FIND_DATA
        dwFileAttributes As Long
        ftCreationTime As FILETIME
        ftLastAccessTime As FILETIME
        ftLastWriteTime As FILETIME
        nFileSizeHigh As Long
        nFileSizeLow As Long
        dwReserved0 As Long
        dwReserved1 As Long
        cFileName As String * MAX_PATH
        cAlternate As String * 14
End Type



Dim oTime As FILETIME












Public m_client As New clsClient
Private m_Channel As New clsChannelManager


Private m_LocalExes(1000) As String

Dim m_iLocalIndex As Integer










Public Sub RefreshClient()
    
    '整理到TreeView控件
    
    Dim i As Integer
    Dim j As Integer
    Dim Root As Node
    Dim msg As String
    
    msg = String(100, " ")
    
    Dim Node1 As Node
    Dim Node2 As Node
    Dim Node3 As Node
    
   
    
    TreeView1.Nodes.Clear
    TreeView1.ImageList = ImageList1
    
    For i = 1 To CL_MAXCLIENT
        If (m_clients(i).IPAddress <> "") Then
            Set Root = TreeView1.Nodes.Add(, , "KEY" & Str(i * 1000) & Format(m_clients(i).IPAddress, "\@@@@@@@@@@@@@@@@"), m_clients(i).IPAddress, 1)
            For j = 1 To 19
                If m_clients(i).exe(j).ExeName.cont(0) <> 0 Then
                    msg = String(100, " ")
                    lstrcpyL2S msg, VarPtr(m_clients(i).exe(j).ExeName)
                    TreeView1.Nodes.Add Root.index, tvwChild, "KEY" & Str(i * 1000 + j) & Format(m_clients(i).IPAddress, "\@@@@@@@@@@@@@@@@"), msg, 2
                End If
            Next j
        End If
    Next i


    TreeView2.Nodes.Clear
    TreeView2.ImageList = ImageList1
    
    For i = 1 To CL_MAXCLIENT
        If (m_clients(i).IPAddress <> "") Then
            Set Root = TreeView2.Nodes.Add(, , "KEY" & Str(i * 1000) & Format(m_clients(i).IPAddress, "\@@@@@@@@@@@@@@@@"), m_clients(i).IPAddress, 1)
            For j = 1 To 19
                If m_clients(i).exe(j).ExeName.cont(0) <> 0 Then
                    msg = String(100, " ")
                    lstrcpyL2S msg, VarPtr(m_clients(i).exe(j).ExeName)
                    TreeView2.Nodes.Add Root.index, tvwChild, "KEY" & Str(i * 1000 + j) & Format(m_clients(i).IPAddress, "\@@@@@@@@@@@@@@@@"), msg, 2
                End If
            Next j
        End If
    Next i
    
    
    TreeView3.Nodes.Clear
    TreeView3.ImageList = ImageList1
    
    For i = 1 To CL_MAXCLIENT
        If (m_clients(i).IPAddress <> "") Then
            Set Root = TreeView3.Nodes.Add(, , "KEY" & Str(i * 1000) & Format(m_clients(i).IPAddress, "\@@@@@@@@@@@@@@@@"), m_clients(i).IPAddress, 1)
            For j = 1 To 19
                If m_clients(i).exe(j).ExeName.cont(0) <> 0 Then
                    msg = String(100, " ")
                    lstrcpyL2S msg, VarPtr(m_clients(i).exe(j).ExeName)
                    TreeView3.Nodes.Add Root.index, tvwChild, "KEY" & Str(i * 1000 + j) & Format(m_clients(i).IPAddress, "\@@@@@@@@@@@@@@@@"), msg, 2
                End If
            Next j
        End If
    Next i

    m_bIsClientsChanged = False
    

End Sub




Private Sub CheckTree23(ByVal Node As MSComctlLib.Node)
    
    Dim IPAddress As String
    Dim ExeName As String
    Dim index1 As Integer
    Dim index2 As Integer
    Dim info As EXEINFO
    Dim i As Integer
    Dim j As Integer
    Dim t As Integer
    
    
    index1 = Val(Trim(Mid(Node.Key, 4)))
    index2 = Val(Trim(Mid(Node.Key, 4)))
    
    index1 = Int(index1 / 1000)
    index2 = index2 - 1000 * index1
    
    info = m_clients(index1).exe(index2)
    
    
    For j = 1 To TreeView2.Nodes.Count
        TreeView2.Nodes(j).Checked = False
        TreeView3.Nodes(j).Checked = False
    Next j
            
    
    For i = 1 To 19
        If info.DataFrom(i).IPAddress(0) <> 0 Then
            IPAddress = String(20, " ")
            lstrcpyL2S IPAddress, VarPtr(info.DataFrom(i).IPAddress(0))
            IPAddress = Trim(IPAddress)
            IPAddress = Left(IPAddress, lstrlen(IPAddress))
            
            ExeName = String(20, " ")
            lstrcpyL2S ExeName, VarPtr(info.DataFrom(i).ExeName)
            ExeName = Trim(ExeName)
            t = InStr(ExeName, Chr(0))
            ExeName = Left(ExeName, t - 1)
            
            'ExeName = LeftB(ExeName, lstrlenL(VarPtr(info.DataFrom(i).ExeName)))
            
            index1 = m_client.QueryClientIndex(IPAddress)
            index2 = m_client.QueryClientExeIndex(index1, ExeName)
            
            For j = 1 To TreeView2.Nodes.Count
                If StartWith(TreeView2.Nodes(j).Key, "KEY" & Str(index1 * 1000 + index2)) = True Then
                    TreeView2.Nodes(j).Checked = True
                    TreeView2.Nodes(j).Parent.Expanded = True
                End If
            Next j
        End If
    Next i
            
    For i = 1 To 19
        If info.DataTo(i).IPAddress(0) <> 0 Then
        
            Debug.Print StrL2S(VarPtr(info.DataTo(i).IPAddress(0)))
            
            IPAddress = String(20, " ")
            lstrcpyL2S IPAddress, VarPtr(info.DataTo(i).IPAddress(0))
            IPAddress = Trim(IPAddress)
            IPAddress = Left(IPAddress, lstrlen(IPAddress))
            
            ExeName = String(20, " ")
            lstrcpyL2S ExeName, VarPtr(info.DataTo(i).ExeName)
            ExeName = Trim(ExeName)
            t = InStr(ExeName, Chr(0))
            ExeName = Left(ExeName, t - 1)
            
            index1 = m_client.QueryClientIndex(IPAddress)
            index2 = m_client.QueryClientExeIndex(index1, ExeName)
            
            For j = 1 To TreeView3.Nodes.Count
                If StartWith(TreeView3.Nodes(j).Key, "KEY" & Str(index1 * 1000 + index2)) = True Then
                    TreeView3.Nodes(j).Checked = True
                    TreeView3.Nodes(j).Parent.Expanded = True
                End If
            Next j
        End If
    Next i
            
    
End Sub







Private Sub BSocket_DataArrival(ByVal bytesTotal As Long)

    
    Dim msg As String
    Dim IPAddress As String
    Dim ip1 As String
    Dim ip2 As String
    Dim exe1 As String
    Dim exe2 As String
    Dim df As Boolean
        
    Dim data As DATASTREAMLIST
    
    msg = String(bytesTotal, " ")
    
    BSocket.GetData msg
    
    Debug.Print msg
    
    IPAddress = BSocket.RemoteHostIP
    BSocket.RemoteHost = "255.255.255.255"

    
    If StartWith(msg, "SETUPRUNNING") = False Then
        Exit Sub
    End If
    
    If Len(msg) = Len("SETUPRUNNING") Then Exit Sub
    
    If m_client.QueryClientIndex(IPAddress) = 0 Then
        msg = Mid(msg, Len("SETUPRUNNING") + 1)
            
        ip1 = GetIP1(msg)
        ip2 = GetIP2(msg)
        exe1 = GetExe1(msg)
        exe2 = GetExe2(msg)
        df = StreamIsLeftToRight(msg)
        
        
        lstrcpyS2L VarPtr(data.IPAddress(0)), ip2
        lstrcpyS2L VarPtr(data.ExeName), exe2
        
        If df Then
            m_client.AddClientEx ip1, exe1, VarPtr(data), 0
        Else
            m_client.AddClientEx ip1, exe1, 0, VarPtr(data)
        End If
    End If

End Sub

Private Sub Command1_Click()
    
    Dim data As DATASTREAMLIST
    Dim msg As String
    Dim msg2 As String
    
    msg = "192.168.1.3"
    lstrcpyS2L VarPtr(data.IPAddress(0)), msg
    msg = "程序1"
    lstrcpyS2L VarPtr(data.ExeName), msg
    

    Call m_client.AddClientEx("192.168.1.2", "程序A", VarPtr(data), 0)
    
    msg = "192.168.1.2"
    lstrcpyS2L VarPtr(data.IPAddress(0)), msg
    msg = "程序A"
    lstrcpyS2L VarPtr(data.ExeName), msg
    
    Call m_client.AddClientEx("192.168.1.3", "程序1", 0, VarPtr(data))
    Call m_client.AddClientEx("192.168.1.3", "程序1", VarPtr(data), 0)
   
    
    
    msg = "192.168.1.3"
    lstrcpyS2L VarPtr(data.IPAddress(0)), msg
    msg = "程序2"
    lstrcpyS2L VarPtr(data.ExeName), msg
    
    Call m_client.AddClientEx("192.168.1.2", "程序B", VarPtr(data), 0)
    
    msg = "192.168.1.2"
    lstrcpyS2L VarPtr(data.IPAddress(0)), msg
    msg = "程序B"
    lstrcpyS2L VarPtr(data.ExeName), msg
    
    Call m_client.AddClientEx("192.168.1.3", "程序2", VarPtr(data), 0)
        
    Form1.RefreshClient

End Sub

Private Sub Command2_Click()


picStatusBar.Cls
picStatusBar.Print "状态栏测试"



End Sub

Private Sub Command3_Click()

WriteNetConfigFile

End Sub

Private Sub CSocket_DataArrival(ByVal bytesTotal As Long)


    Dim msg As String
    Dim fp As Integer

    
    CSocket.GetData msg
    
    Debug.Print msg
    
    BSocket.RemoteHost = "255.255.255.255"
    
    
    If msg = "STARTCONFIG" Then
        
        fp = FreeFile
        Open App.path & "\config.tmp" For Output As fp
        Close fp
        
    ElseIf msg = "ENDCONFIG" Then
        Call ReadNetworkConfig
    Else
        fp = FreeFile
        Open App.path & "\config.tmp" For Append As fp
        Print #fp, msg
        Close fp
        
    End If
    
    
End Sub

Private Sub Form_GotFocus()

    If Form2.Visible = True Then
    
        SetWindowPos Form1.hwnd, Form2.hwnd, 0, 0, 0, 0, SWP_NOSIZE + SWP_NOMOVE
    
    End If
    
    
End Sub

Private Sub Form_Load()


    With BSocket
        .Close
        .LocalPort = 7100
        .RemoteHost = "255.255.255.255"
        .RemotePort = 7100
        .Bind
    End With
    
    With CSocket
        .Close
        .LocalPort = 7101
        .RemoteHost = "255.255.255.255"
        .RemotePort = 7101
        .Bind
    End With
    
    oTime.dwHighDateTime = 0
    oTime.dwLowDateTime = 0
    m_iLocalIndex = 1
    InitLocalExeConfig
    
    m_bIsClientsChanged = False



    ImageList1.ListImages.Add 1, , LoadPicture(App.path & "\pc.bmp")
    ImageList1.ListImages.Add 2, , LoadPicture(App.path & "\exe.bmp")
    
    UpdateLocalExe
    
    
End Sub

Private Sub mnRegisterExe_Click()

    Form2.Show
    Me.Enabled = False
    
End Sub

Private Sub Timer1_Timer()
    
    Dim msg As String
    
    If (m_LocalExes(m_iLocalIndex) = "") Then
        m_iLocalIndex = 1
    End If

    msg = "SETUPRUNNING" & m_LocalExes(m_iLocalIndex)
    m_iLocalIndex = m_iLocalIndex + 1

    BSocket.SendData msg
    
    
End Sub

Private Sub TimerRefresher_Timer()
    
    Dim fd As WIN32_FIND_DATA
     
    If m_bIsClientsChanged Then
        RefreshClient
    End If

    
    Exit Sub
    
    '

    FindFirstFile App.path & "\NetConfig.txt", fd
    If TimeCmp(fd.ftLastWriteTime, oTime) <> 0 Then
        If oTime.dwHighDateTime = 0 And oTime.dwLowDateTime = 0 Then
        Else
            InitLocalExeConfig
            m_iLocalIndex = 1
        End If
        oTime = fd.ftLastWriteTime
    End If

End Sub


Private Sub TreeView1_NodeClick(ByVal Node As MSComctlLib.Node)
    
    Dim k As Integer
    Dim i As Integer
    Dim j As Integer
    
    
    Dim msg As String
    Dim tmp As String
    
    
    k = Val(Mid(Trim(Node.Key), 4))
    If Int(k / 1000) * 1000 = k Then
        For i = 1 To TreeView2.Nodes.Count
            TreeView2.Nodes(i).Checked = False
            TreeView3.Nodes(i).Checked = False
        Next i
        
        TreeView2.Enabled = False
        TreeView3.Enabled = False
        
        Exit Sub
    End If
    
    
    TreeView2.Enabled = True
    TreeView3.Enabled = True
    
    tmp = String(100, " ")
    Call lstrcpyL2S(tmp, VarPtr(m_clients(Int(k / 1000)).exe(k - 1000 * Int(k / 1000)).ExeName))
    msg = m_clients(Int(k / 1000)).IPAddress & "-->" & tmp
    
    StatusShow msg
    
    CheckTree23 Node
    
    
End Sub

Private Sub TreeView2_Click()
    
'    If TreeView2.SelectedItem.Children > 0 Then
        'TreeView2.SelectedItem.Expanded = True

'    End If
    

End Sub

Private Sub TreeView2_NodeCheck(ByVal Node As MSComctlLib.Node)
    
    
    Dim i As Integer
    Dim k1 As Integer
    Dim k2 As Integer
    Dim iClientIndex As Integer
    Dim iExeIndex As Integer
    
    Dim data As DATASTREAMLIST
    Dim msg As String
    
    Dim IP2Set As String
    
    
    Dim IPAddress(15) As Byte
    Dim ExeName As SZEXENAME
    
    
    If Node.Children > 0 Then
        Node.Checked = False
        Exit Sub
    End If
        
    If Node.Checked = True Then
        'MsgBox "checked"
        For i = 1 To TreeView2.Nodes.Count
            k1 = Val(Mid(Trim(TreeView2.Nodes(i).Key), 4))
            k2 = Val(Mid(Trim(Node.Key), 4))
            k1 = Int(k1 / 1000)
            k2 = Int(k2 / 1000)
            If k1 = k2 Then
                TreeView2.Nodes(i).Checked = False
            End If
        Next i
        Node.Checked = True
        
        
        '更改数据记录
        k1 = Val(Mid(Trim(Node.Key), 4))
        iClientIndex = Int(k1 / 1000)
        iExeIndex = k1 - 1000 * iClientIndex
        
        Call lstrcpyS2L(ByVal VarPtr(IPAddress(0)), m_clients(iClientIndex).IPAddress)
        
        CopyMemory ByVal VarPtr(ExeName), ByVal VarPtr(m_clients(iClientIndex).exe(iExeIndex).ExeName), LenB(ExeName)
        'Debug.Print StrL2S(ByVal VarPtr(IPAddress(0)))
        
        'Debug.Print StrL2S(ByVal VarPtr(ExeName))
        
        IP2Set = Trim(Right(TreeView1.SelectedItem.Key, 15))
        
        k1 = Val(Trim(Mid(TreeView1.SelectedItem.Key, 4)))
        k2 = k1 - 1000 * Int(k1 / 1000)
        k1 = Int(k1 / 1000)
        
        
        'MsgBox IP2Set & "->" & StrL2S(VarPtr(m_clients(k1).exe(k2).ExeName)) & vbCrLf & StrL2S(VarPtr(IPAddress(0))) & "->" & StrL2S(VarPtr(ExeName))
        
        m_client.DeleteClientEx IP2Set, StrL2S(VarPtr(m_clients(k1).exe(k2).ExeName)), 0, StrL2S(VarPtr(IPAddress(0))), True
        '删除记录
        
        
        lstrcpyL2L VarPtr(data.ExeName), VarPtr(ExeName)
        lstrcpyL2L VarPtr(data.IPAddress(0)), VarPtr(IPAddress(0))
        
        m_client.AddClientEx IP2Set, StrL2S(VarPtr(m_clients(k1).exe(k2).ExeName)), VarPtr(data), 0
        
    Else
        '更改数据记录
        k1 = Val(Mid(Trim(Node.Key), 4))
        iClientIndex = Int(k1 / 1000)
        iExeIndex = k1 - 1000 * iClientIndex
        
        Call lstrcpyS2L(ByVal VarPtr(IPAddress(0)), m_clients(iClientIndex).IPAddress)
        Debug.Print StrL2S(ByVal VarPtr(IPAddress(0)))
        
        CopyMemory ByVal VarPtr(ExeName), ByVal VarPtr(m_clients(iClientIndex).exe(iExeIndex).ExeName), LenB(ExeName)
        IP2Set = Trim(Right(TreeView1.SelectedItem.Key, 15))
        
        k1 = Val(Trim(Mid(TreeView1.SelectedItem.Key, 4)))
        k2 = k1 - 1000 * Int(k1 / 1000)
        k1 = Int(k1 / 1000)
        
        
        'MsgBox IP2Set & "->" & StrL2S(VarPtr(m_clients(k1).exe(k2).ExeName)) & vbCrLf & StrL2S(VarPtr(IPAddress(0))) & "->" & StrL2S(VarPtr(ExeName))
        
        m_client.DeleteClientEx IP2Set, StrL2S(VarPtr(m_clients(k1).exe(k2).ExeName)), 0, StrL2S(VarPtr(IPAddress(0))), True
        '删除记录
        
        
    End If

    
End Sub

Private Sub TreeView2_NodeClick(ByVal Node As MSComctlLib.Node)
    
    '
End Sub




Private Sub StatusShow(msg As String)
        
    picStatusBar.Cls
    picStatusBar.Print msg

End Sub


Private Sub TreeView3_NodeCheck(ByVal Node As MSComctlLib.Node)

    
    Dim i As Integer
    Dim k1 As Integer
    Dim k2 As Integer
    Dim iClientIndex As Integer
    Dim iExeIndex As Integer
    
    Dim data As DATASTREAMLIST
    Dim msg As String
    
    Dim IP2Set As String
    
    
    Dim IPAddress(15) As Byte
    Dim ExeName As SZEXENAME
    
    
    If Node.Children > 0 Then
        Node.Checked = False
        Exit Sub
    End If
        
    If Node.Checked = True Then
        'MsgBox "checked"
        For i = 1 To TreeView3.Nodes.Count
            k1 = Val(Mid(Trim(TreeView3.Nodes(i).Key), 4))
            k2 = Val(Mid(Trim(Node.Key), 4))
            k1 = Int(k1 / 1000)
            k2 = Int(k2 / 1000)
            If k1 = k2 Then
                TreeView3.Nodes(i).Checked = False
            End If
        Next i
        Node.Checked = True
        
        
        '更改数据记录
        k1 = Val(Mid(Trim(Node.Key), 4))
        iClientIndex = Int(k1 / 1000)
        iExeIndex = k1 - 1000 * iClientIndex
        
        Call lstrcpyS2L(ByVal VarPtr(IPAddress(0)), m_clients(iClientIndex).IPAddress)
        
        CopyMemory ByVal VarPtr(ExeName), ByVal VarPtr(m_clients(iClientIndex).exe(iExeIndex).ExeName), LenB(ExeName)
        'Debug.Print StrL2S(ByVal VarPtr(IPAddress(0)))
        
        'Debug.Print StrL2S(ByVal VarPtr(ExeName))
        
        IP2Set = Trim(Right(TreeView1.SelectedItem.Key, 15))
        
        k1 = Val(Trim(Mid(TreeView1.SelectedItem.Key, 4)))
        k2 = k1 - 1000 * Int(k1 / 1000)
        k1 = Int(k1 / 1000)
        
        
        Debug.Print IP2Set & "->" & StrL2S(VarPtr(m_clients(k1).exe(k2).ExeName)) & vbCrLf & StrL2S(VarPtr(IPAddress(0))) & "->" & StrL2S(VarPtr(ExeName))
        
        m_client.DeleteClientEx IP2Set, StrL2S(VarPtr(m_clients(k1).exe(k2).ExeName)), 0, StrL2S(VarPtr(IPAddress(0))), False
        '删除记录
        
        
        lstrcpyL2L VarPtr(data.ExeName), VarPtr(ExeName)
        lstrcpyL2L VarPtr(data.IPAddress(0)), VarPtr(IPAddress(0))
        
        m_client.AddClientEx IP2Set, StrL2S(VarPtr(m_clients(k1).exe(k2).ExeName)), 0, VarPtr(data)
        
    Else
        '更改数据记录
        k1 = Val(Mid(Trim(Node.Key), 4))
        iClientIndex = Int(k1 / 1000)
        iExeIndex = k1 - 1000 * iClientIndex
        
        Call lstrcpyS2L(ByVal VarPtr(IPAddress(0)), m_clients(iClientIndex).IPAddress)
        Debug.Print StrL2S(ByVal VarPtr(IPAddress(0)))
        
        CopyMemory ByVal VarPtr(ExeName), ByVal VarPtr(m_clients(iClientIndex).exe(iExeIndex).ExeName), LenB(ExeName)
        IP2Set = Trim(Right(TreeView1.SelectedItem.Key, 15))
        
        k1 = Val(Trim(Mid(TreeView1.SelectedItem.Key, 4)))
        k2 = k1 - 1000 * Int(k1 / 1000)
        k1 = Int(k1 / 1000)
        
        
        'MsgBox IP2Set & "->" & StrL2S(VarPtr(m_clients(k1).exe(k2).ExeName)) & vbCrLf & StrL2S(VarPtr(IPAddress(0))) & "->" & StrL2S(VarPtr(ExeName))
        
        m_client.DeleteClientEx IP2Set, StrL2S(VarPtr(m_clients(k1).exe(k2).ExeName)), 0, StrL2S(VarPtr(IPAddress(0))), False
        '删除记录
        
        
    End If

    

End Sub


Public Sub UpdateLocalExe()
    '
    Dim msg As String
    Dim tmp As String
    Dim i As Integer
    
    
    Dim fp As Integer
    
    m_client.Initialize
    
    fp = FreeFile
    
    If Dir(App.path & "\AppList.txt") = "" Then
    
        Open App.path & "\AppList.txt" For Output As #fp
        Close fp
        Exit Sub
        
    End If
    
    Open App.path & "\AppList.txt" For Input As #fp
    
    While Not EOF(fp)
        Line Input #fp, msg
        i = InStr(1, msg, "???")
        If (i <= 0) Then
        Else
            tmp = Left(msg, i - 1)
            m_client.AddClientEx BSocket.LocalIP, tmp, 0, 0
        End If
    Wend
    Close #fp


End Sub

Public Sub ConfigNetwork()

    Dim msg As String
    Dim fp As Integer
    
    fp = FreeFile
    Open App.path & "\NetConfig.txt" For Input As #fp
    
    CSocket.SendData "STARTCONFIG"
    
    DoEvents
    
    While Not EOF(fp)
        Line Input #fp, msg
        msg = Trim(msg)
        If msg <> "" Then
            CSocket.SendData msg
        End If
        DoEvents
    Wend
    
    Close fp
    
    CSocket.SendData "ENDCONFIG"
    
End Sub

Private Sub ReadNetworkConfig()
    
    '
    Dim ip1 As String, ip2 As String
    Dim exe1 As String, exe2 As String
    Dim df As Boolean
    Dim fp As Integer
    Dim msg As String
    
    Dim data As DATASTREAMLIST
    Dim data1 As DATASTREAMLIST
    
    fp = FreeFile
    
    
    m_client.Initialize
    
    Open App.path & "\config.tmp" For Input As #fp
    While Not EOF(fp)
    
        Line Input #fp, msg
    
        ip1 = GetIP1(msg)
        ip2 = GetIP2(msg)
        exe1 = GetExe1(msg)
        exe2 = GetExe2(msg)
        df = StreamIsLeftToRight(msg)
        
        lstrcpyS2L VarPtr(data.IPAddress(0)), ip2
        lstrcpyS2L VarPtr(data.ExeName), exe2
          
        lstrcpyS2L VarPtr(data1.IPAddress(0)), ip1
        lstrcpyS2L VarPtr(data1.ExeName), exe1
        
        If df Then
            m_client.AddClientEx ip1, exe1, VarPtr(data), 0
            m_client.AddClientEx ip2, exe2, 0, VarPtr(data1)
        Else
            m_client.AddClientEx ip1, exe1, 0, VarPtr(data)
            m_client.AddClientEx ip2, exe2, VarPtr(data1), 0
        End If
    
    Wend
    Close #fp
    
    Form1.RefreshClient
    
    CopyFile App.path & "config.tmp", App.path & "NetConfig.txt", 0
    
    InitLocalExeConfig
    
End Sub


Private Sub InitLocalExeConfig()
    '
    Dim msg As String
    Dim ip1 As String, ip2 As String
    Dim exe1 As String, exe2 As String
    Dim directionFrom As Boolean
    
    Dim fp As Integer
    
    Dim lexeList(128) As String
    Dim lexeIndex As Integer
    lexeIndex = 1
    
    
    Dim temp As String
    Dim CurrentLineIndex As Integer
    Dim t As Integer
    
    
    CurrentLineIndex = 1
    
    'm_Channel.InitChannelManager
    
    
    fp = FreeFile
    
    
      If Dir(App.path & "\NetConfig.txt") = "" Then
      
            Open App.path & "\NetConfig.txt" For Output As #fp
            Close fp
            
            Exit Sub
            
      End If
      
    Open App.path & "\NetConfig.txt" For Input As #fp
    
    While Not EOF(fp)
        Line Input #fp, msg
        msg = Trim(msg)
        If msg <> "" Then
           
            ip1 = GetIP1(msg)
            If ip1 <> CSocket.LocalIP Then
                '当前配置项没本机啥事
            Else
                m_LocalExes(CurrentLineIndex) = msg
                CurrentLineIndex = CurrentLineIndex + 1
            End If
           
            If InStr(msg, CSocket.LocalIP) > 0 Then
                lexeList(lexeIndex) = msg
                lexeIndex = lexeIndex + 1
                'ConfigExe (msg)
            End If
           
        End If
    Wend
    
    Close fp
    
    
    
    
    m_LocalExes(CurrentLineIndex) = ""

    Dim localExes(128) As String
    Dim j As Integer, i As Integer
    
    For i = 1 To 128
        localExes(i) = lexeList(i)
    Next i
    
    For i = 1 To 128
        If localExes(i) = "" Then Exit For
        For j = 1 To i - 1
            If localExes(j) <> "" Then
                If EqualConfigInfo(localExes(i), localExes(j)) = True Then
                    localExes(j) = ""
                End If
            End If
        Next j
    Next i
    
    
    t = 1
    
    For i = 1 To 128
        If localExes(i) <> "" Then
            lexeList(t) = localExes(i)
            t = t + 1
        End If
    Next i

    lexeIndex = t

    For t = 1 To lexeIndex - 1
        ConfigExe (lexeList(t))
    Next t
    
End Sub

Private Function EqualConfigInfo(info1 As String, info2 As String) As Boolean
    
    Dim ip11 As String, ip12 As String, ip21 As String, ip22 As String
    Dim exe11 As String, exe12 As String, exe21 As String, exe22 As String
    
    Dim dF1 As Boolean, dF2 As Boolean
    
    If info1 = info2 Then
        EqualConfigInfo = True
        Exit Function
    End If
    
    ip11 = GetIP1(info1)
    ip12 = GetIP2(info1)
    ip21 = GetIP1(info2)
    ip22 = GetIP2(info2)
    exe11 = GetExe1(info1)
    exe12 = GetExe2(info1)
    exe21 = GetExe1(info2)
    exe22 = GetExe2(info2)
    dF1 = StreamIsLeftToRight(info1)
    dF2 = StreamIsLeftToRight(info2)
    
    If ip11 = ip22 And ip12 = ip21 And exe11 = exe22 And exe12 = exe21 And dF1 = Not dF2 Then
        EqualConfigInfo = True
        Exit Function
    End If
    
    EqualConfigInfo = False

End Function


Private Sub ConfigExe(cmd As String)

    Dim ip1 As String, ip2 As String
    Dim exe1 As String, exe2 As String
    Dim df As Boolean
    Dim pIniFile As New clsTIniFile
    Dim tIniFile As New clsTIniFile
    
    
    Dim msg As String
    Dim path As String
    Dim chn As Integer
    Dim chn1 As Integer
    Dim chn2 As Integer
    
    Dim i As Integer
    
    ip1 = GetIP1(cmd)
    ip2 = GetIP2(cmd)
    exe1 = GetExe1(cmd)
    exe2 = GetExe2(cmd)
    df = StreamIsLeftToRight(cmd)
    
    
    tIniFile.Initialize App.path & "\config.ini"
    
    
    If ip1 = CSocket.LocalIP Then
        path = GetLocalExePath(exe1)
        If path <> "" Then
            path = path & "channel.config"
            pIniFile.Initialize path
            
            msg = tIniFile.ReadString("IPAddress", ip2, "0.0")
            chn1 = Int(Val(Trim(msg)))
            i = InStr(msg, ".")
            chn2 = Int(Val(Trim(Mid(msg, i + 1))))
            
            If df = True Then
                chn = m_Channel.FreeSChannel
                pIniFile.WriteString "CHANNEL", "SendChannel", Trim(Str(chn))
                chn1 = chn
            Else
                chn = m_Channel.FreeRChannel
                pIniFile.WriteString "CHANNEL", "RecvChannel", Trim(Str(chn))
                chn2 = chn
            End If
            msg = Trim(Str(chn1)) & "." & Trim(Str(chn2))
            tIniFile.WriteString "IPAddress", ip2, msg
        End If
    End If
    
    If ip2 = CSocket.LocalIP Then
        path = GetLocalExePath(exe2)
        If path <> "" Then
            path = path & "channel.config"
            pIniFile.Initialize path
            msg = tIniFile.ReadString("IPAddress", ip2, "0.0")
            chn1 = Int(Val(Trim(msg)))
            i = InStr(msg, ".")
            chn2 = Int(Val(Trim(Mid(msg, i + 1))))
            If df = True Then
                chn = m_Channel.FreeRChannel
                pIniFile.WriteString "CHANNEL", "RecvChannel", Trim(Str(chn))
                chn2 = chn
            Else
                chn = m_Channel.FreeSChannel
                pIniFile.WriteString "CHANNEL", "SendChannel", Trim(Str(chn))
                chn1 = chn
            End If
            msg = Trim(Str(chn1)) & "." & Trim(Str(chn2))
            tIniFile.WriteString "IPAddress", ip2, msg
        End If
    End If
    



End Sub


Private Function GetLocalExePath(ExeName As String) As String
    
    Dim fp As Integer
    Dim msg As String
    Dim i As Integer
    
    
    fp = FreeFile
    
    Open App.path & "\AppList.txt" For Input As #fp
    
    While Not EOF(fp)
        
        Line Input #fp, msg
        
        If StartWith(msg, ExeName) = True Then
            msg = Mid(msg, Len(ExeName) + 4)
            For i = Len(msg) To 1 Step -1
                If Mid(msg, i, 1) = "\" Then
                    msg = Left(msg, i)
                    GetLocalExePath = msg
                    Close #fp
                    Exit Function
                End If
            Next i
        End If
    Wend
    
    Close #fp
    
    GetLocalExePath = ""
    
End Function



Private Function GetIP1(data As String) As String
    
    If data = "" Then Exit Function

    Dim i As Integer
    Dim msg As String
    i = InStr(data, "->")
    msg = Trim(Left(data, i - 1))
    GetIP1 = msg
End Function
Private Function GetIP2(data As String) As String
    Dim i As Integer
    Dim j As Integer
    Dim t As Integer
    Dim msg As String
    i = InStr(data, "->")
    i = InStr(i + 1, data, "->")
    j = InStr(data, "==>")
    t = InStr(data, "<==")
    If j <= 0 Then j = t
    
    msg = Trim(Mid(data, j + 3, i - j - 3))
    GetIP2 = msg
End Function
Private Function GetExe1(data As String) As String
    Dim i As Integer
    Dim j As Integer
    i = InStr(data, "->")
    j = InStr(data, "==>")
    If j <= 0 Then j = InStr(data, "<==")
    GetExe1 = Mid(data, i + 2, j - i - 2)
End Function
Private Function GetExe2(data As String) As String
    Dim i As Integer

    i = InStr(data, "->")
    i = InStr(i + 1, data, "->")
    GetExe2 = Trim(Mid(data, i + 2))
    
End Function

Private Function StreamIsLeftToRight(data As String) As Boolean
    Dim j As Integer
    j = InStr(data, "==>")
    If j <= 0 Then
        StreamIsLeftToRight = False
    Else
        StreamIsLeftToRight = True
    End If
    
End Function





Private Function TimeCmp(time1 As FILETIME, time2 As FILETIME) As Integer

    If time1.dwHighDateTime = time2.dwHighDateTime And time1.dwLowDateTime = time2.dwLowDateTime Then
        TimeCmp = 0
        Exit Function
    End If
    
    If time1.dwHighDateTime > time2.dwHighDateTime Then
        TimeCmp = 1
        Exit Function
    ElseIf time1.dwHighDateTime < time2.dwHighDateTime Then
        TimeCmp = -1
        Exit Function
    Else
        If time1.dwLowDateTime > time2.dwLowDateTime Then
            TimeCmp = 1
            Exit Function
        Else
            TimeCmp = -1
            Exit Function
        End If
    End If
    
End Function







