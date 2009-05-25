VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form Form1 
   Appearance      =   0  'Flat
   BackColor       =   &H00D67563&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Server/Client"
   ClientHeight    =   8805
   ClientLeft      =   150
   ClientTop       =   540
   ClientWidth     =   13455
   BeginProperty Font 
      Name            =   "宋体"
      Size            =   10.5
      Charset         =   134
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8805
   ScaleWidth      =   13455
   StartUpPosition =   3  '窗口缺省
   Begin VB.PictureBox Picture4 
      Appearance      =   0  'Flat
      BackColor       =   &H00D67563&
      ForeColor       =   &H80000008&
      Height          =   7500
      Left            =   9195
      ScaleHeight     =   7470
      ScaleWidth      =   135
      TabIndex        =   12
      ToolTipText     =   "关闭/打开信息窗口"
      Top             =   1185
      Width           =   165
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H00D67563&
      ForeColor       =   &H80000008&
      Height          =   7605
      Left            =   60
      TabIndex        =   4
      Top             =   1080
      Width           =   9150
      Begin VB.PictureBox Picture2 
         Appearance      =   0  'Flat
         BackColor       =   &H00D67563&
         ForeColor       =   &H80000008&
         Height          =   405
         Index           =   0
         Left            =   30
         ScaleHeight     =   375
         ScaleWidth      =   9045
         TabIndex        =   5
         Top             =   165
         Width           =   9075
         Begin VB.PictureBox picDesc 
            Appearance      =   0  'Flat
            AutoRedraw      =   -1  'True
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
            Height          =   375
            Index           =   0
            Left            =   2010
            ScaleHeight     =   345
            ScaleWidth      =   2640
            TabIndex        =   10
            Top             =   0
            Width           =   2670
         End
         Begin VB.PictureBox picComm 
            Appearance      =   0  'Flat
            AutoRedraw      =   -1  'True
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
            Height          =   375
            Index           =   0
            Left            =   4665
            ScaleHeight     =   345
            ScaleWidth      =   2175
            TabIndex        =   9
            Top             =   0
            Width           =   2205
         End
         Begin VB.PictureBox picIP 
            Appearance      =   0  'Flat
            AutoRedraw      =   -1  'True
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
            Height          =   375
            Index           =   0
            Left            =   0
            ScaleHeight     =   345
            ScaleWidth      =   1995
            TabIndex        =   8
            Top             =   0
            Width           =   2025
         End
         Begin VB.PictureBox Picture1 
            Appearance      =   0  'Flat
            AutoRedraw      =   -1  'True
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
            Height          =   375
            Index           =   0
            Left            =   7950
            ScaleHeight     =   345
            ScaleWidth      =   1080
            TabIndex        =   7
            Top             =   0
            Width           =   1110
         End
         Begin VB.PictureBox picStatus 
            Appearance      =   0  'Flat
            BackColor       =   &H00D67563&
            ForeColor       =   &H80000008&
            Height          =   375
            Index           =   0
            Left            =   6855
            Picture         =   "Form1.frx":0000
            ScaleHeight     =   345
            ScaleWidth      =   1080
            TabIndex        =   6
            Top             =   0
            Width           =   1110
         End
      End
   End
   Begin VB.TextBox Text4 
      Appearance      =   0  'Flat
      BackColor       =   &H00D67563&
      ForeColor       =   &H00FFFFFF&
      Height          =   7500
      Left            =   9360
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   1185
      Width           =   4020
   End
   Begin VB.Frame pnlTop 
      Appearance      =   0  'Flat
      BackColor       =   &H00993300&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000006&
      Height          =   1005
      Left            =   0
      TabIndex        =   0
      Top             =   60
      Width           =   13410
      Begin VB.Timer Timer2 
         Interval        =   10
         Left            =   7890
         Top             =   420
      End
      Begin VB.PictureBox Picture3 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         ForeColor       =   &H000000FF&
         Height          =   375
         Left            =   10605
         Picture         =   "Form1.frx":13AA
         ScaleHeight     =   345
         ScaleWidth      =   1080
         TabIndex        =   11
         Top             =   180
         Visible         =   0   'False
         Width           =   1110
      End
      Begin VB.Timer Timer1 
         Interval        =   3000
         Left            =   7065
         Top             =   420
      End
      Begin VB.Timer TimerTimeOut 
         Interval        =   1000
         Left            =   6645
         Top             =   420
      End
      Begin MSWinsockLib.Winsock wskControl 
         Left            =   4455
         Top             =   420
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   393216
      End
      Begin MSWinsockLib.Winsock wskXChange 
         Left            =   5295
         Top             =   420
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   393216
         Protocol        =   1
      End
      Begin MSWinsockLib.Winsock wskBroadCast 
         Left            =   4035
         Top             =   420
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   393216
         Protocol        =   1
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "欢迎，撒花，致辞。"
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   18
            Charset         =   134
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   360
         Index           =   9
         Left            =   555
         TabIndex        =   2
         Top             =   315
         Width           =   3375
      End
      Begin VB.Label lblStartJustALabel 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "信息:"
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   180
         Index           =   2
         Left            =   9405
         TabIndex        =   1
         Top             =   735
         Width           =   450
      End
   End
   Begin VB.Menu mnConnect 
      Caption         =   "设定连接"
      Visible         =   0   'False
      Begin VB.Menu mnNet2Serial 
         Caption         =   "网络->信道"
         Begin VB.Menu mnLabel1 
            Caption         =   "来自网络的数据将被转发至选定信道(选择此项以取消所有数据发送)"
         End
         Begin VB.Menu mnLine1 
            Caption         =   "-"
         End
         Begin VB.Menu mnNComm 
            Caption         =   "信道0"
            Index           =   0
            Visible         =   0   'False
         End
      End
      Begin VB.Menu mnSerial2Net 
         Caption         =   "信道->网络"
         Begin VB.Menu mnLabel2 
            Caption         =   "来自信道的数据将被转发至网络(选择此项以取消所有数据发送)"
         End
         Begin VB.Menu mnLine2 
            Caption         =   "-"
         End
         Begin VB.Menu mnSComm 
            Caption         =   "信道0"
            Index           =   0
            Visible         =   0   'False
         End
      End
   End
   Begin VB.Menu mnCon 
      Caption         =   "连接"
      Visible         =   0   'False
      Begin VB.Menu mnConn 
         Caption         =   "连接"
      End
      Begin VB.Menu mnDisconnect 
         Caption         =   "断开"
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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



'GUID
Private Const m_MapFile = "{A2EE168A-E017-478d-9630-721F32B557B0}"


'自定义格式之类

Private Const MAXCLIENT = 18

Private Type Client
      IP As String
      HostName As String
      CommToNet As Integer
      CommFromNet As Integer
      bConnected As Boolean
      iTick(2) As Long
      Index As Integer
      iTickPos As Integer
      TimeOut As Integer
      Token As String
End Type

Private m_bwskBroadCastInit As Boolean
Private m_bIsSTesting As Boolean
Private m_IndexFromPort(255) As Integer
Private m_hMappingFilePtr(MAXCLIENT) As Long
Private m_hMappingRFilePtr(MAXCLIENT) As Long

Dim m_Clients(MAXCLIENT) As Client
Dim m_cIndex As String





Private Sub Form_Load()

Dim i As Integer
Dim hKey As Long
Dim cnt As Long
Dim strkm As String
Dim strkv As String
Dim lenData As Long, typeData As Long
Dim Security As SECURITY_ATTRIBUTES
Dim MapHandle As Long
Dim RMapHandle As Long

Dim path As String



      m_bIsSTesting = False
      
      


      With wskControl
            .Close
            .Protocol = sckUDPProtocol
            .RemoteHost = "255.255.255.255"
            .RemotePort = 7500
            .LocalPort = "7500"
            .Bind
      End With
      
      With wskXChange
        .Close
        .Protocol = sckUDPProtocol
        .LocalPort = 7600
        .Bind
      End With
      
      
      pnlTop.Left = 0
      pnlTop.Top = 0
      pnlTop.Width = Me.ScaleWidth
      
      Picture2(0).Left = 30
      Picture2(0).Top = 135
      Picture2(0).Width = Frame1.Width - 60
      
      picIP(0).Print "          IP 地 址"
      picDesc(0).Print "          计  算  机  名"
      picComm(0).Print "  发送               接收"
      Picture1(0).Print "   网  速"
      
      
      For i = 1 To MAXCLIENT
            Load Picture2(i)
            Load picIP(i)
            Load picDesc(i)
            Load picComm(i)
            Load Picture1(i)
            Load picStatus(i)
            Picture2(i).Top = Picture2(i - 1).Top + Picture2(i - 1).Height - Screen.TwipsPerPixelY
             Picture2(i).Left = Picture2(i - 1).Left
            Picture2(i).Width = Picture2(i - 1).Width
            Picture2(i).Height = Picture2(i - 1).Height
            Picture2(i).Visible = True
            Picture2(i).AutoRedraw = True
            Picture2(i).ForeColor = Picture2(0).ForeColor
            SetParent picIP(i).hWnd, Picture2(i).hWnd
            SetParent picDesc(i).hWnd, Picture2(i).hWnd
            SetParent picComm(i).hWnd, Picture2(i).hWnd
            SetParent Picture1(i).hWnd, Picture2(i).hWnd
            SetParent picStatus(i).hWnd, Picture2(i).hWnd
            
            With picIP(i)
                  .Visible = True
                  .AutoRedraw = True
            End With
            With picDesc(i)
                  .Visible = True
                  .AutoRedraw = True
            End With
            With picComm(i)
                  .Visible = True
                  .AutoRedraw = True
            End With
            With Picture1(i)
                  .Visible = True
                  .AutoRedraw = True
            End With
            With picStatus(i)
                  .Visible = True
                  .Picture = Nothing
            End With
      Next i

        
        With Security
            .bInheritHandle = 0
            .lpSecurityDescriptor = 0
            .nLength = Len(Security)
        End With
        
        
        For i = 1 To MAXCLIENT
            Load mnNComm(i)
            Load mnSComm(i)
            mnNComm(i).Caption = "信道 " & i
            mnSComm(i).Caption = "信道 " & i
            mnNComm(i).Visible = True
            mnSComm(i).Visible = True
            
            
            '发送信道。标识"S"
            '但实际上本程序从这个信道读取数据
            path = m_MapFile & "S" & Trim(Str(i))
            MapHandle = OpenFileMapping(FILE_MAP_ALL_ACCESS, PAGE_READWRITE, path)
            If MapHandle = 0 Then
                MapHandle = CreateFileMapping(&HFFFFFFFF, Security, PAGE_READWRITE, 0, 1024, path)
                If MapHandle = 0 Then
                    MsgBox "共享文件错误。。可能需要重启计算机。"
                    End
                End If
            End If
            m_hMappingFilePtr(i) = MapViewOfFile(MapHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0)
            'CloseHandle MapHandle
            
            '标识为"R"的接收信道
            '从网络接收到的数据将被写入这个信道
            path = m_MapFile & "R" & Trim(Str(i))
            RMapHandle = OpenFileMapping(FILE_MAP_ALL_ACCESS, PAGE_READWRITE, path)
            If RMapHandle = 0 Then
                RMapHandle = CreateFileMapping(&HFFFFFFFF, Security, PAGE_READWRITE, 0, 1024, path)
                If RMapHandle = 0 Then
                    MsgBox "共享文件错误。。可能需要重启计算机。"
                    End
                End If
            End If
            m_hMappingRFilePtr(i) = MapViewOfFile(RMapHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0)
            'CloseHandle RMapHandle
            
            
        Next i

        Me.Show
        Me.Width = 9450
        

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

wskBroadCast.Close
wskControl.Close


End Sub

Private Function BroadCastInit() As Boolean

wskBroadCast.Close
wskBroadCast.Protocol = sckUDPProtocol
wskBroadCast.RemoteHost = "255.255.255.255"
wskBroadCast.RemotePort = "7000"
wskBroadCast.LocalPort = "7000"
wskBroadCast.Bind

m_bwskBroadCastInit = True
BroadCastInit = True

End Function

Private Sub Frame1_DragDrop(Source As Control, X As Single, Y As Single)

End Sub

Private Sub Label2_Click(Index As Integer)

End Sub

Private Sub mnConn_Click()

      wskControl.RemoteHost = m_Clients(m_cIndex).IP
      wskControl.SendData "GIVEMEATOKEN"
      
End Sub

Private Sub mnDisconnect_Click()

      wskControl.RemoteHost = m_Clients(m_cIndex).IP
      wskControl.SendData "DISCONNECT"
      m_Clients(m_cIndex).bConnected = False
      DEBUG_SHOWMESSAGE ("已与" & wskControl.RemoteHostIP & "断开连接.")
       
End Sub

Private Sub mnLabel1_Click()
Dim i As Integer

      For i = 1 To MAXCLIENT
            mnNComm(i).Checked = False
      Next i

      m_Clients(m_cIndex).CommFromNet = 0
      
      
End Sub

Private Sub mnLabel2_Click()
Dim i As Integer

      For i = 1 To MAXCLIENT
            mnSComm(i).Checked = False
      Next i

      m_Clients(m_cIndex).CommToNet = 0
      
End Sub

Private Sub mnNComm_Click(Index As Integer)

      Dim i As Integer
      
      For i = 1 To MAXCLIENT
            mnNComm(i).Checked = False
      Next i
      mnNComm(Index).Checked = True
      
      i = Val(Mid(mnNComm(Index).Caption, 4))
      
      m_Clients(m_cIndex).CommFromNet = i
      
End Sub

Private Sub mnSComm_Click(Index As Integer)

      Dim i As Integer
      
      For i = 1 To MAXCLIENT
            mnSComm(i).Checked = False
      Next i
      mnSComm(Index).Checked = True
      
      i = Val(Mid(mnSComm(Index).Caption, 4))
      
      m_Clients(m_cIndex).CommToNet = i
      
End Sub

Private Sub MSComm1_OnComm(Index As Integer)

End Sub

Private Sub picComm_MouseUp(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)

Dim i As Integer



      If Index = 0 Then Exit Sub
      
      For i = 1 To MAXCLIENT
            If m_Clients(i).Index = Index Then
                  Exit For
            End If
      Next i
      
      If i > MAXCLIENT Then Exit Sub
      
      If m_Clients(i).IP = "" Then Exit Sub
      
      
      
      If 2 = Button Then
            m_cIndex = i
            
            For i = 1 To MAXCLIENT
                  mnNComm(i).Checked = False
                  mnSComm(i).Checked = False
            Next i
            
            mnNComm(m_Clients(m_cIndex).CommFromNet).Checked = True
            mnSComm(m_Clients(m_cIndex).CommToNet).Checked = True
            
            Me.PopupMenu mnConnect
      
      End If
      
End Sub

Private Sub picStatus_MouseUp(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)

Dim i As Integer


      If Index = 0 Then
            Exit Sub
      End If
      
      For i = 1 To MAXCLIENT
            If m_Clients(i).Index = Index Then
                  Exit For
            End If
      Next i
      
      If i > MAXCLIENT Then Exit Sub
      
      If m_Clients(i).IP = "" Then Exit Sub
      
      
      If Button = 2 Then
            m_cIndex = i
            
            mnConn.Enabled = True
            mnDisconnect.Enabled = True
            
            If m_Clients(i).bConnected Then
                  mnConn.Enabled = False
            Else
                  mnDisconnect.Enabled = False
            End If
            
            Me.PopupMenu mnCon
      End If

      
End Sub

Private Sub Picture4_Click()

      If Me.Width = 13545 Then
            Me.Width = 9450
      Else
            Me.Width = 13545
      End If
      
End Sub

Private Sub Timer1_Timer()

      If m_bwskBroadCastInit = False Then BroadCastInit
      
      wskBroadCast.SendData "IAMASERVER"
      
      
End Sub

Private Sub Timer2_Timer()
    
    Dim szCont As String * 1024
    Dim i As Integer
    Dim j As Integer
    
    
      For i = 1 To MAXCLIENT
            szCont = String(1024, " ")
            lstrcpyL2S ByVal szCont, m_hMappingFilePtr(i)
            szCont = Trim(szCont)
            j = lstrlen(szCont)
            szCont = Left(szCont, j)
            If j >= 1 Then
                  For j = 1 To MAXCLIENT
                        If m_Clients(j).IP <> "" Then
                              If m_Clients(j).CommToNet = i And m_Clients(j).bConnected = True Then
                                  wskXChange.RemoteHost = m_Clients(j).IP
                                  wskXChange.RemotePort = 7600
                                  wskXChange.SendData szCont
                              End If
                        End If
                  Next j
            lstrcpyS2L m_hMappingFilePtr(i), ""
            End If
      Next i

wher:
      Err.Clear
      
End Sub

Private Sub TimerTimeOut_Timer()

      Dim i As Integer
      For i = 1 To MAXCLIENT
            m_Clients(i).TimeOut = m_Clients(i).TimeOut + 1
            If m_Clients(i).TimeOut > 30 Then
                  m_Clients(i).IP = ""
            End If
      Next i
      
      RefreshClientInfo
      
End Sub

Private Sub wskBroadCast_DataArrival(ByVal bytesTotal As Long)

      Dim msg As String
      Dim cPacket As New Packet
            
      msg = String(bytesTotal + 1, " ")
      wskBroadCast.GetData msg
     
      'DEBUG_SHOWMESSAGE ("收到广播消息,来源:" & wskBroadCast.RemoteHostIP & "内容:" & msg)
      
      
      wskBroadCast.RemoteHost = "255.255.255.255"
     
     

      wskControl.RemoteHost = wskBroadCast.RemoteHostIP
      wskControl.RemotePort = 7500


      cPacket.MakeHandshakePacket
      
      wskControl.SendData cPacket.GetData
     

End Sub


Private Sub wskControl_DataArrival(ByVal bytesTotal As Long)
      
      Dim msg As String
      Dim cPacket As Packet
      Set cPacket = New Packet
      Dim i As Integer
      Dim spd As Single
      
      
      msg = String(bytesTotal + 1, " ")
      
      wskControl.GetData msg
      
      'DEBUG_SHOWMESSAGE ("收到控制消息,来源:" & wskControl.RemoteHostIP & "内容:" & msg)
      
      cPacket.Packet msg
      cPacket.Parse
      
      If PACKET_HANDSHAKE = cPacket.ControlWord Then
      
      '连接握手
            
            If cPacket.MakeHandshakePacket Then
                  wskControl.SendData cPacket.GetData
            Else
                  i = CheckClient(wskControl.RemoteHostIP)
                  If i > 0 Then m_Clients(i).HostName = cPacket.GetData
            End If

            
            If CheckClient(wskControl.RemoteHostIP) = 0 Then
                  AddClient wskControl.RemoteHostIP, ""
            End If
                  
            i = CheckClient(wskControl.RemoteHostIP)
            
            m_Clients(i).iTick(m_Clients(i).iTickPos) = GetTickCount()
            m_Clients(i).iTickPos = 1 - m_Clients(i).iTickPos
            m_Clients(i).TimeOut = 0

            
            If Left(cPacket.GetData, 2) = "ID" Then
                  spd = (m_Clients(i).iTick(1) - m_Clients(i).iTick(0)) / 2
                  spd = Abs(spd)
                  If spd < 100 Then
                        msg = "优秀"
                  ElseIf spd < 500 Then
                        msg = "良好"
                  Else
                        msg = "极差"
                  End If
                  DEBUG_SHOWMESSAGE ("客户端:" & wskControl.RemoteHostIP & "速度:" & Str(spd) & "毫秒 " & msg)
            End If
            
       ElseIf PACKET_TOKENREQUEST = cPacket.ControlWord Then
             
       '对方请求令牌
                 
            Randomize (Timer)
            msg = ""
            For i = 1 To 64
                  msg = msg & Chr(Int(Rnd(Timer) * 26) + 65)
            Next i
            wskControl.SendData "TOKEN" & msg
            i = CheckClient(wskControl.RemoteHostIP)
            m_Clients(i).Token = msg
            
       ElseIf PACKET_TOKEN = cPacket.ControlWord Then
       
       '对方返回令牌
       
            i = CheckClient(wskControl.RemoteHostIP)
            
            If m_Clients(i).Token = cPacket.GetData Then
            Else
                  m_Clients(i).Token = cPacket.GetData
                  wskControl.SendData "TOKEN" & cPacket.GetData
            End If
            m_Clients(i).bConnected = True
            
            DEBUG_SHOWMESSAGE ("已与" & wskControl.RemoteHostIP & "建立连接.")
            DEBUG_SHOWMESSAGE ("令牌:" & vbCrLf & m_Clients(i).Token)
      
       ElseIf PACKET_DISCONNECT = cPacket.ControlWord Then
            
       '断开连接
       
            i = CheckClient(wskControl.RemoteHostIP)
            m_Clients(i).bConnected = False
            m_Clients(i).Token = ""
            DEBUG_SHOWMESSAGE ("已与" & wskControl.RemoteHostIP & "断开连接.")
       
       End If



End Sub



Private Sub DEBUG_SHOWMESSAGE(msg As String)

      If Me.Width = 13545 Then
            If Len(Text4.Text) > 1000 Then Text4.Text = ""
            Text4.Text = Text4.Text & msg & vbCrLf
            Text4.SelStart = Len(Text4.Text)
            Text4.SelLength = 1
      End If
      
End Sub




Private Sub RefreshClientInfo()

      Dim i As Integer
      Dim Index As Integer
      Dim t As Single
      
      
      Index = 1
      
      For i = 1 To MAXCLIENT
            picIP(i).Cls
            picDesc(i).Cls
            picComm(i).Cls
            picStatus(i).Picture = Nothing
            Picture1(i).Cls
      Next i
      
      For i = 1 To MAXCLIENT
            If m_Clients(i).IP <> "" Then
                  picIP(Index).Print " " & m_Clients(i).IP
                  picDesc(Index).Print " " & m_Clients(i).HostName
                  picComm(i).Print "  Chn " & m_Clients(i).CommToNet & "->Net->" & "Chn " & m_Clients(i).CommFromNet
                  picStatus(i).Picture = IIf(m_Clients(i).bConnected, Picture3.Picture, picStatus(0).Picture)
                  
                  If m_Clients(i).TimeOut <= 5 Then
                        t = Abs((m_Clients(i).iTick(1) - m_Clients(i).iTick(0)) / 2)
                        
                        If t < 100 Then
                              Picture1(i).ForeColor = &HFF00&
                        ElseIf t < 500 Then
                              Picture1(i).ForeColor = &HFFFF&
                        Else
                              Picture1(i).ForeColor = &HFF&
                        End If
                        
                        Picture1(i).Print Str(t) & " 毫秒"
                  Else
                        Picture1(i).ForeColor = &H993300
                        Picture1(i).FillColor = &H993300
                        Picture1(i).Line ((m_Clients(i).TimeOut - 5) / 25 * Picture1(i).ScaleWidth, 0)-(Picture1(i).ScaleWidth, Picture1(i).ScaleHeight), , BF
                        Picture1(i).ForeColor = &HFF
                        Picture1(i).Print "超时"
                  End If
                  
                  m_Clients(i).Index = Index
                  Index = Index + 1
                  
            End If
            
      Next i

End Sub


Private Function AddClient(IP As String, HostName As String) As Boolean

      Dim i As Integer
  
      If CheckClient(IP) > 0 Then
            AddClient = False
            Exit Function
      End If
      
      Dim pIniFile As New clsTIniFile
    
      Dim chn1 As Integer
      Dim chn2 As Integer
      Dim msg As String
      
      pIniFile.Initialize App.path & "\config.ini"
      msg = pIniFile.ReadString("IPAddress", IP, "0.0")
      msg = Trim(msg)
      chn1 = Int(Val(msg))
        
        For i = 1 To Len(msg)
            If (Mid(msg, i, 1) = ".") Then
                Exit For
            End If
        Next i
        msg = Trim(Mid(msg, i + 1))
        chn2 = Int(Val(msg))
        
        
      
      
      For i = 1 To MAXCLIENT
            If m_Clients(i).IP = "" Then
                  m_Clients(i).IP = IP
                  m_Clients(i).HostName = HostName
                  m_Clients(i).iTickPos = 0
                  m_Clients(i).bConnected = False
                  m_Clients(i).CommToNet = chn1
                  m_Clients(i).CommFromNet = chn2
                  RefreshClientInfo
                  AddClient = True
                  Exit Function
            End If
      Next i
      
      AddClient = False
      
End Function

Private Function CheckClient(IP As String) As Integer
      
      Dim i As Integer
      Dim FLAG As Integer
      
      FLAG = False
      For i = 1 To MAXCLIENT
            If m_Clients(i).IP = IP Then
                  FLAG = True
                  Exit For
            End If
      Next i
      
      CheckClient = IIf(FLAG, i, 0)
      
End Function




Private Sub wskXChange_DataArrival(ByVal bytesTotal As Long)
      
      Dim msg As String * 1024
      Dim i As Integer
      
      msg = String(1024, " ")
      wskXChange.GetData msg
      
      i = CheckClient(wskXChange.RemoteHostIP)
      
      msg = Trim(Left(msg, lstrlen(msg) - 1))
      
      
      DEBUG_SHOWMESSAGE "收到来自" & wskXChange.RemoteHostIP & "的数据:" & vbCrLf & msg
      
      If i = 0 Then Exit Sub
      
      lstrcpyS2L m_hMappingRFilePtr(m_Clients(i).CommFromNet), ByVal msg
      

End Sub

