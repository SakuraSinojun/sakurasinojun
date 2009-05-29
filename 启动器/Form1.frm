VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Form1 
   BackColor       =   &H00000000&
   Caption         =   "Æô¶¯Æ÷"
   ClientHeight    =   975
   ClientLeft      =   60
   ClientTop       =   420
   ClientWidth     =   2730
   LinkTopic       =   "Form1"
   ScaleHeight     =   975
   ScaleWidth      =   2730
   StartUpPosition =   3  '´°¿ÚÈ±Ê¡
   Begin VB.CommandButton Command2 
      Caption         =   "CommChart"
      Height          =   495
      Left            =   600
      TabIndex        =   1
      Top             =   480
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H8000000D&
      Caption         =   "Ä£Äâ·¢ËÍ"
      Height          =   495
      Left            =   600
      TabIndex        =   0
      Top             =   0
      Width           =   1335
   End
   Begin MSComDlg.CommonDialog FileOpen 
      Left            =   720
      Top             =   480
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      Filter          =   "*.exe"
   End
   Begin VB.Label Label2 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Î¢ÈíÑÅºÚ"
         Size            =   14.25
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Left            =   0
      TabIndex        =   3
      Top             =   480
      Width           =   2775
   End
   Begin VB.Label Label1 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Î¢ÈíÑÅºÚ"
         Size            =   14.25
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   2775
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim FileSend As String
Dim FileChart As String

Private Sub Command1_Click()
If Label1.BackColor = vbRed Then
    FileOpen.ShowOpen
    FileSend = FileOpen.FileName
Else
    Shell FileSend, vbNormalFocus
End If
If Dir(FileSend) = "" Then
    Label1.BackColor = vbRed
Else
    Label1.BackColor = vbGreen
End If
End Sub

Private Sub Command2_Click()
If Label2.BackColor = vbRed Then
    FileOpen.ShowOpen
    FileChart = FileOpen.FileName
Else
    Shell FileChart, vbNormalFocus
End If
If Dir(FileChart) = "" Then
    Label2.BackColor = vbRed
Else
    Label2.BackColor = vbGreen
End If
End Sub

Private Sub Form_Load()

FileSend = "..\ÖÕ¶Ë1\Ä£Äâ·¢ËÍ.exe"
FileChart = "..\ÖÕ¶Ë2\CommChart.exe"

If Dir(FileSend) = "" Then
    Label1.BackColor = vbRed
Else
    Label1.BackColor = vbGreen
End If
If Dir(FileChart) = "" Then
    Label2.BackColor = vbRed
Else
    Label2.BackColor = vbGreen
End If
End Sub
