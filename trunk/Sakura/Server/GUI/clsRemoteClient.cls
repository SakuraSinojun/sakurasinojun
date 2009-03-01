VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsRemoteClient"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


Private m_Client(512) As String


Public Sub Init()

      Dim i As Integer
      For i = 1 To 512
            m_Client(i) = ""
      Next i

End Sub

Public Function Check(IP As String) As Boolean

Dim i As Integer

      For i = 1 To 512
            If IP = m_Client(i) Then
                  Check = True
                  Exit Function
            End If
      Next i
      
      Check = False

End Function



Public Function Delete(IP As String) As Boolean


Dim i As Integer

      For i = 1 To 512
            If IP = m_Client(i) Then
                  m_Client(i) = ""
                  Exit For
            End If
      Next i
      
End Function

Public Function Add(IP As String) As Boolean

Dim i As Integer

      For i = 1 To 512
            If "" = m_Client(i) Then
                  m_Client(i) = IP
                  Exit For
            End If
      Next i
      
End Function
