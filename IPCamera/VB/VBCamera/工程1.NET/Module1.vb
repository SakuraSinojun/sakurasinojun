Option Strict Off
Option Explicit On
Module Module1
	
	
	Private Declare Function capCreateCaptureWindow Lib "avicap32.dll"  Alias "capCreateCaptureWindowA"(ByVal lpszWindowName As String, ByVal dwStyle As Integer, ByVal x As Integer, ByVal y As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hWndParent As Integer, ByVal nID As Integer) As Integer
	
	Private Const WS_CHILD As Integer = &H40000000
	Private Const WS_VISIBLE As Integer = &H10000000
	Private Const WM_USER As Integer = &H400
	Private Const WM_CAP_START As Integer = &H400
	Private Const WM_CAP_EDIT_COPY As Decimal = (WM_CAP_START + 30)
	Private Const WM_CAP_DRIVER_CONNECT As Decimal = (WM_CAP_START + 10)
	Private Const WM_CAP_SET_PREVIEWRATE As Decimal = (WM_CAP_START + 52)
	Private Const WM_CAP_SET_OVERLAY As Decimal = (WM_CAP_START + 51)
	Private Const WM_CAP_SET_PREVIEW As Decimal = (WM_CAP_START + 50)
	Private Const WM_CAP_DRIVER_DISCONNECT As Decimal = (WM_CAP_START + 11)
	Private Const WM_CAP_DLG_VIDEOFORMAT As Decimal = (WM_CAP_START + 41)
	Private Const WM_CAP_DLG_VIDEOSOURCE As Decimal = (WM_CAP_START + 42)
	Private Const WM_CAP_DLG_VIDEODISPLAY As Decimal = (WM_CAP_START + 43)
	Private Const WM_CAP_DLG_VIDEOCOMPRESSION As Decimal = (WM_CAP_START + 46)
	
	'UPGRADE_ISSUE: 不支持将参数声明为“As Any”。 单击以获得更多信息:“ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"”
    Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, ByRef lParam As Long) As Integer
	
	Private Preview_Handle As Integer
	
	
	Public Function CreateCaptureWindow(ByRef hWndParent As Integer, Optional ByRef x As Integer = 0, Optional ByRef y As Integer = 0, Optional ByRef nWidth As Integer = 640, Optional ByRef nHeight As Integer = 480, Optional ByRef nCameraID As Integer = 0) As Integer
		
		Preview_Handle = capCreateCaptureWindow("Video", WS_CHILD + WS_VISIBLE, x, y, nWidth, nHeight, hWndParent, 1)
		
		SendMessage(Preview_Handle, WM_CAP_DRIVER_CONNECT, nCameraID, 0)
		SendMessage(Preview_Handle, WM_CAP_SET_PREVIEWRATE, 30, 0)
		SendMessage(Preview_Handle, WM_CAP_SET_OVERLAY, 1, 0)
		SendMessage(Preview_Handle, WM_CAP_SET_PREVIEW, 1, 0)
		
		CreateCaptureWindow = Preview_Handle
	End Function
	
	
	Public Function CapturePicture(ByRef nCaptureHandle As Integer) As System.Drawing.Image
		My.Computer.Clipboard.Clear()
		SendMessage(nCaptureHandle, WM_CAP_EDIT_COPY, 0, 0)
		CapturePicture = My.Computer.Clipboard.GetImage()
	End Function
	
	
	Public Sub Disconnect(ByRef nCaptureHandle As Integer, Optional ByRef nCameraID As Object = 0)
		
		'UPGRADE_WARNING: 未能解析对象 nCameraID 的默认属性。 单击以获得更多信息:“ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"”
		SendMessage(nCaptureHandle, WM_CAP_DRIVER_DISCONNECT, nCameraID, 0)
	End Sub
	
	
	
	Public Sub capDlgVideoSource(ByRef nCaptureHandle As Integer)
		
		SendMessage(nCaptureHandle, WM_CAP_DLG_VIDEOSOURCE, 0, 0)
		
	End Sub
	
	Public Sub capDlgVideoFormat(ByRef nCaptureHandle As Integer)
		
		SendMessage(nCaptureHandle, WM_CAP_DLG_VIDEOFORMAT, 0, 0)
		
	End Sub
	
	
	
	
	Public Sub capDlgVideoCompression(ByRef nCaptureHandle As Integer)
		
		SendMessage(nCaptureHandle, WM_CAP_DLG_VIDEOCOMPRESSION, 0, 0)
		
	End Sub
End Module