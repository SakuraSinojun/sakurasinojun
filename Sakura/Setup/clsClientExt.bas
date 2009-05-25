Attribute VB_Name = "clsClientExt"
Option Explicit



Public Const CL_MAXCLIENT = 128


Public Type SZEXENAME
    cont(63) As Byte
End Type
'64 bytes


Public Type DATASTREAMLIST
    IPAddress(15) As Byte           '16 bytes
    ExeName As SZEXENAME        '32 x 64 bytes
End Type
'2064 bytes total


Public Type EXEINFO
    ExeName As SZEXENAME
    DataFrom(19) As DATASTREAMLIST
    DataTo(19) As DATASTREAMLIST
End Type
    
Public Type CLIENTINFO
    IPAddress As String
    exe(19) As EXEINFO              '可对20个exe进行设置
End Type


Public m_clients(CL_MAXCLIENT) As CLIENTINFO
    
    '最多128个client
    '于是TreeView控件KEY：
    '六位10进制数   128128
    '后三位为0时表示IP地址的节点



Public m_bIsClientsChanged As Boolean



'数据包:

Public Type PACKET_CLIENT
    IPAddress(15) As Byte
    ExeName As SZEXENAME
    bIsDataFrom As Byte             '1=DataFrom,0=DataTo
    bIsAddClient As Byte            '1=AddClient,0=DeleteClient
    DataStream As DATASTREAMLIST
End Type
































