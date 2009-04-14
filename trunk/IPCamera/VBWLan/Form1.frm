VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   6795
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   11040
   LinkTopic       =   "Form1"
   ScaleHeight     =   6795
   ScaleWidth      =   11040
   StartUpPosition =   3  '窗口缺省
   Begin VB.TextBox Text1 
      Height          =   510
      Left            =   1425
      TabIndex        =   1
      Text            =   "Text1"
      Top             =   405
      Width           =   3150
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   510
      Left            =   1395
      TabIndex        =   0
      Top             =   1410
      Width           =   3645
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False





Private Type GUID
    data1 As Long
    data2(1) As Byte
    data3(1) As Byte
    data4(7) As Byte
End Type
'16 Bytes total


Private Type WLAN_INTERFACE_INFO
    InterfaceGuid As GUID
    strInterfaceDescription(511) As Byte
    isState As Integer
End Type
' WLAN_INTERFACE_INFO, *PWLAN_INTERFACE_INFO;
'16+512+4=532 bytes total


Private Type WLAN_INTERFACE_INFO_LIST
    dwNumberOfItems As Long
    dwIndex As Long
    InterfaceInfo(1) As WLAN_INTERFACE_INFO
End Type
'WLAN_INTERFACE_INFO_LIST, *PWLAN_INTERFACE_INFO_LIST;
'4+4+532=540 bytes total


Private Declare Function WlanOpenHandle Lib "Wlanapi.dll" ( _
    ByVal dwClientVersion As Long, _
    ByVal pReserved As Long, _
    ByRef pdwNegotiatedVersion As Long, _
    ByRef phClientHandle As Long _
    ) As Long
    
    
Private Declare Function WlanEnumInterfaces Lib "Wlanapi.dll" (ByVal hClientHandle As Long, ByVal pReserved As Long, ByRef ppInterfaceList As Long) As Long

'out       PWLAN_INTERFACE_INFO_LIST *ppInterfaceList

Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Private Declare Function MultiByteToWideChar Lib "kernel32" (ByVal CodePage As Long, ByVal dwFlags As Long, ByVal lpMultiByteStr As String, ByVal cchMultiByte As Long, ByVal lpWideCharStr As String, ByVal cchWideChar As Long) As Long
Private Declare Function WideCharToMultiByte Lib "kernel32" (ByVal CodePage As Long, ByVal dwFlags As Long, ByRef lpWideCharStr As Any, ByVal cchWideChar As Long, ByVal lpMultiByteStr As String, ByVal cchMultiByte As Long, ByVal lpDefaultChar As String, ByVal lpUsedDefaultChar As Long) As Long



Private Sub Command1_Click()


Dim res As Long
Dim dwNegotiatedVersion As Long
Dim hClientHandle As Long

pdwNegotiatedVersion = 0
hClientHandle = 0


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

With wiiList.InterfaceInfo(0).InterfaceGuid

    r_guid = Hex(.data1) & "-" & Hex(.data2(0)) & Hex(.data2(1))
    r_guid = r_guid & "-" & Hex(.data3(1)) & Hex(.data3(0))         '注意字节顺序
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



MsgBox "G U I D :    " & r_guid & vbCrLf & "设备描述:    " & tmp







End Sub





























