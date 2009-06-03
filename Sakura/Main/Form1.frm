VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form frmMain 
   BackColor       =   &H00000000&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "多子系统信息集成系统"
   ClientHeight    =   5325
   ClientLeft      =   10290
   ClientTop       =   630
   ClientWidth     =   7020
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   5325
   ScaleWidth      =   7020
   StartUpPosition =   2  '屏幕中心
   Begin MSWinsockLib.Winsock Winsock1 
      Left            =   1995
      Top             =   1845
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.Menu mnu_file 
      Caption         =   "操作"
      Begin VB.Menu mnu_Show 
         Caption         =   "本地程序列表"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnSetup 
         Caption         =   "网络应用程序配置"
      End
      Begin VB.Menu mnServer 
         Caption         =   "伺服程序运行状态"
      End
      Begin VB.Menu mnSpliter1 
         Caption         =   "-"
      End
      Begin VB.Menu mnu_Exit 
         Caption         =   "退出"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim mnuMain As Menu
Private Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long



Private m_QuitToken As Integer
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Private Const HWND_TOPMOST = -1

Private Const SWP_NOSIZE = &H1

Private Const SWP_NOMOVE = &H2

Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long






Private Sub Form_Load()



    mnumail = mnu_file
    Set TheForm = Me
    Set TheMenu = mnuMain
    
    frmChild.Show
    
    SetParent frmChild.hwnd, Me.hwnd
    frmChild.Move 0, 360
    
    
    Me.Height = 3500 + frmChild.Height
    Me.Width = frmChild.Width
    
    m_QuitToken = 0
    
    
    Me.Show
    
    SetWindowPos Me.hwnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE Or SWP_NOMOVE
    
    With Winsock1
        .Close
        .Protocol = sckUDPProtocol
        .LocalPort = 7446
        .Bind
    End With
    
    'Me.WindowState = vbMinimized
        
    If Command <> "DEBUG" Then
        Shell "Server.exe HIDE", vbHide
        Shell "Setup.exe HIDE", vbHide
    End If
    
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If m_QuitToken = 0 Then
        Me.WindowState = vbMinimized
        Cancel = 1
    ElseIf m_QuitToken = 1 Then
        QuitSystem
    End If
    
End Sub

Private Sub Form_Resize()
     '最小化的时候显示托盘
    Dim mnuMain As Menu
          If Me.WindowState = vbMinimized Then
                  Me.Hide
                  '添加系统托盘
                  AddToTray Me, mnuMain                 '加载系统托盘
                  SetTrayTip "多子系统信息集成系统"     '托盘Tip
                  mnu_Show.Enabled = True
          Else
                  RemoveFromTray                        '去掉系统托盘图标
          End If
End Sub

Private Sub mnServer_Click()
      
      ShowClientWindow True, False
      
End Sub

Private Sub mnSetup_Click()
      
      ShowClientWindow False, True
      
End Sub

Private Sub mnu_Exit_Click()
    m_QuitToken = 1
    Unload Me
End Sub

Private Sub mnu_Show_Click()
    If Me.WindowState = vbMinimized Then
        RemoveFromTray                                  '去掉系统托盘图标
        Me.WindowState = vbNormal
        Me.Show
        mnu_Show.Enabled = False
    End If
End Sub




Private Sub QuitSystem()
    
    
On Error Resume Next

    Dim cmd As Byte
    
    cmd = CMD_EXIT
    
    Winsock1.RemoteHost = "127.0.0.1"
    Winsock1.RemotePort = 7444
    Winsock1.SendData cmd
    DoEvents
    Winsock1.RemoteHost = "127.0.0.1"
    Winsock1.RemotePort = 7445
    Winsock1.SendData cmd
    RemoveFromTray
    
    Unload frmChild
    'End
    
End Sub


Private Sub ShowClientWindow(Server As Boolean, Setup As Boolean)

    Dim cmd As Byte
    
    
    cmd = CMD_SHOWWINDOW
    
    Winsock1.RemoteHost = "127.0.0.1    "
    If Server = True Then
        Winsock1.RemotePort = 7444
        Winsock1.SendData cmd
        DoEvents
    End If
    
    If Setup = True Then
        Winsock1.RemotePort = 7445
        Winsock1.SendData cmd
    End If

End Sub

Private Sub Winsock1_DataArrival(ByVal bytesTotal As Long)

On Error GoTo WHR

    Dim cmd() As Byte
    
    Winsock1.GetData cmd
    
    Select Case cmd(0)
        Case CMD_SHOWWINDOW
            RemoveFromTray
            Me.WindowState = vbNormal
            Me.Show
            mnu_Show.Enabled = False
        Case CMD_REFRESHLOCALFILE
            Unload frmChild
            Load frmChild
            frmChild.Show
            SetParent frmChild.hwnd, Me.hwnd
            frmChild.Move 0, 360
            Me.Height = 3500 + frmChild.Height
            Me.Width = frmChild.Width
            Shell "Setup.exe HIDE", vbHide
            ShowClientWindow False, True
    End Select
    
    
WHR:
    Err.Clear
    Exit Sub
    
End Sub

