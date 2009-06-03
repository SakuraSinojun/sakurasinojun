VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsChannel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private channel(128) As Integer


Public Function AddChannel(chn As Integer) As Integer

    If chn <= 0 Or chn > 128 Then Exit Function
    
    channel(chn) = 1
    

End Function



Public Function DeleteChannel(chn As Integer) As Integer
    
    If chn <= 0 Or chn > 128 Then Exit Function
    
    channel(chn) = 0

End Function

Public Sub InitChannel()
    
    Dim i As Integer
    
    For i = 1 To 128
        channel(i) = 0
    Next i
    

End Sub


