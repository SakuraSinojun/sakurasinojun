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
   StartUpPosition =   3  '����ȱʡ
   Begin VB.TextBox Text1 
      Height          =   4110
      Left            =   1200
      MultiLine       =   -1  'True
      TabIndex        =   1
      Top             =   405
      Width           =   8295
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   510
      Left            =   1200
      TabIndex        =   0
      Top             =   4560
      Width           =   3645
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



Private Sub Command1_Click()


Dim res As Long
Dim dwNegotiatedVersion As Long
Dim hClientHandle As Long

pdwNegotiatedVersion = 0
hClientHandle = 0


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

Text1.Text = "G U I D :    " & r_guid & vbCrLf & "�豸����:    " & tmp & vbCrLf & wiiList.InterfaceInfo(0).isState







End Sub


