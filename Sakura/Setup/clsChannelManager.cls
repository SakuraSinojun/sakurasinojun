VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsChannelManager"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


Private m_SChannel(64) As Integer
Private m_RChannel(64) As Integer




Public Function InitChannelManager()

    Dim i As Integer
    
    For i = 0 To 64
        m_SChannel(i) = 0
        m_RChannel(i) = 0
    Next i


End Function


Public Function FreeSChannel() As Integer
    
    Dim i As Integer
    
    For i = 1 To 64
        
        If m_SChannel(i) = 0 Then
            m_SChannel(i) = 1
            FreeSChannel = i
            Exit Function
        End If
    Next i

    FreeSChannel = 0

End Function


Public Function FreeRChannel() As Integer

    Dim i As Integer
    
    For i = 1 To 64
        
        If m_RChannel(i) = 0 Then
            m_RChannel(i) = 1
            FreeRChannel = i
            Exit Function
        End If
    Next i
    
    FreeRChannel = 0

End Function
