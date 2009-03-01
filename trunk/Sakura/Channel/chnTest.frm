VERSION 5.00
Object = "{EDE925E9-F18B-4316-8AB3-F5D6A6241846}#35.0#0"; "Channel.ocx"
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   6270
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   8940
   LinkTopic       =   "Form1"
   ScaleHeight     =   6270
   ScaleWidth      =   8940
   StartUpPosition =   3  '窗口缺省
   Begin VB.TextBox Text2 
      Height          =   810
      Left            =   1605
      TabIndex        =   3
      Text            =   "Text2"
      Top             =   2655
      Width           =   6630
   End
   Begin 工程2.Channel Channel1 
      Left            =   990
      Top             =   1005
      _ExtentX        =   1852
      _ExtentY        =   1667
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Command2"
      Height          =   1680
      Left            =   1320
      TabIndex        =   2
      Top             =   3360
      Width           =   7005
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   480
      Left            =   2775
      TabIndex        =   1
      Top             =   1770
      Width           =   5145
   End
   Begin VB.TextBox Text1 
      Height          =   885
      Left            =   2745
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   660
      Width           =   4365
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'Private Declare Function WriteSharedComm Lib "ShareDLL.dll" (ByVal CommPort As Integer, ByVal data As String, ByVal length As Integer) As Integer
'Private Declare Function ReadSharedComm Lib "ShareDLL.dll" (ByVal CommPort As Integer, ByVal data As String) As Integer

'Private Declare Function WriteChannel Lib "Share.dll" (ByVal Channel As Integer, ByVal data As String, ByVal length As Integer) As Integer
'Private Declare Function ReadChannel Lib "Share.dll" (ByVal Channel As Integer, ByVal data As String) As Integer


Private Sub Channel1_DataArrival(data As String)


Text2.Text = data

End Sub

Private Sub Command1_Click()


Channel1.SendDataToChannel Text1.Text

End Sub

Private Sub Command2_Click()

Dim msg As String


End Sub


