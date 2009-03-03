VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Packet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Member0" ,"Packet"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit
Private Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long



Private m_data As String
Private m_ControlWord As Integer






Public Function GetData() As String

      GetData = m_data

End Function


Public Function Packet(data As String) As Boolean

      
      m_data = Trim(data)

      
      Packet = True

End Function


Public Function Parse() As Boolean

      'TO DO:
      '分离控制字
      
      If m_data = "GIVEMEATOKEN" Then
            m_ControlWord = PACKET_TOKENREQUEST
      ElseIf Left(m_data, 5) = "TOKEN" Then
            m_ControlWord = PACKET_TOKEN
            m_data = Mid(m_data, 6)
      ElseIf m_data = "DISCONNECT" Then
            m_ControlWord = PACKET_DISCONNECT
      Else
            m_ControlWord = PACKET_HANDSHAKE
      End If
      
End Function

Public Property Get ControlWord() As Integer

      ControlWord = m_ControlWord
      
End Property



Public Function MakeHandshakePacket() As Boolean

Dim Name As String, Length As Long



      MakeHandshakePacket = True

      If m_data = "" Then
            m_data = "AREYOUASERVER?"
      ElseIf m_data = "AREYOUASERVER?" Then
            m_data = "YESIAMASERVER"
      ElseIf m_data = "YESIAMASERVER" Then
            m_data = "GIVEMEYOURID."
      ElseIf m_data = "GIVEMEYOURID." Then
            Length = 225
            Name = String(Length, Chr(0))
            GetComputerName Name, Length
            Name = Left(Name, Length)
            m_data = "ID" & Name
      ElseIf Left(m_data, 2) = "ID" Then
            m_data = Mid(m_data, 3)
            MakeHandshakePacket = False
      End If

End Function



Public Function MakeSpeedTestPacket() As Boolean



'这个不用类实现，直接写wskSpeedTest的事件。


      If Left(m_data, 9) <> "SPEEDTEST" Then
            MakeSpeedTestPacket = False
            Exit Function
      End If
      
      If Val(Mid(m_data, 10)) = 10 Then
            MakeSpeedTestPacket = False
            Exit Function
      End If
      
      m_data = "SPEEDTEST" & Trim(Str(Val(Mid(m_data, 10)) + 1))
      MakeSpeedTestPacket = True
      
End Function


Public Function MakeAlivePacket() As Boolean
      
      If m_data = "" Then
            m_data = "IAMALIVE"
            MakeAlivePacket = True
      ElseIf m_data = "IAMALIVE" Then
            m_data = "OKYOUAREALIVE"
            MakeAlivePacket = True
      ElseIf m_data = "OKYOUAREALIVE" Then
            m_data = ""
            MakeAlivePacket = False
      End If
      
End Function

