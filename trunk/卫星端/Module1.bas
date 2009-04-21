Attribute VB_Name = "Module1"
Option Explicit

Public Enum eCommand
    vTAB
    tPOS
    vQST
    vGET
    sEND
    sSND
    vPHT
    zQST
    zTAB
End Enum

Public Type tPack
    
    eCMD As eCommand        '2¸ö×Ö½Ú
    iDisTime As Long         '4
    iConTime As Long         '4
    iStep As Integer        '2
    lTotalLength As Long    '4
    lSendLength As Long     '4
    iID As Integer          '2
    bFilepack(1023) As Byte '1024
End Type

'totalbytes=1046
