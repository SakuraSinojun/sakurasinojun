VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "StkConnect"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Member0" ,"StkCon"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Private Const AgCError As Long = -1
Private Const AgCNoError As Long = 0
Private Const AgCNackReturned As Long = -2

Private connection As Long
Dim returnedData() As String
Private numEntries As Long
Private ret As Long
Private timeout As Long
Private initialized As Boolean
Private connectedToSTK As Boolean
Private ACK As Boolean

Private Declare Function AgVbConOpenSTK Lib "./AgVbConnect" Alias _
    "_AgVbConOpenSTK@8" (ByRef connection As Long, ByVal name$) As Long
Private Declare Function AgVbConCloseSTK Lib "./AgVbConnect" Alias _
    "_AgVbConCloseSTK@4" (ByRef connection As Long) As Long
Private Declare Function AgVbConProcessSTKCmd Lib "./AgVbConnect" Alias _
    "_AgVbConProcessSTKCmd@12" (ByRef connection As Long, ByVal cmd$, _
    returned() As String) As Long
Private Declare Function AgVbConSetTimeout Lib "./AgVbConnect" Alias _
    "_AgVbConSetTimeout@8" (ByRef connection As Long, ByVal duration As Long) As Long

Sub StkCon()
Attribute StkCon.VB_UserMemId = 0
    initialized = True
    connectedToSTK = False
    ACK = False
    ret = 0
    numEntries = -1
End Sub

Sub connect(connectionName$)
    If Not connectedToSTK Then
        ret = AgVbConOpenSTK(connection, connectionName)
        If ret = AgCNoError Then
            connectedToSTK = True
            ret = AgVbConSetTimeout(connection, 3600000)
        Else
            connectedToSTK = False
        End If
    Else
        ret = AgVbConCloseSTK(connection)
        If ret = AgCNoError Then
            ret = AgVbConOpenSTK(connection, connectionName)
            If ret = AgCNoError Then
                connectedToSTK = True
                ret = AgVbConSetTimeout(connection, 3600000)
            Else
                connectedToSTK = False
            End If
        End If
    End If
End Sub

Sub disconnect()
    If connectedToSTK Then
        ret = AgVbConCloseSTK(connection)
        If ret = AgCNoError Then
            connectedToSTK = False
        End If
    End If
End Sub

Function connected() As Boolean
    connected = connectedToSTK
End Function

Sub sendCommand(command$)
    Dim buffer() As String
    If connectedToSTK And Len(command) > 1 Then
        ret = AgVbConProcessSTKCmd(connection, command, buffer)
        If ret <> AgCNackReturned Then
            ACK = True
        Else
            ACK = False
        End If
        numEntries = UBound(buffer)
        returnedData = buffer
    End If
End Sub

Sub setTimeout(timeoutPeriod As Long)
    If timeoutPeriod > 2147483 Then
        timeout = 2147483647
    ElseIf timeoutPeriod < 0 Then
        timeout = 30000
    Else
        timeout = timeoutPeriod * 1000
    End If
        
    If connectedToSTK Then
        ret = AgVbConSetTimeout(connection, timeout)
    End If
End Sub

Function getTimeout() As Long
    getTimeout = timeout / 1000
End Function

Function getAckAsString() As String
    If ACK = True Then
        getAckAsString = "ACK"
    Else
        getAckAsString = "NACK"
    End If
End Function

Function getAck() As Boolean
    getAck = ACK
End Function

Function getNumEntries() As Long
    getNumEntries = numEntries
End Function

Function returnedLine(ByVal Index As Long) As String
    If Index <= numEntries And Index >= 0 Then
        returnedLine = returnedData(Index)
    Else
        returnedLine = "Invalid Index Imax=" & numEntries
    End If
End Function
