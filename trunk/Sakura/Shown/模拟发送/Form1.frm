VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Object = "{EDE925E9-F18B-4316-8AB3-F5D6A6241846}#73.0#0"; "Channel.ocx"
Begin VB.Form Form1 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form1"
   ClientHeight    =   9090
   ClientLeft      =   195
   ClientTop       =   435
   ClientWidth     =   7185
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   9090
   ScaleWidth      =   7185
   Begin 工程2.Channel Channel1 
      Left            =   315
      Top             =   6270
      _ExtentX        =   2275
      _ExtentY        =   1138
   End
   Begin VB.CheckBox Check5 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "显示结果"
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   210
      TabIndex        =   59
      Top             =   5595
      Value           =   1  'Checked
      Width           =   1035
   End
   Begin VB.ComboBox Combo7 
      Appearance      =   0  'Flat
      Height          =   300
      ItemData        =   "Form1.frx":0000
      Left            =   150
      List            =   "Form1.frx":000D
      Style           =   2  'Dropdown List
      TabIndex        =   53
      Top             =   4095
      Width           =   1290
   End
   Begin VB.ComboBox Combo6 
      Appearance      =   0  'Flat
      Height          =   300
      ItemData        =   "Form1.frx":001C
      Left            =   150
      List            =   "Form1.frx":002F
      Style           =   2  'Dropdown List
      TabIndex        =   51
      Top             =   3330
      Width           =   1290
   End
   Begin VB.ComboBox Combo4 
      Appearance      =   0  'Flat
      Height          =   300
      ItemData        =   "Form1.frx":0042
      Left            =   150
      List            =   "Form1.frx":0055
      Style           =   2  'Dropdown List
      TabIndex        =   49
      Top             =   2550
      Width           =   1290
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   120
      Top             =   4545
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.ComboBox Combo3 
      Appearance      =   0  'Flat
      Height          =   300
      ItemData        =   "Form1.frx":00A7
      Left            =   150
      List            =   "Form1.frx":00D2
      Style           =   2  'Dropdown List
      TabIndex        =   47
      Top             =   1755
      Width           =   1290
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   285
      Top             =   675
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
   End
   Begin VB.Frame Frame2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "按文件"
      ForeColor       =   &H80000008&
      Height          =   8865
      Left            =   1440
      TabIndex        =   40
      Top             =   735
      Width           =   5490
      Begin VB.Timer Timer2 
         Left            =   4095
         Top             =   180
      End
      Begin VB.CheckBox Check4 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "循环"
         ForeColor       =   &H80000008&
         Height          =   240
         Left            =   2640
         TabIndex        =   46
         Top             =   240
         Width           =   675
      End
      Begin VB.TextBox Text7 
         Appearance      =   0  'Flat
         Height          =   4905
         Left            =   120
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   45
         Top             =   3780
         Width           =   5250
      End
      Begin VB.TextBox Text6 
         Appearance      =   0  'Flat
         Height          =   3060
         Left            =   135
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   44
         Text            =   "Form1.frx":012A
         Top             =   675
         Width           =   5235
      End
      Begin VB.ComboBox Combo2 
         Appearance      =   0  'Flat
         Height          =   300
         ItemData        =   "Form1.frx":0130
         Left            =   150
         List            =   "Form1.frx":014C
         Style           =   2  'Dropdown List
         TabIndex        =   43
         Top             =   240
         Width           =   2355
      End
      Begin VB.TextBox Text5 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   270
         Left            =   3375
         TabIndex        =   42
         Text            =   "1000"
         Top             =   240
         Width           =   780
      End
      Begin VB.CheckBox Check3 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "发送"
         ForeColor       =   &H80000008&
         Height          =   270
         Left            =   4335
         Style           =   1  'Graphical
         TabIndex        =   41
         Top             =   240
         Width           =   1005
      End
   End
   Begin VB.OptionButton Option1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "按文件"
      ForeColor       =   &H80000008&
      Height          =   450
      Index           =   1
      Left            =   90
      Style           =   1  'Graphical
      TabIndex        =   39
      Top             =   765
      Width           =   1380
   End
   Begin VB.OptionButton Option1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "按数据"
      ForeColor       =   &H80000008&
      Height          =   450
      Index           =   0
      Left            =   90
      Style           =   1  'Graphical
      TabIndex        =   38
      Top             =   195
      Width           =   1380
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "按数据"
      ForeColor       =   &H80000008&
      Height          =   8865
      Left            =   1590
      TabIndex        =   0
      Top             =   90
      Width           =   5490
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   16
         Left            =   3645
         TabIndex        =   58
         Top             =   2790
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   17
         Left            =   4530
         TabIndex        =   57
         Top             =   2790
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   10
         Left            =   3645
         TabIndex        =   56
         Top             =   1965
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   11
         Left            =   4530
         TabIndex        =   55
         Top             =   1965
         Width           =   795
      End
      Begin VB.Timer Timer1 
         Left            =   3810
         Top             =   180
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   13
         Left            =   1020
         MaxLength       =   2
         TabIndex        =   37
         Text            =   "2E"
         Top             =   2430
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   12
         Left            =   150
         MaxLength       =   2
         TabIndex        =   36
         Text            =   "35"
         Top             =   2430
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   15
         Left            =   2760
         TabIndex        =   35
         Top             =   2790
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   17
         Left            =   4515
         MaxLength       =   2
         TabIndex        =   34
         Text            =   "0A"
         Top             =   2430
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   14
         Left            =   1890
         TabIndex        =   33
         Top             =   2790
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   16
         Left            =   3645
         MaxLength       =   2
         TabIndex        =   32
         Text            =   "0D"
         Top             =   2430
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   13
         Left            =   1020
         TabIndex        =   31
         Top             =   2790
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   15
         Left            =   2775
         MaxLength       =   2
         TabIndex        =   30
         Text            =   "2C"
         Top             =   2430
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   12
         Left            =   150
         TabIndex        =   29
         Top             =   2790
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   14
         Left            =   1905
         MaxLength       =   2
         TabIndex        =   28
         Text            =   "30"
         Top             =   2430
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   7
         Left            =   1035
         MaxLength       =   2
         TabIndex        =   27
         Text            =   "31"
         Top             =   1605
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   6
         Left            =   150
         MaxLength       =   2
         TabIndex        =   26
         Text            =   "30"
         Top             =   1605
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   9
         Left            =   2760
         TabIndex        =   25
         Top             =   1965
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   11
         Left            =   4515
         MaxLength       =   2
         TabIndex        =   24
         Text            =   "30"
         Top             =   1605
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   8
         Left            =   1890
         TabIndex        =   23
         Top             =   1965
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   10
         Left            =   3645
         MaxLength       =   2
         TabIndex        =   22
         Text            =   "31"
         Top             =   1605
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   7
         Left            =   1020
         TabIndex        =   21
         Top             =   1965
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   9
         Left            =   2775
         MaxLength       =   2
         TabIndex        =   20
         Text            =   "2D"
         Top             =   1605
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   6
         Left            =   150
         TabIndex        =   19
         Top             =   1965
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   8
         Left            =   1905
         MaxLength       =   2
         TabIndex        =   18
         Text            =   "2C"
         Top             =   1605
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   1
         Left            =   1035
         TabIndex        =   17
         Top             =   1140
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   1
         Left            =   1035
         MaxLength       =   2
         TabIndex        =   16
         Text            =   "21"
         Top             =   780
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   0
         Left            =   150
         TabIndex        =   15
         Top             =   1140
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   150
         MaxLength       =   2
         TabIndex        =   14
         Text            =   "21"
         Top             =   780
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   5
         Left            =   4515
         TabIndex        =   13
         Top             =   1140
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   5
         Left            =   4515
         MaxLength       =   2
         TabIndex        =   12
         Text            =   "30"
         Top             =   780
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   4
         Left            =   3645
         TabIndex        =   11
         Top             =   1140
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   4
         Left            =   3645
         MaxLength       =   2
         TabIndex        =   10
         Text            =   "31"
         Top             =   780
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   3
         Left            =   2775
         TabIndex        =   9
         Top             =   1140
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   3
         Left            =   2775
         MaxLength       =   2
         TabIndex        =   8
         Text            =   "0A"
         Top             =   780
         Width           =   795
      End
      Begin VB.CheckBox Check1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "随机"
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   2
         Left            =   1905
         TabIndex        =   7
         Top             =   1140
         Width           =   795
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   2
         Left            =   1905
         MaxLength       =   2
         TabIndex        =   6
         Text            =   "0D"
         Top             =   780
         Width           =   795
      End
      Begin VB.ComboBox Combo1 
         Appearance      =   0  'Flat
         Height          =   300
         ItemData        =   "Form1.frx":0180
         Left            =   150
         List            =   "Form1.frx":019C
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   240
         Width           =   2355
      End
      Begin VB.TextBox Text2 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   270
         Left            =   2700
         TabIndex        =   4
         Text            =   "1000"
         Top             =   240
         Width           =   1455
      End
      Begin VB.CheckBox Check2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "发送"
         ForeColor       =   &H80000008&
         Height          =   270
         Left            =   4335
         Style           =   1  'Graphical
         TabIndex        =   3
         Top             =   240
         Width           =   1005
      End
      Begin VB.TextBox Text3 
         Appearance      =   0  'Flat
         Height          =   270
         Left            =   150
         TabIndex        =   2
         Text            =   "Text3"
         Top             =   3270
         Width           =   5190
      End
      Begin VB.TextBox Text4 
         Appearance      =   0  'Flat
         Height          =   4905
         Left            =   150
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   1
         Top             =   3795
         Width           =   5250
      End
   End
   Begin VB.Label Label5 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "停止位:"
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   150
      TabIndex        =   54
      Top             =   3795
      Width           =   870
   End
   Begin VB.Label Label4 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "数据位:"
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   150
      TabIndex        =   52
      Top             =   3030
      Width           =   870
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "奇偶校验:"
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   150
      TabIndex        =   50
      Top             =   2250
      Width           =   870
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "波特率:"
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   150
      TabIndex        =   48
      Top             =   1440
      Width           =   870
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private fStart As Long
Private sPath As String

Private Sub Check2_Click()
On Error GoTo WHENERR:

Dim st As String

      
      If Check2.Value = 1 Then
      
            SHOWMESSAGE "------------------------------"
            If MSComm1.PortOpen = True Then
                  SHOWMESSAGE "关闭串口:COM" & MSComm1.CommPort
                  MSComm1.PortOpen = False
            End If
            
            SHOWMESSAGE "正在尝试打开串口:" & Combo1.Text
            
            SHOWMESSAGE "设置串口号:"
            MSComm1.CommPort = Combo1.ListIndex + 1
            SHOWMESSAGE "...............成功."
            
            st = Combo3.Text & ", " & Left(Combo4.Text, 1) & ", " & Combo6.Text & ", " & Combo7.Text
            SHOWMESSAGE "设置串口参数:" & st
            MSComm1.Settings = st
            SHOWMESSAGE "...............成功."
            
            SHOWMESSAGE "设置串口数据格式:二进制"
            MSComm1.InputMode = comInputModeBinary                      '二进制格式数据
            SHOWMESSAGE "...............成功."
                        
            SHOWMESSAGE "设置响应数据长度..."
            MSComm1.RThreshold = 1                                      '收到触发OnComm()
            MSComm1.InputLen = 0
            SHOWMESSAGE "...............成功."
            
            SHOWMESSAGE "打开串口......"
            MSComm1.PortOpen = True
            SHOWMESSAGE "...............成功."
            
            SHOWMESSAGE "清空缓冲区......"
            MSComm1.InBufferCount = 0
            MSComm1.OutBufferCount = 0
            SHOWMESSAGE "...............成功."
            
            SHOWMESSAGE "成功打开串口:" & Combo1.Text
            SHOWMESSAGE "------------------------------"
            
            Check2.Caption = "停止"
            Option1(0).Enabled = False
            Option1(1).Enabled = False
            Combo1.Enabled = False
            
            SHOWMESSAGE "开始发送数据...时间间隔:" & Text2.Text & "毫秒."
            
            Timer1.Interval = Val(Text2.Text)
            Timer1.Enabled = True
            
            
      Else
            Timer1.Enabled = False
            
            SHOWMESSAGE "关闭串口:COM" & MSComm1.CommPort
            If MSComm1.PortOpen = True Then MSComm1.PortOpen = False
            SHOWMESSAGE "成功."
            
            
            Check2.Caption = "发送"
            Option1(0).Enabled = True
            Option1(1).Enabled = True
            Combo1.Enabled = True
      End If

Exit Sub

WHENERR:
      
      SHOWMESSAGE "------------------------------"
      SHOWMESSAGE "发生错误!"
      SHOWMESSAGE "错误代码:" & Err.Number
      SHOWMESSAGE "错误描述:" & Err.Description
      SHOWMESSAGE "------------------------------"
      Err.Clear

End Sub

Private Sub Check3_Click()
On Error GoTo WHENERR:

Dim st As String

      
      If Check3.Value = 1 Then
      
            SHOWMESSAGE "------------------------------"
            If MSComm1.PortOpen = True Then
                  SHOWMESSAGE "关闭串口:COM" & MSComm1.CommPort
                  MSComm1.PortOpen = False
            End If
            
            SHOWMESSAGE "正在尝试打开串口:" & Combo2.Text
            
            SHOWMESSAGE "设置串口号:"
            MSComm1.CommPort = Combo2.ListIndex + 1
            SHOWMESSAGE "...............成功."
            
            st = Combo3.Text & ", " & Left(Combo4.Text, 1) & ", " & Combo6.Text & ", " & Combo7.Text
            SHOWMESSAGE "设置串口参数:" & st
            MSComm1.Settings = st
            SHOWMESSAGE "...............成功."
            
            SHOWMESSAGE "设置串口数据格式:二进制"
            MSComm1.InputMode = comInputModeBinary                      '二进制格式数据
            SHOWMESSAGE "...............成功."
                        
            SHOWMESSAGE "设置响应数据长度..."
            MSComm1.RThreshold = 1                                      '收到触发OnComm()
            MSComm1.InputLen = 0
            SHOWMESSAGE "...............成功."
            
            SHOWMESSAGE "打开串口......"
            MSComm1.PortOpen = True
            SHOWMESSAGE "...............成功."
            
            SHOWMESSAGE "清空缓冲区......"
            MSComm1.InBufferCount = 0
            MSComm1.OutBufferCount = 0
            SHOWMESSAGE "...............成功."
            
            SHOWMESSAGE "成功打开串口:" & Combo2.Text
            SHOWMESSAGE "------------------------------"
            
            Check3.Caption = "停止"
            Option1(0).Enabled = False
            Option1(1).Enabled = False
            Combo2.Enabled = False
            
            SHOWMESSAGE "开始发送数据...时间间隔:" & Text5.Text & "毫秒."
            
            fStart = 1
            Timer2.Interval = Val(Text5.Text)
            Timer2.Enabled = True
            Text6.Locked = True
            
      Else
            Timer2.Enabled = False
            
            SHOWMESSAGE "关闭串口:COM" & MSComm1.CommPort
            If MSComm1.PortOpen = True Then MSComm1.PortOpen = False
            SHOWMESSAGE "成功."

            
            
            Check3.Caption = "发送"
            Option1(0).Enabled = True
            Option1(1).Enabled = True
            Combo2.Enabled = True
            Text6.Locked = False
      End If

Exit Sub

WHENERR:
      
      SHOWMESSAGE "------------------------------"
      SHOWMESSAGE "发生错误!"
      SHOWMESSAGE "错误代码:" & Err.Number
      SHOWMESSAGE "错误描述:" & Err.Description
      SHOWMESSAGE "------------------------------"
      Err.Clear
End Sub

Private Sub Form_Load()

      Frame2.Left = Frame1.Left
      Frame2.Top = Frame1.Top
      Option1(0).Value = True
      
      Combo1.ListIndex = 0
      Combo2.ListIndex = 0
      Combo3.ListIndex = 5
      Combo4.ListIndex = 2
      Combo6.ListIndex = 4
      Combo7.ListIndex = 0
      
      
End Sub

Private Sub Option1_Click(Index As Integer)

      If Index = 0 Then
            Frame1.Visible = True
            Frame2.Visible = False
            Timer2.Enabled = False
      Else
            Frame1.Visible = False
            Frame2.Visible = True
            Timer1.Enabled = False
      End If
      
End Sub


Private Sub SHOWMESSAGE(msg As String)

    If Check5.Value = False Then Exit Sub
    
      If Len(Text4.Text) >= 1000 Then Text4.Text = ""
      Text4.Text = Text4.Text & msg & vbCrLf
      Text7.Text = Text4.Text
      
End Sub

Private Sub Text4_Change()
      
      Text4.SelStart = Len(Text4.Text)
      Text4.SelLength = 1
      
End Sub

Private Sub Text6_DblClick()
On Error GoTo WHENERROR


Dim msg As String

CommonDialog1.CancelError = True
CommonDialog1.FileName = "*.txt;*.txt"
CommonDialog1.ShowOpen

sPath = CommonDialog1.FileName

Open sPath For Input As #1

Text6.Text = ""
msg = ""

While Not EOF(1)
      'DoEvents
      msg = msg & Input(1, #1)
Wend

Text6.Text = msg
Close sPath

Exit Sub

WHENERROR:
      Err.Clear

End Sub

Private Sub Text7_Change()
      Text7.SelStart = Len(Text7.Text)
      Text7.SelLength = 1
End Sub

Private Sub Timer1_Timer()

Dim msg(17) As Byte
Dim i As Integer
Dim tmp As String

tmp = ""

For i = 0 To 17
      If Check1(i).Value = 1 Then
            Text1(i).Text = Hex(Int(Rnd(Timer) * 256))
      End If
      While Len(Trim(Text1(i).Text)) < 2
            Text1(i).Text = "0" & Trim(Text1(i).Text)
      Wend
      tmp = tmp & Trim(Text1(i).Text) & " "
      msg(i) = Hex2Int(Trim(Text1(i).Text))
Next i

SHOWMESSAGE "写入数据:" & tmp

MSComm1.Output = msg

Channel1.SendDataToChannel ByVal VarPtr(msg(0)), ByVal 18

Timer1.Interval = Val(Text2.Text)

End Sub

Private Function Hex2Int(rHEX As String) As Integer

      Dim cc As Integer
      Dim str As String
      str = "0123456789ABCDEF"
      Dim i As Integer
      Dim j As Integer
      
      For i = 1 To Len(rHEX)
            If Mid(rHEX, i, 1) >= "a" And Mid(rHEX, i, 1) <= "f" Then
                  Mid(rHEX, i, 1) = Chr(Asc(Mid(rHEX, i, 1)) - Asc("a") + Asc("A"))
            End If
      Next i
      
      cc = 0
      j = 0
      For i = 1 To Len(rHEX)
            For j = 1 To 16
                  If (Mid(rHEX, Len(rHEX) - i + 1, 1) = Mid(str, j, 1)) Then
                        cc = cc + (j - 1) * 16 ^ (i - 1)
                        Exit For
                  End If
            Next
      Next
      
      Hex2Int = cc

End Function

Private Sub Timer2_Timer()
On Error GoTo wher

Dim msg() As Byte
Dim i As Long
Dim tmp As String
Dim tmp1 As String

If Check3.Value = 0 Then
      Timer2.Enabled = False
      Exit Sub
End If

tmp = Trim(GetLine())

If Len(tmp) / 2 <> Int(Len(tmp) / 2) Then
      tmp = "0" & tmp
End If

ReDim msg(Len(tmp) / 2 - 1)
tmp1 = ""

For i = 1 To Len(tmp) - 1 Step 2
      msg((i - 1) / 2) = Hex2Int(Mid(tmp, i, 2))
      tmp1 = tmp1 & Mid(tmp, i, 2) & " "
Next i

SHOWMESSAGE "写入数据:" & tmp1

MSComm1.Output = msg

Channel1.SendDataToChannel VarPtr(msg(0)), Len(tmp) / 2


Timer2.Interval = Val(Text5.Text)

wher:

End Sub


Private Function GetLine() As String

Dim tmp As String
Dim msg As String
Dim j As Integer


tmp = Chr(13) & Chr(10)

If fStart >= Len(Text6.Text) Then
      If Check4.Value = 1 Then
            fStart = 1
            msg = Text6.Text
      Else
            Check3.Value = 0
      End If
Else
      msg = Mid(Text6.Text, fStart)
End If

j = FindStr(msg, tmp, 1)

If j >= 0 Then
      msg = Mid(msg, 1, j - 1)
End If

GetLine = msg

If j = -1 Then
      fStart = Len(Text6.Text)
Else
      fStart = fStart + j + 1
End If

End Function

Private Function FindStr(ByVal str1 As String, ByVal str2 As String, ByVal Start As Integer) As Integer

Dim i As Integer
      
      If Len(str1) < Len(str2) Then
            FindStr = -1
            Exit Function
      End If
      
      For i = Start To Len(str1) - Len(str2) + 1
            If Mid(str1, i, Len(str2)) = str2 Then
                  FindStr = i
                  Exit Function
            End If
      Next i
      
      FindStr = -1
      
End Function




