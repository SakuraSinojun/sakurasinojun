VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form1"
   ClientHeight    =   6210
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   11040
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6210
   ScaleWidth      =   11040
   StartUpPosition =   3  '窗口缺省
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   7215
      Top             =   3765
   End
   Begin VB.ListBox List2 
      Appearance      =   0  'Flat
      Height          =   2730
      Left            =   135
      TabIndex        =   4
      Top             =   3360
      Width           =   6630
   End
   Begin VB.CommandButton Command2 
      Caption         =   "连接"
      Height          =   405
      Left            =   9015
      TabIndex        =   3
      Top             =   5670
      Width           =   1965
   End
   Begin VB.ListBox List1 
      Appearance      =   0  'Flat
      Height          =   2370
      Left            =   120
      TabIndex        =   2
      Top             =   840
      Width           =   10800
   End
   Begin VB.CommandButton Command1 
      Caption         =   "刷新"
      Height          =   405
      Left            =   6975
      TabIndex        =   0
      Top             =   5670
      Width           =   1965
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Label1"
      ForeColor       =   &H80000008&
      Height          =   600
      Left            =   105
      TabIndex        =   1
      Top             =   120
      Width           =   10800
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Option Explicit

Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Private Declare Function MultiByteToWideChar Lib "kernel32" (ByVal CodePage As Long, ByVal dwFlags As Long, ByVal lpMultiByteStr As String, ByVal cchMultiByte As Long, ByVal lpWideCharStr As String, ByVal cchWideChar As Long) As Long
Private Declare Function WideCharToMultiByte Lib "kernel32" (ByVal CodePage As Long, ByVal dwFlags As Long, ByRef lpWideCharStr As Any, ByVal cchWideChar As Long, ByVal lpMultiByteStr As String, ByVal cchMultiByte As Long, ByVal lpDefaultChar As String, ByVal lpUsedDefaultChar As Long) As Long
Private Declare Function lstrlen Lib "kernel32" Alias "lstrlenA" (ByVal lpString As String) As Long

Private Declare Function lstrcmp Lib "kernel32" Alias "lstrcmpA" (ByVal lpString1 As String, ByVal lpString2 As String) As Long

Private Declare Function lstrcpy Lib "kernel32" Alias "lstrcpyA" (ByVal lpString1 As String, ByVal lpString2 As String) As Long





Dim hClientHandle As Long
Dim ppAvailableNetworkList As Long
Dim m_GUID As GUID

Private DOT11_BSS_TYPE_TO_MSG(3) As String


Private Sub Command1_Click()


Dim res As Long
Dim dwNegotiatedVersion As Long


pdwNegotiatedVersion = 0
hClientHandle = 0


WlanFreeMemory ByVal ppAvailableNetworkList


res = WlanOpenHandle(1, 0, dwNegotiatedVersion, hClientHandle)

If (res <> 0) Then Exit Sub
   
 
'传递给WlanEnumInterfaces的应该是一个指针，这个指针在函数返回后指向的是函数分配的WLAN_INTERFACE_INFO_LIST结构的地址.
Dim wiiListPtr As Long
Dim wiiList As WLAN_INTERFACE_INFO_LIST
wiiListPtr = 0

res = WlanEnumInterfaces(hClientHandle, 0, wiiListPtr)

If (res <> 0) Then Exit Sub

'将wiiListPtr指向的WLAN_INTERFACE_INFO_LIST结构复制出来。
'只考虑一个网卡的情况。这样WLAN_INTERFACE_INFO_LIST结构共占4+4+532x1=540字节。
'若多个网卡，应该先复制前4字节，以得到InterfaceInfo数量,然后ReDim InterfaceInfo数组，重新计算长度后再进行复制。
'注意第二个参数应该按ByVal传递。
CopyMemory wiiList, ByVal wiiListPtr, 540

Dim r_guid As String
Dim i As Integer

CopyMemory m_GUID, wiiList.InterfaceInfo(0).InterfaceGuid, 16

With wiiList.InterfaceInfo(0).InterfaceGuid

    r_guid = Hex(.data1) & "-" & Hex(.data2)
    r_guid = r_guid & "-" & Hex(.data3)         '注意字节顺序
    r_guid = r_guid & "-" & Hex(.data4(1)) & Hex(.data4(0))         '注意字节顺序
    r_guid = r_guid & "-"
    For i = 2 To 7
        r_guid = r_guid & Hex(.data4(i))
    Next i
End With

'设备描述，以widechar形式存放于wiiList.InterfaceInfo(0).strInterfaceDescription()这个数组中.
'此处在转换前不能用VB的string类型，因为string类型会将无法识别的字符全部转化成chr(0)。因此中文显示将出错。
'注意WideCharToMultiByte的声明，第三个参数我已经修改为yRef lpWideCharStr As Any。而原参数形式是ByVal lpWideCharStr As String
'这里需要的是字符串数组的首地址。
Dim tmp As String
Dim l As Integer
l = WideCharToMultiByte(0, 0, wiiList.InterfaceInfo(0).strInterfaceDescription(0), -1, "", 0, "", 0)
tmp = String(l + 1, " ")
WideCharToMultiByte 0, 0, wiiList.InterfaceInfo(0).strInterfaceDescription(0), -1, tmp, l, vbNullString, 0

tmp = Left(tmp, lstrlen(tmp))

Label1.Caption = "G U I D :    " & r_guid & vbCrLf & "设备描述:    " & tmp & vbCrLf & Str(wiiList.InterfaceInfo(0).isState)



'无线网络列表


Dim wanList As WLAN_AVAILABLE_NETWORK_LIST
Dim wan As WLAN_AVALIABLE_NETWORK

res = WlanGetAvailableNetworkList(hClientHandle, _
                                    wiiList.InterfaceInfo(0).InterfaceGuid, _
                                    WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_ADHOC_PROFILES Or WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_MANUAL_HIDDEN_PROFILES, _
                                    0, _
                                    ppAvailableNetworkList)
If res <> 0 Then
    MsgBox "Error:" & res
    Exit Sub
End If

CopyMemory wanList, ByVal ppAvailableNetworkList, 8

Dim temp As String
List1.Clear

List1.AddItem Format("SSID", "!@@@@@@@@@@@@@@@@@@@@") + Format("profile", "!@@@@@@@@@@@@@@@@@@@@") _
                + Format("SignalQuality", "!@@@@@@@@@@@@@@@@@@@@") + Format("SecurityEnabled", "!@@@@@@@@@@@@@@@@@@@@") _
                + Format("NetworkConnectable", "!@@@@@@@@@@@@@@@@@@@@")

For i = 0 To wanList.dwNumberOfItems - 1
    CopyMemory wan, ByVal (ppAvailableNetworkList + 8 + i * 628), 628
    tmp = StrConv(wan.dot11Ssid.ucSSID, vbUnicode)
    tmp = Left(tmp, lstrlen(tmp))
    temp = Format(tmp, "!@@@@@@@@@@@@@@@@@@@@")
    l = WideCharToMultiByte(0, 0, wan.strProfileName(0), -1, "", 0, "", 0)
    tmp = String(l + 1, " ")
    WideCharToMultiByte 0, 0, wan.strProfileName(0), -1, tmp, l, "", 0
    tmp = Left(tmp, lstrlen(tmp))
    If tmp = "" Then tmp = " "
    temp = temp & Format(tmp, "!@@@@@@@@@@@@@@@@@@@@")
    tmp = Trim(Str(wan.wlanSignalQuality)) & "/100"
    temp = temp & Format(tmp, "!@@@@@@@@@@@@@@@@@@@@")
    If wan.bSecurityEnabled = 1 Then
        tmp = "TRUE"
    Else
        tmp = "FALSE"
    End If
    temp = temp & Format(tmp, "!@@@@@@@@@@@@@@@@@@@@")
    If wan.bNetworkConnectable = 1 Then
        tmp = "TRUE"
    Else
        tmp = "FALSE"
    End If
    temp = temp & Format(tmp, "!@@@@@@@@@@@@@@@@@@@@")
    List1.AddItem temp
    
Next i


WlanFreeMemory ByVal wiiListPtr




End Sub


Private Sub Command2_Click()

    Dim i As Integer
    Dim wan As WLAN_AVALIABLE_NETWORK
    Dim wlancp As WLAN_CONNECTION_PARAMETERS
    Dim res As Long
    
    
    
    i = List1.ListIndex
    If i <= 0 Then
        MsgBox "请选择一个连接"
        Exit Sub
    End If
    
    i = i - 1
    CopyMemory wan, ByVal (ppAvailableNetworkList + 8 + i * 628), 628
    
    
    If wan.strProfileName(0) <> 0 Then
        '存在配置文件
        
        If wan.bNetworkConnectable = 0 Then
            MsgBox "网络不可用"
            Exit Sub
        End If
        
        wlancp.dot11BssType = wan.dot11BssType
        wlancp.dwFlags = 0
        wlancp.pDesiredBssidList = 0
        wlancp.pDot11Ssid = VarPtr(wan.dot11Ssid)
        wlancp.strProfile = VarPtr(wan.strProfileName(0))
        wlancp.wlanConnectionMode = wlan_connection_mode_profile
        WlanDisconnect hClientHandle, m_GUID, 0
        
        Command2.Enabled = False
        Timer1.Enabled = True
        DoEvents
        res = WlanConnect(hClientHandle, m_GUID, wlancp, 0)
        'MsgBox res
        If res <> ERROR_SUCCESS Then
            MsgBox "Error:" & res
            Command2.Enabled = True
            Timer1.Enabled = False
            Exit Sub
            '错误原因:
            'http://msdn.microsoft.com/en-us/library/ms706613(VS.85).aspx
        End If
        
    Else
        '无配置文件
        
        MsgBox "需要生成XML配置文件。。我不做了。。我太懒了." & vbCrLf & "直接用windows的无线管理器生成个用就可以了", vbInformation
        
    End If
    
    
End Sub

Private Sub Form_Load()
    DOT11_BSS_TYPE_TO_MSG(1) = "dot11_BSS_type_infrastructure"
    DOT11_BSS_TYPE_TO_MSG(2) = "dot11_BSS_type_independent"
    DOT11_BSS_TYPE_TO_MSG(3) = "dot11_BSS_type_any"
    
    ppAvailableNetworkList = 0
    Me.Show
    
    Command1_Click
    
    
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    WlanCloseHandle hClientHandle, 0
    
End Sub

Private Sub List1_Click()

    Dim i As Integer
    Dim tmp As String

    Dim wan As WLAN_AVALIABLE_NETWORK
    
    i = List1.ListIndex
    If i = 0 Then Exit Sub
    
    i = i - 1
    CopyMemory wan, ByVal (ppAvailableNetworkList + 8 + i * 628), 628
    
    List2.Clear
    
    
    tmp = StrConv(wan.dot11Ssid.ucSSID, vbUnicode)
    tmp = Left(tmp, lstrlen(tmp))
    List2.AddItem Format("SSID:", "!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") & tmp
    l = WideCharToMultiByte(0, 0, wan.strProfileName(0), -1, "", 0, "", 0)
    tmp = String(l + 1, " ")
    WideCharToMultiByte 0, 0, wan.strProfileName(0), -1, tmp, l, "", 0
    tmp = Left(tmp, lstrlen(tmp))
    If tmp = "" Then tmp = " "
    List2.AddItem Format("PROFILE:", "!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") & tmp
    tmp = Trim(Str(wan.wlanSignalQuality)) & "/100"
    List2.AddItem Format("bSecurityEnabled", "!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") & tmp
    'tmp = Trim(Str(wan.dot11BssType))
    tmp = DOT11_BSS_TYPE_TO_MSG(wan.dot11BssType)
    List2.AddItem Format("dot11BssType", "!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") & tmp
    tmp = Trim(Str(wan.uNumberOfBssids))
    List2.AddItem Format("uNumberOfBssids", "!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") & tmp
    tmp = Trim(Str(wan.wlanNotConnectableReason))
    List2.AddItem Format("wlanNotConnectableReason", "!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") & tmp
    tmp = Trim(Str(wan.uNumberOfPhyTypes))
    List2.AddItem Format("uNumberOfPhyTypes", "!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") & tmp
    tmp = Trim(Str(wan.bMorePhyTypes))
    List2.AddItem Format("bMorePhyTypes", "!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") & tmp
    tmp = Trim(Str(wan.dot11DefaultAuthAlgorithm))
    List2.AddItem Format("dot11DefaultAuthAlgorithm", "!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") & tmp
    tmp = Trim(Str(wan.dot11DefaultCipherAlgorithm))
    List2.AddItem Format("dot11DefaultCipherAlgorithm", "!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") & tmp
    tmp = Trim(Str(wan.dwFlags))
    List2.AddItem Format("dwFlags", "!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") & tmp
    tmp = Trim(Str(wan.dwReserved))
    List2.AddItem Format("dwReserved", "!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") & tmp
    
       
End Sub



Private Sub Timer1_Timer()

Dim res As Long
Dim wiiListPtr As Long
Dim wiiList As WLAN_INTERFACE_INFO_LIST
wiiListPtr = 0

res = WlanEnumInterfaces(hClientHandle, 0, wiiListPtr)

If (res <> 0) Then Exit Sub

CopyMemory wiiList, ByVal wiiListPtr, 540


If wiiList.InterfaceInfo(0).isState = wlan_interface_state_connected Then
    Command2.Enabled = True
    Timer1.Enabled = False
    MsgBox "成功连接"
End If

End Sub





































