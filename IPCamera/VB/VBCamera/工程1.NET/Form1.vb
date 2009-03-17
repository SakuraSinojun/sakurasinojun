Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Friend Class Form1
	Inherits System.Windows.Forms.Form
	Dim Video_Handle As Integer
	
	
	
	Private Sub Command1_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Command1.Click
		Video_Handle = CreateCaptureWindow((Picture1.Handle.ToInt32))
	End Sub
	
	Private Sub Command2_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Command2.Click
		
		capDlgVideoSource(Video_Handle)
		
	End Sub
	
	Private Sub Command3_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Command3.Click
		Disconnect(Video_Handle)
	End Sub
	
	Private Sub Command4_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Command4.Click
		
		Dim pic As System.Drawing.Image
        Dim path As String

		pic = CapturePicture(Video_Handle)
		Picture2.Image = pic
		
		path = My.Application.Info.DirectoryPath
		If VB.Right(path, 1) <> "\" Then
			path = path & "\"
		End If

        'UPGRADE_WARNING: SavePicture 已升级到 System.Drawing.Image.Save 并具有新行为。 单击以获得更多信息:“ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="9B7D5ADD-D8FE-4819-A36C-6DEDAF088CC7"”
        pic.Save(path & "pic.bmp")

        MsgBox("图像存至:" & path & "pic.bmp", MsgBoxStyle.Information)

    End Sub
	
	Private Sub Command5_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Command5.Click
		
		capDlgVideoFormat(Video_Handle)
		'UPGRADE_ISSUE: PictureBox 方法 Picture1.Cls 未升级。 单击以获得更多信息:“ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"”
        'Picture1.Cls()
		
		
	End Sub
	
	Private Sub Command6_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Command6.Click
		
		capDlgVideoCompression(Video_Handle)
		
	End Sub
	
	
	
	Private Sub Form1_FormClosed(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
		Disconnect(Video_Handle)
	End Sub
End Class