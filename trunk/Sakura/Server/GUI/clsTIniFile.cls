VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTIniFile"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Private szFileName As String

Public Function Initialize(FileName As String) As Long

      szFileName = FileName
      
End Function

Public Sub WriteString(Section As String, Ident As String, Value As String)


      Dim msg As String
      Dim Content As String
      Dim tmp As String
      
      Dim pFile As Integer
      Dim FLAG As Boolean
      
      
      msg = ReadString(Section, Ident, "DEFAULTVALUE")
      Reset
      
      pFile = FreeFile
      
      If msg = "DEFAULTVALUE" Then
            
            Content = ""
            FLAG = False
            Open szFileName For Input As #pFile
            While Not EOF(pFile)
                  Line Input #pFile, msg
                  msg = Trim(msg)
                  If msg <> "[" & Trim(Section) & "]" Then
                        Content = Content & msg & vbCrLf
                  Else
                        Content = Content & msg & vbCrLf
                        tmp = ""
                        Do While Not EOF(pFile)
                              Line Input #pFile, msg
                              msg = Trim(msg)
                              If msg <> "" Then
                                    If Left(msg, 1) = "[" Then
                                          Content = Content & Trim(Ident) & "=" & Trim(Value) & vbCrLf
                                          Content = Content & msg & vbCrLf
                                          FLAG = True
                                          Exit Do
                                    End If
                                    Content = Content & msg & vbCrLf
                              End If
                        Loop
                        If Not FLAG Then
                              Content = Content & Trim(Ident) & "=" & Trim(Value)
                              FLAG = True
                        End If
                  End If
            Wend
            If Not FLAG Then
                  Content = Content & "[" & Trim(Section) & "]" & vbCrLf
                  Content = Content & Trim(Ident) & "=" & Trim(Value)
            End If
      Else
            
            Content = ""
            Open szFileName For Input As #pFile
            While Not EOF(pFile)
                  Line Input #pFile, msg
                  msg = Trim(msg)
                  If msg <> "[" & Trim(Section) & "]" Then
                        Content = Content & msg & vbCrLf
                  Else
                        Content = Content & msg & vbCrLf
                        tmp = ""
                        Do While Not EOF(pFile)
                              Line Input #pFile, msg
                              msg = Trim(msg)
                              If msg <> "" Then
                                    If Len(msg) > Len(Trim(Ident)) Then
                                          If Left(msg, Len(Trim(Ident)) + 1) = Trim(Ident) & "=" Then
                                                msg = Trim(Ident) & "=" & Value
                                                Content = Content & msg & vbCrLf
                                                Exit Do
                                          End If
                                    End If
                                    Content = Content & msg & vbCrLf
                              End If
                        Loop
                  End If
            Wend
            
            Content = Left(Content, Len(Content) - 2)
      End If
      
      Close #pFile
      pFile = FreeFile
      Open szFileName For Output As #pFile
      Print #pFile, Content
      Close #pFile
      

End Sub


Public Function ReadString(Section As String, Ident As String, DefaultValue As String) As String

On Error GoTo whr

      Dim msg As String
      Dim pFile As Integer
      
      pFile = FreeFile
      
      Open szFileName For Input As #pFile
      
      While Not EOF(pFile)
            Line Input #pFile, msg
            msg = Trim(msg)
            If msg = "[" & Trim(Section) & "]" Then
                  While Not EOF(pFile)
                        Line Input #pFile, msg
                        msg = Trim(msg)
                        If msg <> "" Then
                              If Left(msg, 1) = "[" Then
                                    ReadString = DefaultValue
                                    Close #pFile
                                    Exit Function
                              Else
                                    If Len(msg) > Len(Trim(Ident)) Then
                                          If Left(msg, Len(Trim(Ident)) + 1) = Trim(Ident) & "=" Then
                                                msg = Trim(Mid(msg, Len(Trim(Ident)) + 2))
                                                If msg = "" Then msg = Trim(DefaultValue)
                                                ReadString = msg
                                                Close #pFile
                                                Exit Function
                                          End If
                                    End If
                              End If
                        End If
                  Wend
            End If
      Wend
      ReadString = DefaultValue
      
      Close #pFile
      
      Exit Function
whr:
      Err.Clear
      pFile = FreeFile
      Open szFileName For Output As pFile
      ReadString = DefaultValue
      Reset
      
End Function

