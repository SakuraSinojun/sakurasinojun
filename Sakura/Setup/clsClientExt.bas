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
    exe(19) As EXEINFO              '�ɶ�20��exe��������
End Type


Public m_clients(CL_MAXCLIENT) As CLIENTINFO
    
    '���128��client
    '����TreeView�ؼ�KEY��
    '��λ10������   128128
    '����λΪ0ʱ��ʾIP��ַ�Ľڵ�



Public m_bIsClientsChanged As Boolean



'���ݰ�:

Public Type PACKET_CLIENT
    IPAddress(15) As Byte
    ExeName As SZEXENAME
    bIsDataFrom As Byte             '1=DataFrom,0=DataTo
    bIsAddClient As Byte            '1=AddClient,0=DeleteClient
    DataStream As DATASTREAMLIST
End Type
































