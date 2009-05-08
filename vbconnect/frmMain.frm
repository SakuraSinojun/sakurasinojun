VERSION 5.00
Begin VB.Form frmMain 
   Caption         =   "VB连接STK"
   ClientHeight    =   8190
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6030
   LinkTopic       =   "Form1"
   ScaleHeight     =   8190
   ScaleWidth      =   6030
   StartUpPosition =   3  '窗口缺省
   Begin VB.CommandButton cmdSetTimeout 
      Caption         =   "设置响应时间"
      Height          =   375
      Left            =   4080
      TabIndex        =   16
      Top             =   1080
      Width           =   1695
   End
   Begin VB.TextBox txtTimeout 
      Height          =   375
      Left            =   1800
      TabIndex        =   15
      Text            =   "30"
      Top             =   1080
      Width           =   2055
   End
   Begin VB.TextBox txtLineNumber 
      Height          =   375
      Left            =   2640
      TabIndex        =   11
      Text            =   "0"
      Top             =   3120
      Width           =   1215
   End
   Begin VB.CommandButton cmdEchoLine 
      Caption         =   "Echo"
      Height          =   495
      Left            =   240
      TabIndex        =   10
      Top             =   3120
      Width           =   2055
   End
   Begin VB.CommandButton cmdDisconnect 
      Caption         =   "断开连接"
      Height          =   375
      Left            =   4080
      TabIndex        =   9
      Top             =   600
      Width           =   1695
   End
   Begin VB.CommandButton cmdSend 
      Caption         =   "发送命令"
      Height          =   495
      Left            =   1560
      TabIndex        =   8
      Top             =   1560
      Width           =   2895
   End
   Begin VB.TextBox txtReturn 
      Height          =   3735
      Left            =   240
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   7
      Top             =   4200
      Width           =   5535
   End
   Begin VB.TextBox txtCommand 
      Height          =   735
      Left            =   240
      MultiLine       =   -1  'True
      TabIndex        =   5
      Top             =   2160
      Width           =   5535
   End
   Begin VB.CommandButton cmdConnect 
      Caption         =   "建立连接"
      Height          =   375
      Left            =   4080
      TabIndex        =   4
      Top             =   120
      Width           =   1695
   End
   Begin VB.TextBox txtPort 
      Height          =   375
      Left            =   1800
      TabIndex        =   3
      Text            =   "5001"
      Top             =   600
      Width           =   2055
   End
   Begin VB.TextBox txtHost 
      Height          =   375
      Left            =   1800
      TabIndex        =   2
      Text            =   "localhost"
      Top             =   120
      Width           =   2055
   End
   Begin VB.Label Label5 
      Caption         =   "响应时间："
      Height          =   375
      Left            =   240
      TabIndex        =   14
      Top             =   1080
      Width           =   1335
   End
   Begin VB.Label lblConnectStatus 
      Caption         =   "未建立连接"
      Height          =   495
      Left            =   3960
      TabIndex        =   13
      Top             =   3600
      Width           =   1455
   End
   Begin VB.Label stkAck 
      Caption         =   "响应状态："
      Height          =   375
      Left            =   3960
      TabIndex        =   12
      Top             =   3120
      Width           =   1935
   End
   Begin VB.Label Label4 
      Caption         =   "返回信息"
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   3840
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "端口号："
      Height          =   255
      Left            =   240
      TabIndex        =   1
      Top             =   720
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "主机名称："
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   1335
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim connection As StkConnect


Private Sub cmdConnect_Click()
    Dim connectionName As String
    connectionName = txtHost & ":" & txtPort
    
    Set connection = New StkConnect
    connection.connect (connectionName)
    If connection.connected Then
        lblConnectStatus.Caption = "建立连接"
        lblConnectStatus.Refresh
    End If
End Sub

Private Sub cmdDisconnect_Click()
    connection.disconnect
    If Not connection.connected Then
        lblConnectStatus.Caption = "未建立连接"
        lblConnectStatus.Refresh
    End If
End Sub

Private Sub cmdEchoLine_Click()
    Dim Index As Long

    Index = txtLineNumber
    txtReturn.Text = connection.returnedLine(Index)
    txtReturn.Refresh
End Sub

Private Sub cmdSend_Click()
    connection.sendCommand (txtCommand.Text)
    stkAck = "响应状态:" & connection.getAckAsString
    stkAck.Refresh
    txtReturn.Text = connection.getNumEntries
    txtReturn.Refresh
End Sub

Private Sub cmdSetTimeout_Click()
    connection.setTimeout (txtTimeout.Text)
End Sub
