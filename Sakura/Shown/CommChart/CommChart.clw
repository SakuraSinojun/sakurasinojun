; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CCommChartDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "CommChart.h"

ClassCount=6
Class1=CCommChartApp
Class2=CCommChartDlg
Class3=CAboutDlg

ResourceCount=5
Resource1=IDD_ABOUTBOX
Resource2=IDR_MAINFRAME
Class4=CChart
Resource3=IDD_COMMCHART_DIALOG
Class5=CSetupDlg
Resource4=IDD_SETUP
Class6=CDlgReadData
Resource5=IDD_DLGREADDATA

[CLS:CCommChartApp]
Type=0
HeaderFile=CommChart.h
ImplementationFile=CommChart.cpp
Filter=N

[CLS:CCommChartDlg]
Type=0
HeaderFile=CommChartDlg.h
ImplementationFile=CommChartDlg.cpp
Filter=W
BaseClass=CDialog
VirtualFilter=dWC
LastObject=IDC_BUTTON3

[CLS:CAboutDlg]
Type=0
HeaderFile=CommChartDlg.h
ImplementationFile=CommChartDlg.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[DLG:IDD_COMMCHART_DIALOG]
Type=1
Class=CCommChartDlg
ControlCount=16
Control1=IDOK,button,1073807361
Control2=IDCANCEL,button,1073807360
Control3=IDC_COMBO1,combobox,1344340227
Control4=IDC_COMBO2,combobox,1344339971
Control5=IDC_COMBO3,combobox,1344340227
Control6=IDC_COMBO4,combobox,1344340227
Control7=IDC_COMBO5,combobox,1344340227
Control8=IDC_STATIC,static,1342308352
Control9=IDC_STATIC,static,1342308352
Control10=IDC_STATIC,static,1342308352
Control11=IDC_STATIC,static,1342308352
Control12=IDC_STATIC,static,1342308352
Control13=IDC_BUTTON2,button,1342242816
Control14=IDC_MSCOMM1,{648A5600-2C6E-101B-82B6-000000000014},1342242816
Control15=IDC_STATIC1,static,1342308352
Control16=IDC_BUTTON3,button,1476460544

[CLS:CChart]
Type=0
HeaderFile=Chart.h
ImplementationFile=Chart.cpp
BaseClass=CWnd
Filter=C
VirtualFilter=WC

[DLG:IDD_SETUP]
Type=1
Class=CSetupDlg
ControlCount=13
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,button,1342177287
Control4=IDC_STATIC,static,1342308352
Control5=IDC_STATIC,static,1342308352
Control6=IDC_EDIT2,edit,1342251009
Control7=IDC_EDIT3,edit,1342253057
Control8=IDC_STATIC,button,1342177287
Control9=IDC_RADIO2,button,1342177289
Control10=IDC_RADIO3,button,1476395017
Control11=IDC_STATIC,static,1342308352
Control12=IDC_STATIC,static,1342308352
Control13=IDC_EDIT4,edit,1342251009

[CLS:CSetupDlg]
Type=0
HeaderFile=SetupDlg.h
ImplementationFile=SetupDlg.cpp
BaseClass=CDialog
Filter=D
VirtualFilter=dWC
LastObject=CSetupDlg

[DLG:IDD_DLGREADDATA]
Type=1
Class=CDlgReadData
ControlCount=5
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,static,1342308352
Control4=IDC_EDIT1,edit,1350639616
Control5=IDC_STATIC,static,1342308352

[CLS:CDlgReadData]
Type=0
HeaderFile=DlgReadData.h
ImplementationFile=DlgReadData.cpp
BaseClass=CDialog
Filter=D
LastObject=IDC_EDIT1
VirtualFilter=dWC

