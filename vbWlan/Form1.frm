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
   StartUpPosition =   3  '����ȱʡ
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
      Caption         =   "����"
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
      Caption         =   "ˢ��"
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
   
 
'���ݸ�WlanEnumInterfaces��Ӧ����һ��ָ�룬���ָ���ں������غ�ָ����Ǻ��������WLAN_INTERFACE_INFO_LIST�ṹ�ĵ�ַ.
Dim wiiListPtr As Long
Dim wiiList As WLAN_INTERFACE_INFO_LIST
wiiListPtr = 0

res = WlanEnumInterfaces(hClientHandle, 0, wiiListPtr)

If (res <> 0) Then Exit Sub

'��wiiListPtrָ���WLAN_INTERFACE_INFO_LIST�ṹ���Ƴ�����
'ֻ����һ�����������������WLAN_INTERFACE_INFO_LIST�ṹ��ռ4+4+532x1=540�ֽڡ�
'�����������Ӧ���ȸ���ǰ4�ֽڣ��Եõ�InterfaceInfo����,Ȼ��ReDim InterfaceInfo���飬���¼��㳤�Ⱥ��ٽ��и��ơ�
'ע��ڶ�������Ӧ�ð�ByVal���ݡ�
CopyMemory wiiList, ByVal wiiListPtr, 540

Dim r_guid As String
Dim i As Integer

CopyMemory m_GUID, wiiList.InterfaceInfo(0).InterfaceGuid, 16

With wiiList.InterfaceInfo(0).InterfaceGuid

    r_guid = Hex(.data1) & "-" & Hex(.data2)
    r_guid = r_guid & "-" & Hex(.data3)         'ע���ֽ�˳��
    r_guid = r_guid & "-" & Hex(.data4(1)) & Hex(.data4(0))         'ע���ֽ�˳��
    r_guid = r_guid & "-"
    For i = 2 To 7
        r_guid = r_guid & Hex(.data4(i))
    Next i
End With

'�豸��������widechar��ʽ�����wiiList.InterfaceInfo(0).strInterfaceDescription()���������.
'�˴���ת��ǰ������VB��string���ͣ���Ϊstring���ͻὫ�޷�ʶ����ַ�ȫ��ת����chr(0)�����������ʾ������
'ע��WideCharToMultiByte���������������������Ѿ��޸�ΪyRef lpWideCharStr As Any����ԭ������ʽ��ByVal lpWideCharStr As String
'������Ҫ�����ַ���������׵�ַ��
Dim tmp As String
Dim l As Integer
l = WideCharToMultiByte(0, 0, wiiList.InterfaceInfo(0).strInterfaceDescription(0), -1, "", 0, "", 0)
tmp = String(l + 1, " ")
WideCharToMultiByte 0, 0, wiiList.InterfaceInfo(0).strInterfaceDescription(0), -1, tmp, l, vbNullString, 0

tmp = Left(tmp, lstrlen(tmp))

Label1.Caption = "G U I D :    " & r_guid & vbCrLf & "�豸����:    " & tmp & vbCrLf & Str(wiiList.InterfaceInfo(0).isState)



'���������б�


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
        MsgBox "��ѡ��һ������"
        Exit Sub
    End If
    
    i = i - 1
    CopyMemory wan, ByVal (ppAvailableNetworkList + 8 + i * 628), 628
    
    
    If wan.strProfileName(0) <> 0 Then
        '���������ļ�
        
        If wan.bNetworkConnectable = 0 Then
            MsgBox "���粻����"
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
            '����ԭ��:
            'http://msdn.microsoft.com/en-us/library/ms706613(VS.85).aspx
        End If
        
    Else
        '�������ļ�
        
        MsgBox "��Ҫ����XML�����ļ������Ҳ����ˡ�����̫����." & vbCrLf & "ֱ����windows�����߹��������ɸ��þͿ�����", vbInformation
        
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
    MsgBox "�ɹ�����"
End If

End Sub





































