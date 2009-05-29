VERSION 5.00
Object = "{EDE925E9-F18B-4316-8AB3-F5D6A6241846}#69.0#0"; "Channel.ocx"
Begin VB.Form frmTest 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   Caption         =   "Form1"
   ClientHeight    =   4620
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   11070
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4620
   ScaleWidth      =   11070
   StartUpPosition =   3  '窗口缺省
   Begin 工程2.Channel Channel1 
      Left            =   6435
      Top             =   1230
      _ExtentX        =   2275
      _ExtentY        =   1138
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "Send"
      Default         =   -1  'True
      Height          =   420
      Left            =   9900
      TabIndex        =   2
      Top             =   4080
      Width           =   1125
   End
   Begin VB.TextBox Text2 
      Appearance      =   0  'Flat
      Height          =   435
      Left            =   75
      TabIndex        =   1
      Text            =   "this is a test"
      Top             =   4065
      Width           =   9765
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      Height          =   3945
      Left            =   75
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   60
      Width           =   10980
   End
End
Attribute VB_Name = "frmTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Channel1_DataArrivalS(data As String)

       T (data)
      
End Sub

Private Sub Command1_Click()

Channel1.SendDataToChannelS Text2.Text

Text2.Text = ""

End Sub

Private Sub T(msg As String)

      Text1.Text = Text1.Text & msg & vbCrLf
      
      Text1.SelStart = Len(Text1.Text)
      Text1.SelLength = 1
      

End Sub


