Attribute VB_Name = "mdlCommand"
Option Explicit






Public Type SETCHANNEL
    Command As Byte
    IPAddress(15) As Byte
    SendChannel As Byte
    RecvChannel As Byte
End Type

Public Const CMD_SHOWWINDOW = 1
Public Const CMD_SETCHANNEL = 2
Public Const CMD_EXIT = 3
Public Const CMD_CONNECT = 4
Public Const CMD_REFRESHLOCALFILE = 5


