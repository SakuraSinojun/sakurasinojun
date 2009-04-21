VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form Form1 
   BackColor       =   &H00000000&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "卫星端"
   ClientHeight    =   6360
   ClientLeft      =   435
   ClientTop       =   1200
   ClientWidth     =   12600
   ForeColor       =   &H00FFFFFF&
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   424
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   840
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  '屏幕中心
   Begin VB.TextBox Text1 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   12
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   5280
      Left            =   9600
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   1080
      Width           =   3000
   End
   Begin VB.PictureBox Picture2 
      BackColor       =   &H00000000&
      Height          =   3600
      Left            =   4800
      ScaleHeight     =   3540
      ScaleWidth      =   4740
      TabIndex        =   9
      Top             =   1080
      Width           =   4800
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00000000&
      Height          =   3600
      Left            =   0
      ScaleHeight     =   236
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   316
      TabIndex        =   8
      Top             =   1080
      Width           =   4800
   End
   Begin VB.Timer PTimer 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   7440
      Top             =   3840
   End
   Begin MSWinsockLib.Winsock Sock 
      Left            =   6360
      Top             =   3600
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.FileListBox bFileBox 
      Height          =   810
      Left            =   7080
      Pattern         =   "*.bmp"
      TabIndex        =   1
      Top             =   2760
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H8000000D&
      Caption         =   "工作记录"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   615
      Index           =   6
      Left            =   9600
      TabIndex        =   16
      Top             =   480
      Width           =   3015
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BackColor       =   &H00404000&
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Left            =   7320
      TabIndex        =   15
      Top             =   5640
      Width           =   2295
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H8000000D&
      Caption         =   "文件发送状态"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   615
      Index           =   5
      Left            =   7320
      TabIndex        =   14
      Top             =   5040
      Width           =   2295
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H8000000D&
      Caption         =   "卫星时钟"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   615
      Index           =   3
      Left            =   2520
      TabIndex        =   10
      Top             =   5040
      Width           =   2295
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      BackColor       =   &H00004040&
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Left            =   4920
      TabIndex        =   13
      Top             =   5640
      Width           =   2295
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H8000000D&
      Caption         =   "缓存状态"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   615
      Index           =   4
      Left            =   4920
      TabIndex        =   12
      Top             =   5040
      Width           =   2295
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H00404080&
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Left            =   2520
      TabIndex        =   11
      Top             =   5640
      Width           =   2295
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H8000000D&
      Caption         =   "测控站接入"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   615
      Index           =   2
      Left            =   120
      TabIndex        =   7
      Top             =   5040
      Width           =   2295
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H8000000D&
      Caption         =   "拍摄图像"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   615
      Index           =   1
      Left            =   4800
      TabIndex        =   6
      Top             =   480
      Width           =   4815
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H8000000D&
      Caption         =   "实时图像"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   615
      Index           =   0
      Left            =   0
      TabIndex        =   5
      Top             =   480
      Width           =   4815
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H000000FF&
      Caption         =   "二号"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   1
      Left            =   1320
      TabIndex        =   4
      Top             =   5640
      Width           =   1095
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H000000FF&
      Caption         =   "一号"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   0
      Left            =   120
      TabIndex        =   3
      Top             =   5640
      Width           =   1215
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0C0&
      Caption         =   "卫星状态监控面板"
      BeginProperty Font 
         Name            =   "微软雅黑"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   495
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   12615
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Dim IP1 As String
Dim IP2 As String
Dim IP As String
Dim Port As Integer
Dim CoutTime As Long            '卫星时钟
Dim TableList As tTable       '任务表
Dim Video_Handle As Long        '摄像头句柄
Dim PicPath As String
Dim iiStep As Integer        'step
Dim PicList() As tPIC
Dim ListLength As Long          '任务表长度


Private Sub Form_Load()

    IP1 = InputBox("请设置测控站1的IP地址：", "测控站1")
     IP2 = InputBox("请设置测控站2的IP地址：", "测控站2")

    SM "启动初始化程序。"
    PicPath = App.Path & "\pic"
    If Dir(PicPath, vbDirectory) = "" Then
        
        MkDir PicPath
    End If
    PicPath = PicPath & "\"
    
      '初始化任务列表
    PTimer.Enabled = False
    PTimer.Interval = Ts
    bFileBox.Path = PicPath
    CoutTime = 0
    ListLength = 0

    ReDim PicList(0) As tPIC
    
    
    TableList.ConTime = 1
    TableList.DisTime = 1000
    TableList.bState = False
    TableList.bID = 1
    TableList.bUpdate = True
      
    PicList(0).lTime = 0
    PicList(0).bState = True
    PicList(0).bFile = 3
       
    
    PTimer.Enabled = True
        
    Video_Handle = CreateCaptureWindow(Picture1.hwnd)  '启动摄像头
    
    SM "启动成功！"
End Sub






Private Sub PTimer_Timer()
    Dim i As Long
    
        CoutTime = CoutTime + 1
        Label4.Caption = CoutTime   '卫星时钟
        bFileBox.Refresh
        Label5.Caption = bFileBox.ListCount '  缓存状态
        If CoutTime >= iMax Then ResetTime  '计时器长度复位控制
    
        Select Case TableList.bState        '判断卫星状态
            Case True                       '连接且更新后执行断开计划,断开中执行连接计划
               If CoutTime >= TableList.DisTime And TableList.bUpdate = True Then
                        Sock.Close              '断开连接
                        TableList.bState = False
                         SM "与测控站NO." & TableList.bID & " 连接断开！"
                        Label2(Port - 30021).BackColor = vbRed
                    'Exit Sub
                End If
            Case False
                If CoutTime >= TableList.ConTime Then
                 fConnect TableList.bID     '调用连接函数
                 'Exit Sub
                
                End If
            
        End Select
        
        'pic任务计划
        For i = 0 To ListLength - 1
        
            If CoutTime >= PicList(i).lTime And PicList(i).bState = False Then
                fTakePic PicList(i)
                PicList(i).bState = True
                
            
            End If
            
        
        Next i

End Sub




Private Sub Sock_Connect()

    TableList.bState = True
    TableList.bUpdate = False
    SM "建立与测控站NO." & TableList.bID & " 连接！"
    Label2(TableList.bID - 1).BackColor = vbGreen


 
    
End Sub



Private Function fConnect(ByVal IDs As Byte)    '连接函数
    
    
    
    If Sock.State = 0 Or Sock.State = 8 Then
        SM "正在连接测控站NO." & IDs
        Label2(IDs - 1).BackColor = vbYellow
    End If
    

    Select Case IDs                         '联机
        Case 1
            IP = IP1
            Port = Port1
        Case 2
            IP = IP2
            Port = Port2
    End Select
    Sock.Close
    Sock.Connect IP, Port
    

        
End Function

Private Function ResetTime()                '时钟复位

    Dim i As Long
    
    PTimer.Enabled = False
    
    TableList.ConTime = TableList.ConTime - CoutTime    '调整连接计划
    TableList.DisTime = TableList.DisTime - CoutTime
    
    For i = 0 To ListLength           '调整拍摄计划
    
        If PicList(i).bState = False Then PicList(i).lTime = PicList(i).lTime - CoutTime
        '调整未执行任务时刻
    Next i
    
    CoutTime = 0
    SM "时钟复位。。。"
    PTimer.Enabled = True
    

End Function


Private Function fTakePic(ByRef PICs As tPIC)           '拍摄动作
    
    Dim FileName As String
    Dim pic As StdPicture
    Dim a As String
    a = PICs.bFile & ".bmp"
    FileName = PicPath & a
    Set pic = CapturePicture(Video_Handle)
    Picture2.Picture = pic
    SavePicture pic, FileName
    
    PICs.bState = True

    SM "完成拍摄任务：" & a
    

End Function


Private Sub SM(msg As String)           'SM显示函数
      
      If Len(Text1.Text) > 1500 Then Text1.Text = ""
      
      
      Text1.Text = Text1.Text & vbCrLf & CoutTime & "  " & msg
      Text1.SelStart = Len(Text1.Text)
      Text1.SelLength = 1
     
      
End Sub

Private Sub Sock_DataArrival(ByVal bytesTotal As Long)
    Dim i As Integer
    Dim gData() As Byte
    Dim temp As tPack
    ReDim gData(bytesTotal - 1) As Byte
    Sock.GetData gData
    
    CopyMemory temp, gData(0), bytesTotal
    
    Select Case temp.eCMD
        Case vTAB               '0
            SM "接收到卫星时刻表"
            TableList.DisTime = temp.iDisTime + CoutTime
            TableList.ConTime = temp.iConTime + CoutTime
            TableList.bID = temp.iID
            TableList.bUpdate = True
            iiStep = temp.iStep
            If iiStep < 1 Then iiStep = 1
            PTimer.Interval = Ts / iiStep
        Case vQST   '询问文件    vQST      zQST[文件个数FILELENGTH]     '2
            SM "VMOC查询卫星缓存。"
            bFileBox.Refresh
            
            temp.lTotalLength = bFileBox.ListCount
            
            temp.eCMD = zQST
            SM "查询结果" & bFileBox.ListCount & "返回！"
            CopyMemory gData(0), temp, bytesTotal
            Sock.SendData gData
            
        Case vGET   '获取文件    vGET    [文件总长lTotalLength][已传文件长度lSendLength][文件名iID]     '3
            SM "VMOC请求图像传输！"
            temp.eCMD = sSND 'sSND文件总长lTotalLength][已传文件长度lSendLength][文件名iID][文件包bFilepack(1023)]
            Dim fName As String
            Dim fNo As Integer
            fName = temp.iID & ".bmp"
            
            fName = PicPath & fName
            If Dir(fName) = "" Then
                fName = bFileBox.List(0)
                temp.iID = Val(Left$(fName, InStr(fName, ".bmp")))
                temp.lSendLength = 1
                SM "正在发送文件" & fName
                fName = PicPath & fName
                
            End If
            Label3(5).Caption = "发送文件" & temp.iID
            
            
            fNo = FreeFile
            
            
            Open fName For Binary As #fNo
            If temp.lSendLength = 0 Then temp.lSendLength = 1
            Seek #fNo, temp.lSendLength
            temp.lTotalLength = LOF(fNo)
            
                If temp.lTotalLength - temp.lSendLength < UBound(temp.bFilepack) Then
                    For i = 0 To temp.lTotalLength - temp.lSendLength
                        Get fNo, Seek(fNo), temp.bFilepack(i)
                    Next i
                    temp.lSendLength = temp.lTotalLength
                   
                    Else
                   Get #fNo, temp.lSendLength, temp.bFilepack
                    temp.lSendLength = Seek(fNo)
               End If
             
            
            Close #fNo
            Label6.Caption = Int((temp.lSendLength - 1) / 1024) & "/" & Int(temp.lTotalLength / 1024)
            If temp.lSendLength = temp.lTotalLength Then
                Kill fName
                bFileBox.Refresh
                SM temp.iID & ".bmp发送完毕！"
                Label6.Caption = ""
                Label3(5).Caption = "文件发送状态"
            End If
            
        Case vPHT   '拍摄指令    vPHT    [拍摄时间iConTime][步长iStep][地名iID]         '6
            SM "接收到拍摄指令！"
            
            
            iiStep = temp.iStep
            If iiStep < 1 Then iiStep = 1

            PTimer.Interval = Ts / iiStep
            
            For i = 0 To ListLength - 1
                If PicList(i).bState = True Then
                    PicList(i).lTime = temp.iConTime + CoutTime
                    PicList(i).bFile = temp.iID
                    PicList(i).bState = False
                    Exit Sub
                End If
            Next i
            
                ListLength = ListLength + 1
                ReDim PicList(ListLength) As tPIC
                PicList(ListLength - 1).lTime = temp.iConTime + CoutTime
                PicList(ListLength - 1).bFile = temp.iID
                PicList(ListLength - 1).bState = False
               
                    
        Case Else
            SM "接收到不明指令：" & temp.eCMD
        
    End Select
    
End Sub

















