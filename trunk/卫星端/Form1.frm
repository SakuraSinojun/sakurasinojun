VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form Form1 
   BackColor       =   &H00000000&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "���Ƕ�"
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
   StartUpPosition =   2  '��Ļ����
   Begin VB.TextBox Text1 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "����"
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
      Caption         =   "������¼"
      BeginProperty Font 
         Name            =   "΢���ź�"
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
         Name            =   "΢���ź�"
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
      Caption         =   "�ļ�����״̬"
      BeginProperty Font 
         Name            =   "΢���ź�"
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
      Caption         =   "����ʱ��"
      BeginProperty Font 
         Name            =   "΢���ź�"
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
         Name            =   "΢���ź�"
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
      Caption         =   "����״̬"
      BeginProperty Font 
         Name            =   "΢���ź�"
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
         Name            =   "΢���ź�"
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
      Caption         =   "���վ����"
      BeginProperty Font 
         Name            =   "΢���ź�"
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
      Caption         =   "����ͼ��"
      BeginProperty Font 
         Name            =   "΢���ź�"
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
      Caption         =   "ʵʱͼ��"
      BeginProperty Font 
         Name            =   "΢���ź�"
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
      Caption         =   "����"
      BeginProperty Font 
         Name            =   "΢���ź�"
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
      Caption         =   "һ��"
      BeginProperty Font 
         Name            =   "΢���ź�"
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
      Caption         =   "����״̬������"
      BeginProperty Font 
         Name            =   "΢���ź�"
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
Dim CoutTime As Long            '����ʱ��
Dim TableList As tTable       '�����
Dim Video_Handle As Long        '����ͷ���
Dim PicPath As String
Dim iiStep As Integer        'step
Dim PicList() As tPIC
Dim ListLength As Long          '�������


Private Sub Form_Load()

    IP1 = InputBox("�����ò��վ1��IP��ַ��", "���վ1")
     IP2 = InputBox("�����ò��վ2��IP��ַ��", "���վ2")

    SM "������ʼ������"
    PicPath = App.Path & "\pic"
    If Dir(PicPath, vbDirectory) = "" Then
        
        MkDir PicPath
    End If
    PicPath = PicPath & "\"
    
      '��ʼ�������б�
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
        
    Video_Handle = CreateCaptureWindow(Picture1.hwnd)  '��������ͷ
    
    SM "�����ɹ���"
End Sub






Private Sub PTimer_Timer()
    Dim i As Long
    
        CoutTime = CoutTime + 1
        Label4.Caption = CoutTime   '����ʱ��
        bFileBox.Refresh
        Label5.Caption = bFileBox.ListCount '  ����״̬
        If CoutTime >= iMax Then ResetTime  '��ʱ�����ȸ�λ����
    
        Select Case TableList.bState        '�ж�����״̬
            Case True                       '�����Ҹ��º�ִ�жϿ��ƻ�,�Ͽ���ִ�����Ӽƻ�
               If CoutTime >= TableList.DisTime And TableList.bUpdate = True Then
                        Sock.Close              '�Ͽ�����
                        TableList.bState = False
                         SM "����վNO." & TableList.bID & " ���ӶϿ���"
                        Label2(Port - 30021).BackColor = vbRed
                    'Exit Sub
                End If
            Case False
                If CoutTime >= TableList.ConTime Then
                 fConnect TableList.bID     '�������Ӻ���
                 'Exit Sub
                
                End If
            
        End Select
        
        'pic����ƻ�
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
    SM "��������վNO." & TableList.bID & " ���ӣ�"
    Label2(TableList.bID - 1).BackColor = vbGreen


 
    
End Sub



Private Function fConnect(ByVal IDs As Byte)    '���Ӻ���
    
    
    
    If Sock.State = 0 Or Sock.State = 8 Then
        SM "�������Ӳ��վNO." & IDs
        Label2(IDs - 1).BackColor = vbYellow
    End If
    

    Select Case IDs                         '����
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

Private Function ResetTime()                'ʱ�Ӹ�λ

    Dim i As Long
    
    PTimer.Enabled = False
    
    TableList.ConTime = TableList.ConTime - CoutTime    '�������Ӽƻ�
    TableList.DisTime = TableList.DisTime - CoutTime
    
    For i = 0 To ListLength           '��������ƻ�
    
        If PicList(i).bState = False Then PicList(i).lTime = PicList(i).lTime - CoutTime
        '����δִ������ʱ��
    Next i
    
    CoutTime = 0
    SM "ʱ�Ӹ�λ������"
    PTimer.Enabled = True
    

End Function


Private Function fTakePic(ByRef PICs As tPIC)           '���㶯��
    
    Dim FileName As String
    Dim pic As StdPicture
    Dim a As String
    a = PICs.bFile & ".bmp"
    FileName = PicPath & a
    Set pic = CapturePicture(Video_Handle)
    Picture2.Picture = pic
    SavePicture pic, FileName
    
    PICs.bState = True

    SM "�����������" & a
    

End Function


Private Sub SM(msg As String)           'SM��ʾ����
      
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
            SM "���յ�����ʱ�̱�"
            TableList.DisTime = temp.iDisTime + CoutTime
            TableList.ConTime = temp.iConTime + CoutTime
            TableList.bID = temp.iID
            TableList.bUpdate = True
            iiStep = temp.iStep
            If iiStep < 1 Then iiStep = 1
            PTimer.Interval = Ts / iiStep
        Case vQST   'ѯ���ļ�    vQST      zQST[�ļ�����FILELENGTH]     '2
            SM "VMOC��ѯ���ǻ��档"
            bFileBox.Refresh
            
            temp.lTotalLength = bFileBox.ListCount
            
            temp.eCMD = zQST
            SM "��ѯ���" & bFileBox.ListCount & "���أ�"
            CopyMemory gData(0), temp, bytesTotal
            Sock.SendData gData
            
        Case vGET   '��ȡ�ļ�    vGET    [�ļ��ܳ�lTotalLength][�Ѵ��ļ�����lSendLength][�ļ���iID]     '3
            SM "VMOC����ͼ���䣡"
            temp.eCMD = sSND 'sSND�ļ��ܳ�lTotalLength][�Ѵ��ļ�����lSendLength][�ļ���iID][�ļ���bFilepack(1023)]
            Dim fName As String
            Dim fNo As Integer
            fName = temp.iID & ".bmp"
            
            fName = PicPath & fName
            If Dir(fName) = "" Then
                fName = bFileBox.List(0)
                temp.iID = Val(Left$(fName, InStr(fName, ".bmp")))
                temp.lSendLength = 1
                SM "���ڷ����ļ�" & fName
                fName = PicPath & fName
                
            End If
            Label3(5).Caption = "�����ļ�" & temp.iID
            
            
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
                SM temp.iID & ".bmp������ϣ�"
                Label6.Caption = ""
                Label3(5).Caption = "�ļ�����״̬"
            End If
            
        Case vPHT   '����ָ��    vPHT    [����ʱ��iConTime][����iStep][����iID]         '6
            SM "���յ�����ָ�"
            
            
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
            SM "���յ�����ָ�" & temp.eCMD
        
    End Select
    
End Sub

















