VERSION 5.00
Begin VB.Form Form1 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   Caption         =   "Form1"
   ClientHeight    =   7440
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   14745
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   496
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   983
   StartUpPosition =   3  '´°¿ÚÈ±Ê¡
   Begin VB.CommandButton Command7 
      Appearance      =   0  'Flat
      Caption         =   "capDlgVideoDisplay"
      Enabled         =   0   'False
      Height          =   450
      Left            =   9840
      TabIndex        =   8
      Top             =   6345
      Width           =   4770
   End
   Begin VB.CommandButton Command6 
      Appearance      =   0  'Flat
      Caption         =   "capDlgVideoCompression"
      Height          =   450
      Left            =   9840
      TabIndex        =   7
      Top             =   6870
      Width           =   4770
   End
   Begin VB.CommandButton Command5 
      Appearance      =   0  'Flat
      Caption         =   "capDlgVideoFormat"
      Height          =   450
      Left            =   9825
      TabIndex        =   6
      Top             =   5805
      Width           =   4770
   End
   Begin VB.CommandButton Command4 
      Appearance      =   0  'Flat
      Caption         =   "Capture"
      Height          =   450
      Left            =   9825
      TabIndex        =   5
      Top             =   4770
      Width           =   4770
   End
   Begin VB.CommandButton Command3 
      Appearance      =   0  'Flat
      Caption         =   "Stop"
      Height          =   450
      Left            =   9825
      TabIndex        =   4
      Top             =   4260
      Width           =   4770
   End
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
      Caption         =   "capDlgVideoSource"
      Height          =   450
      Left            =   9825
      TabIndex        =   3
      Top             =   5295
      Width           =   4770
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "Start"
      Height          =   450
      Left            =   9825
      TabIndex        =   2
      Top             =   3765
      Width           =   4770
   End
   Begin VB.PictureBox Picture2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   3600
      Left            =   9810
      ScaleHeight     =   484.068
      ScaleMode       =   0  'User
      ScaleWidth      =   644.051
      TabIndex        =   1
      Top             =   90
      Width           =   4800
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   7200
      Left            =   105
      ScaleHeight     =   480
      ScaleMode       =   0  'User
      ScaleWidth      =   640
      TabIndex        =   0
      Top             =   75
      Width           =   9600
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Video_Handle As Long



Private Sub Command1_Click()
      Video_Handle = CreateCaptureWindow(Picture1.hwnd)
End Sub

Private Sub Command2_Click()

      capDlgVideoSource Video_Handle

End Sub

Private Sub Command3_Click()
      Disconnect Video_Handle
End Sub

Private Sub Command4_Click()

      Dim pic As StdPicture
      Dim path As String
     
      Set pic = CapturePicture(Video_Handle)
      Picture2.Picture = pic
     
      path = App.path
      If Right(path, 1) <> "\" Then
            path = path & "\"
      End If
      
      If pic = 0 Then Exit Sub

      SavePicture pic, path & "pic.bmp"
      
      MsgBox "Í¼Ïñ´æÖÁ:" & path & "pic.bmp", vbInformation
     
End Sub

Private Sub Command5_Click()
      
      capDlgVideoFormat Video_Handle
      Picture1.Cls
      
      
End Sub

Private Sub Command6_Click()

      capDlgVideoCompression Video_Handle
      
End Sub



Private Sub Form_Unload(Cancel As Integer)
      Disconnect Video_Handle
End Sub
