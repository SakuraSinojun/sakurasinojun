VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsClient"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Function FreeClient() As Integer

    Dim i As Integer
    For i = 1 To CL_MAXCLIENT
        If m_clients(i).IPAddress = "" Then
            FreeClient = i
            Exit Function
        End If
    Next i
    
    FreeClient = 0
    
End Function

Public Function QueryClientIndex(IPAddress As String) As Integer
    
    '返回值为0表示不存在，否刚返回当前index.
    
    Dim i As Integer
    
    For i = 1 To CL_MAXCLIENT
        If m_clients(i).IPAddress = IPAddress Then
            QueryClientIndex = i
            Exit Function
        End If
    Next i
    
    QueryClientIndex = 0

End Function

Public Function QueryClientExeIndex(index As Integer, ExeName As String) As Integer

    Dim i As Integer
    Dim exe As SZEXENAME
    
    lstrcpyS2L VarPtr(exe), ExeName

    For i = 1 To 19
        If lstrcmp(VarPtr(m_clients(index).exe(i).ExeName), VarPtr(exe)) = 0 Then
            QueryClientExeIndex = i
            Exit Function
        End If
    Next i
    
    QueryClientExeIndex = 0
    
End Function


Public Sub AddClient(IPAddress As String, ExeName As String)
    
    AddClientEx IPAddress, ExeName, 0, 0
    m_bIsClientsChanged = True
    Form1.RefreshClient
    
End Sub

Public Sub AddClientEx(IPAddress As String, ExeName As String, ByVal DataFrom As Long, ByVal DataTo As Long)
    
    'DataFrom,DataTo as DATASTREAMLIST
    Dim data As DATASTREAMLIST
    
    Dim tmp As SZEXENAME
    
    Dim index As Integer
    Dim i As Integer
    Dim j As Integer
    
    
    index = QueryClientIndex(IPAddress)
    
    lstrcpyS2L VarPtr(tmp), ExeName
    
    
    If (index = 0) Then
        index = FreeClient
        m_clients(index).IPAddress = IPAddress
    Else
    End If
    
    
    If ExeName = "" Then
        Exit Sub
    End If
    
    AddExeName IPAddress, ExeName
    
    If DataFrom = 0 And DataTo = 0 Then
        Form1.RefreshClient
        Exit Sub
    End If
    
    If DataFrom <> 0 Then
        CopyMemory data, ByVal DataFrom, LenB(data)
        'CopyMemory m_clients(index).DataFrom, ByVal DataFrom, ByVal 8207
        For i = 1 To 19
            If lstrcmp(VarPtr(tmp), VarPtr(m_clients(index).exe(i).ExeName)) = 0 Then
                For j = 1 To 19
                    If lstrcmp(ByVal VarPtr(data.IPAddress(0)), ByVal VarPtr(m_clients(index).exe(i).DataFrom(j).IPAddress(0))) = 0 Then
                        '已存在，不需添加，跳出。
                        GoTo out1
                    End If
                Next j
                '不存在
                For j = 1 To 19
                    If m_clients(index).exe(i).DataFrom(j).IPAddress(0) = 0 Then
                        '添加
                        lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataFrom(j).IPAddress(0)), ByVal VarPtr(data.IPAddress(0))
                        lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataFrom(j).ExeName), ByVal VarPtr(data.ExeName)
                        
                        lstrcpyS2L VarPtr(data.IPAddress(0)), m_clients(index).IPAddress
                        lstrcpyL2L VarPtr(data.ExeName), VarPtr(m_clients(index).exe(i).ExeName)
                        
                        'DeleteClientEx StrL2S(VarPtr(data.IPAddress(0))), StrL2S(VarPtr(data.ExeName)), 0, m_clients(index).IPAddress, False
                        'AddClientOrig StrL2S(VarPtr(data.IPAddress(0))), StrL2S(VarPtr(data.ExeName)), 0, VarPtr(data)
                        
                        GoTo out1
                    End If
                Next j
            End If
        Next i
        '循环查找完成，不存在现有程序配置
        For i = 1 To 19
            If m_clients(index).exe(i).ExeName.cont(0) = 0 Then
                '找到空闲位置放置程序配置
                lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).ExeName), ByVal VarPtr(data.ExeName)
                lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataFrom(1).IPAddress(0)), ByVal VarPtr(data.IPAddress(0))
                lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataFrom(1).ExeName), ByVal VarPtr(data.ExeName)
                
                lstrcpyS2L VarPtr(data.IPAddress(0)), m_clients(index).IPAddress
                lstrcpyL2L VarPtr(data.ExeName), VarPtr(m_clients(index).exe(i).ExeName)
                
                'DeleteClientEx StrL2S(VarPtr(data.IPAddress(0))), StrL2S(VarPtr(data.ExeName)), 0, m_clients(index).IPAddress, False
                'AddClientOrig StrL2S(VarPtr(data.IPAddress(0))), StrL2S(VarPtr(data.ExeName)), 0, VarPtr(data)
        
                Exit For
            End If
        Next i
    End If
    
out1:

    If DataTo <> 0 Then
        CopyMemory data, ByVal DataTo, LenB(data)
        'CopyMemory m_clients(index).datato, ByVal datato, ByVal 8207
        For i = 1 To 19
            If lstrcmp(VarPtr(tmp), VarPtr(m_clients(index).exe(i).ExeName)) = 0 Then
                For j = 1 To 19
                    If lstrcmp(ByVal VarPtr(data.IPAddress(0)), ByVal VarPtr(m_clients(index).exe(i).DataTo(j).IPAddress(0))) = 0 Then
                        '已存在，不需添加，跳出。
                        GoTo out
                    End If
                Next j
                '不存在
                For j = 1 To 19
                    If m_clients(index).exe(i).DataTo(j).IPAddress(0) = 0 Then
                        '添加
                        lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataTo(j).IPAddress(0)), ByVal VarPtr(data.IPAddress(0))
                        lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataTo(j).ExeName), ByVal VarPtr(data.ExeName)
                        
                        lstrcpyS2L VarPtr(data.IPAddress(0)), m_clients(index).IPAddress
                        lstrcpyL2L VarPtr(data.ExeName), VarPtr(m_clients(index).exe(i).ExeName)
                        
                        'DeleteClientEx StrL2S(VarPtr(data.IPAddress(0))), StrL2S(VarPtr(data.ExeName)), 0, m_clients(index).IPAddress, True
                        'AddClientOrig StrL2S(VarPtr(data.IPAddress(0))), StrL2S(VarPtr(data.ExeName)), VarPtr(data), 0
                        
                        GoTo out
                    End If
                Next j
            End If
        Next i
        '循环查找完成，不存在现有程序配置
        For i = 1 To 19
            If m_clients(index).exe(i).ExeName.cont(0) = 0 Then
                '找到空闲位置放置程序配置
                lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).ExeName), ByVal VarPtr(data.ExeName)
                lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataTo(1).IPAddress(0)), ByVal VarPtr(data.IPAddress(0))
                lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataTo(1).ExeName), ByVal VarPtr(data.ExeName)
                
                lstrcpyS2L VarPtr(data.IPAddress(0)), m_clients(index).IPAddress
                lstrcpyL2L VarPtr(data.ExeName), VarPtr(m_clients(index).exe(i).ExeName)
                'DeleteClientEx StrL2S(VarPtr(data.IPAddress(0))), StrL2S(VarPtr(data.ExeName)), 0, m_clients(index).IPAddress, True
                'AddClientOrig StrL2S(VarPtr(data.IPAddress(0))), StrL2S(VarPtr(data.ExeName)), VarPtr(data), 0
                Exit For
            End If
        Next i
    End If
    

out:
    
    m_bIsClientsChanged = True
    'Form1.RefreshClient

End Sub



Private Sub AddClientOrig(IPAddress As String, ExeName As String, ByVal DataFrom As Long, ByVal DataTo As Long)
    
    'DataFrom,DataTo as DATASTREAMLIST
    Dim data As DATASTREAMLIST
    
    Dim tmp As SZEXENAME
    
    Dim index As Integer
    Dim i As Integer
    Dim j As Integer
    
    
    index = QueryClientIndex(IPAddress)
    
    lstrcpyS2L VarPtr(tmp), ExeName
    
    
    If (index = 0) Then
        index = FreeClient
        m_clients(index).IPAddress = IPAddress
    Else
    End If
    
    
    If ExeName = "" Then
        Exit Sub
    End If
    
    AddExeName IPAddress, ExeName
    
    If DataFrom = 0 And DataTo = 0 Then
        Form1.RefreshClient
        Exit Sub
    End If
    
    If DataFrom <> 0 Then
        CopyMemory data, ByVal DataFrom, LenB(data)
        'CopyMemory m_clients(index).DataFrom, ByVal DataFrom, ByVal 8207
        For i = 1 To 19
            If lstrcmp(VarPtr(tmp), VarPtr(m_clients(index).exe(i).ExeName)) = 0 Then
                For j = 1 To 19
                    If lstrcmp(ByVal VarPtr(data.IPAddress(0)), ByVal VarPtr(m_clients(index).exe(i).DataFrom(j).IPAddress(0))) = 0 Then
                        '已存在，不需添加，跳出。
                        GoTo out1
                    End If
                Next j
                '不存在
                For j = 1 To 19
                    If m_clients(index).exe(i).DataFrom(j).IPAddress(0) = 0 Then
                        '添加
                        lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataFrom(j).IPAddress(0)), ByVal VarPtr(data.IPAddress(0))
                        lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataFrom(j).ExeName), ByVal VarPtr(data.ExeName)
                        GoTo out1
                    End If
                Next j
            End If
        Next i
        '循环查找完成，不存在现有程序配置
        For i = 1 To 19
            If m_clients(index).exe(i).ExeName.cont(0) = 0 Then
                '找到空闲位置放置程序配置
                lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).ExeName), ByVal VarPtr(data.ExeName)
                lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataFrom(1).IPAddress(0)), ByVal VarPtr(data.IPAddress(0))
                lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataFrom(1).ExeName), ByVal VarPtr(data.ExeName)
                Exit For
            End If
        Next i
    End If
    
out1:

    If DataTo <> 0 Then
        CopyMemory data, ByVal DataTo, LenB(data)
        'CopyMemory m_clients(index).datato, ByVal datato, ByVal 8207
        For i = 1 To 19
            If lstrcmp(VarPtr(tmp), VarPtr(m_clients(index).exe(i).ExeName)) = 0 Then
                For j = 1 To 19
                    If lstrcmp(ByVal VarPtr(data.IPAddress(0)), ByVal VarPtr(m_clients(index).exe(i).DataTo(j).IPAddress(0))) = 0 Then
                        '已存在，不需添加，跳出。
                        GoTo out
                    End If
                Next j
                '不存在
                For j = 1 To 19
                    If m_clients(index).exe(i).DataTo(j).IPAddress(0) = 0 Then
                        '添加
                        lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataTo(j).IPAddress(0)), ByVal VarPtr(data.IPAddress(0))
                        lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataTo(j).ExeName), ByVal VarPtr(data.ExeName)
                        GoTo out
                    End If
                Next j
            End If
        Next i
        '循环查找完成，不存在现有程序配置
        For i = 1 To 19
            If m_clients(index).exe(i).ExeName.cont(0) = 0 Then
                '找到空闲位置放置程序配置
                lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).ExeName), ByVal VarPtr(data.ExeName)
                lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataTo(1).IPAddress(0)), ByVal VarPtr(data.IPAddress(0))
                lstrcpyL2L ByVal VarPtr(m_clients(index).exe(i).DataTo(1).ExeName), ByVal VarPtr(data.ExeName)
                Exit For
            End If
        Next i
    End If
    

out:
    
    m_bIsClientsChanged = True
    'Form1.RefreshClient

End Sub


Public Sub DeleteClient(IPAddress As String, ExeName As String)
    
    '删除某条信息
    m_bIsClientsChanged = True
    
    Dim index As Integer
    Dim i As Integer
    
    index = QueryClientIndex(IPAddress)
    
    If ExeName = "" Then
        For i = 1 To 19
            m_clients(index).exe(i).ExeName.cont(0) = 0
        Next i
        m_clients(i).IPAddress = ""
    Else
        For i = 1 To 19
            If lstrcmp(VarPtr(m_clients(index).exe(i).ExeName), VarPtr(ExeName)) = 0 Then
                m_clients(index).exe(i).ExeName.cont(0) = 0
                Exit For
            End If
        Next i
    End If
    
    
    Form1.RefreshClient
    
End Sub

Public Sub DeleteClientEx(IPAddressToSet As String, ExeName As String, IPAddressIndex As Integer, IPAddress As String, bDataFrom As Boolean)
    '
    '当IPAddressIndex=0时，以照IPAddress判断IP
    '当IPAddress为""时，依照IPAddressIndex判断IP
    '两者皆为0时，表示从记录中删除某程序名
    'ExeName为空时，表示某IP离线。
    
    
    
    Dim IPIndex1 As Integer
    Dim ExeIndex As Integer
    Dim IPIndex2 As Integer
    
    Dim i As Integer
    
    
    
    
    
    If IPAddressToSet = "" Then Exit Sub
    
    
    IPIndex1 = QueryClientIndex(IPAddressToSet)
    
    
    If ExeName = "" Then
        'IP离线
        
        Exit Sub
    End If
    
    ExeIndex = QueryClientExeIndex(IPIndex1, ExeName)
    
    
    If IPAddressIndex = 0 And IPAddress = "" Then
        '程序离线
        
        Exit Sub
    End If
    
    If IPAddress = "" Then
        '依照IPAddressIndex删除记录
        If bDataFrom = True Then
        Else
        End If
        
        Exit Sub
    End If
    
    If IPAddressIndex = 0 Then
        '依照IPAddress查找记录
        If bDataFrom = True Then
            For i = 1 To 19
                If StrL2S(VarPtr(m_clients(IPIndex1).exe(ExeIndex).DataFrom(i).IPAddress(0))) = IPAddress Then
                    m_clients(IPIndex1).exe(ExeIndex).DataFrom(i).IPAddress(0) = 0
                    m_clients(IPIndex1).exe(ExeIndex).DataFrom(i).ExeName.cont(0) = 0
                    Exit For
                End If
            Next i
        Else
            For i = 1 To 19
                Debug.Print StrL2S(VarPtr(m_clients(IPIndex1).exe(ExeIndex).DataTo(i).IPAddress(0)))
                If StrL2S(VarPtr(m_clients(IPIndex1).exe(ExeIndex).DataTo(i).IPAddress(0))) = IPAddress Then
                    m_clients(IPIndex1).exe(ExeIndex).DataTo(i).IPAddress(0) = 0
                    m_clients(IPIndex1).exe(ExeIndex).DataTo(i).ExeName.cont(0) = 0
                    Exit For
                End If
            Next i
        End If
        
        Exit Sub
    End If
    
    
    
End Sub


Private Sub AddExeName(IPAddress As String, ExeName As String)

    Dim i As Integer
    Dim index As Integer
    Dim msg As String
    Dim exe As SZEXENAME
    
    index = QueryClientIndex(IPAddress)
    If index = 0 Then AddClient IPAddress, ExeName
    
    For i = 1 To 19
        lstrcpyS2L VarPtr(exe), ExeName
        
        'msg = String(100, " ")
        'lstrcpyL2S msg, VarPtr(m_clients(index).exe(i).ExeName)
        'msg = Trim(msg)
        'msg = LeftB(msg, lstrlenL(VarPtr(m_clients(index).exe(i).ExeName)))
        If lstrcmp(VarPtr(m_clients(index).exe(i).ExeName), VarPtr(exe)) = 0 Then
            Exit Sub
        End If
    Next i
    
    For i = 1 To 19
        If m_clients(index).exe(i).ExeName.cont(0) = 0 Then
            lstrcpyS2L VarPtr(m_clients(index).exe(i).ExeName), ExeName
              
            Form1.RefreshClient
            Exit Sub
            'Exit For
        End If
    Next i


End Sub


Public Sub Initialize()

    Dim i As Integer
    Dim j As Integer
    Dim k As Integer
    For i = 1 To CL_MAXCLIENT
        m_clients(i).IPAddress = ""
        For j = 1 To 19
            m_clients(i).exe(j).ExeName.cont(0) = 0
            For k = 1 To 19
                m_clients(i).exe(j).DataFrom(k).IPAddress(0) = 0
                m_clients(i).exe(j).DataFrom(k).ExeName.cont(0) = 0
            Next k
        Next j
    Next i
      

End Sub































