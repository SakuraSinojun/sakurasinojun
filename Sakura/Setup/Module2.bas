Attribute VB_Name = "Module2"
Option Explicit



Public Sub WriteNetConfigFile()
    
    '
    Dim i As Integer, j As Integer, k As Integer
    
    
    Dim IPAddress As String
    Dim ExeName As String
    Dim tmp As String
    Dim resFrom As String
    Dim resTo As String
    
    
    Dim temp As String
    
    
    resFrom = ""
    resTo = ""
    
    For i = 1 To CL_MAXCLIENT
        If m_clients(i).IPAddress <> "" Then
            
            Debug.Print "Now :" & m_clients(i).IPAddress
            
            For j = 1 To 19
                If (m_clients(i).exe(j).ExeName.cont(0) <> 0) Then
                    
                    temp = StrL2S(VarPtr(m_clients(i).exe(j).ExeName))
                    Debug.Print "   ExeName:" & temp
                    
                    For k = 1 To 19
                        If m_clients(i).exe(j).DataFrom(k).IPAddress(0) <> 0 Then
                                    
                            temp = StrL2S(VarPtr(m_clients(i).exe(j).DataFrom(k).IPAddress(0)))
                            Debug.Print "       IPAddress:" & temp
                            
                            IPAddress = m_clients(i).IPAddress
                            tmp = IPAddress
                            ExeName = StrL2S(VarPtr(m_clients(i).exe(j).ExeName))
                            
                            Debug.Print "           ExeName:" & ExeName
                            
                            tmp = tmp & "->" & ExeName
                            IPAddress = StrL2S(VarPtr(m_clients(i).exe(j).DataFrom(k).IPAddress(0)))
                            tmp = tmp & "==>" & IPAddress
                            ExeName = StrL2S(VarPtr(m_clients(i).exe(j).DataFrom(k).ExeName))
                            tmp = tmp & "->" & ExeName

                            resFrom = resFrom & tmp & vbCrLf
                        End If
                        
                        If m_clients(i).exe(j).DataTo(k).IPAddress(0) <> 0 Then
                                    
                            temp = StrL2S(VarPtr(m_clients(i).exe(j).DataTo(k).IPAddress(0)))
                            Debug.Print "       IPAddress:" & temp
                            
                            IPAddress = m_clients(i).IPAddress
                            tmp = IPAddress
                            ExeName = StrL2S(VarPtr(m_clients(i).exe(j).ExeName))
                            
                            Debug.Print "           ExeName:" & ExeName
                            
                            tmp = tmp & "->" & ExeName
                            IPAddress = StrL2S(VarPtr(m_clients(i).exe(j).DataTo(k).IPAddress(0)))
                            tmp = tmp & "<==" & IPAddress
                            ExeName = StrL2S(VarPtr(m_clients(i).exe(j).DataTo(k).ExeName))
                            tmp = tmp & "->" & ExeName

                            resTo = resTo & tmp & vbCrLf
                        End If
                    Next k
                End If
            Next j
        End If
    Next i
    
    'MsgBox resFrom & resTo
    Dim fp As Integer
    
    fp = FreeFile
    Open App.path & "\NetConfig.txt" For Output As #fp
    
        Print #fp, resFrom & resTo
        
    Close fp
    
    Form1.ConfigNetwork
    
    
End Sub



Public Function StrL2S(ByVal lstr As Long) As String

    Dim tmp As String
    Dim i As Integer
    i = lstrlenL(lstr)
    tmp = String(i + 1, " ")
    lstrcpyL2S tmp, lstr
    
    i = InStr(tmp, Chr(0))
    
    If i > 0 Then
        tmp = Left(tmp, i - 1)
    End If
    
    StrL2S = tmp

End Function



Public Function StartWith(string1 As String, string2 As String) As Boolean

    Dim l As Integer
    l = Len(string2)
    If l > Len(string1) Then
        StartWith = False
        Exit Function
    End If
    
    If Left(string1, l) = string2 Then
        StartWith = True
        Exit Function
    End If
    
    StartWith = False

End Function
















