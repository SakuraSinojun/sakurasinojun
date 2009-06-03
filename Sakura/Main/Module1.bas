Attribute VB_Name = "Module1"
 '增加模块(因为AddressOf   运算符必须要写到模块中)
  Option Explicit
    
  '------------------------------------------------------------------------------------------------------------------
  '系统托盘
  '------------------------------------------------------------------------------------------------------------------
  Public OldWindowProc     As Long
  Public TheForm     As Form
  Public TheMenu     As Menu
  Declare Function CallWindowProc Lib "user32" Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Long, ByVal hwnd As Long, ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
  Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
  Declare Function Shell_NotifyIcon Lib "shell32.dll" Alias "Shell_NotifyIconA" (ByVal dwMessage As Long, lpData As NOTIFYICONDATA) As Long
  Public Const WM_USER = &H400
  Public Const WM_LBUTTONUP = &H202
  Public Const WM_MBUTTONUP = &H208
  Public Const WM_RBUTTONUP = &H205
  Public Const TRAY_CALLBACK = (WM_USER + 1001&)
  Public Const GWL_WNDPROC = (-4)
  Public Const GWL_USERDATA = (-21)
  Public Const NIF_ICON = &H2
  Public Const NIF_TIP = &H4
  Public Const NIM_ADD = &H0
  Public Const NIF_MESSAGE = &H1
  Public Const NIM_MODIFY = &H1
  Public Const NIM_DELETE = &H2
    
  Public Type NOTIFYICONDATA
          cbSize   As Long
          hwnd   As Long
          uID   As Long
          uFlags   As Long
          uCallbackMessage   As Long
          hIcon   As Long
          szTip   As String * 64
  End Type
  Private TheData     As NOTIFYICONDATA
  '------------------------------------------------------------------------------------------------------------------
  '系统托盘处理过程
  '------------------------------------------------------------------------------------------------------------------
  '   *********************************************
  '   捕获托盘动作
  '   *********************************************
  Public Function NewWindowProc(ByVal hwnd As Long, ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
          If Msg = TRAY_CALLBACK Then
                  If lParam = WM_LBUTTONUP Then
                          If TheForm.WindowState = vbMinimized Then
                                  TheForm.WindowState = vbNormal
                          End If
                          TheForm.Show
                          Exit Function
                  End If
                  If lParam = WM_RBUTTONUP Then
                          TheForm.PopupMenu TheForm.mnu_file
                          Exit Function
                  End If
          End If
          NewWindowProc = CallWindowProc( _
                          OldWindowProc, hwnd, Msg, _
                          wParam, lParam)
  End Function
  '   *********************************************
  '   添加托盘图标
  '   *********************************************
  Public Sub AddToTray(frm As Form, Optional mnu As Menu)
    
          Set TheForm = frm
          Set TheMenu = mnu
    
          OldWindowProc = SetWindowLong(frm.hwnd, _
                          GWL_WNDPROC, AddressOf NewWindowProc)
          With TheData
                  .uID = 0
                  .hwnd = frm.hwnd
                  .cbSize = Len(TheData)
                  .hIcon = frm.Icon.Handle
                  .uFlags = NIF_ICON
                  .uCallbackMessage = TRAY_CALLBACK
                  .uFlags = .uFlags Or NIF_MESSAGE
                  .cbSize = Len(TheData)
          End With
          Shell_NotifyIcon NIM_ADD, TheData
  End Sub
  '   *********************************************
  '   移除托盘图标
  '   *********************************************
  Public Sub RemoveFromTray()
          With TheData
                  .uFlags = 0
          End With
          Shell_NotifyIcon NIM_DELETE, TheData
          SetWindowLong TheForm.hwnd, GWL_WNDPROC, _
                          OldWindowProc
  End Sub
  '   *********************************************
  '   设置托盘显示的文字
  '   *********************************************
  Public Sub SetTrayTip(tip As String)
          With TheData
                  .szTip = tip & vbNullChar
                  .uFlags = NIF_TIP
          End With
          Shell_NotifyIcon NIM_MODIFY, TheData
  End Sub






