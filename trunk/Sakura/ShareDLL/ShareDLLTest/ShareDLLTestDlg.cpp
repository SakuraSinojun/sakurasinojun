// ShareDLLTestDlg.cpp : implementation file
//

#include "stdafx.h"
#include "ShareDLLTest.h"
#include "ShareDLLTestDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CShareDLLTestDlg dialog

CShareDLLTestDlg::CShareDLLTestDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CShareDLLTestDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CShareDLLTestDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CShareDLLTestDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CShareDLLTestDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP

	DDX_Text(pDX,IDC_EDIT1,m_Edit1);
	DDX_Text(pDX,IDC_EDIT2,m_Edit2);

}

BEGIN_MESSAGE_MAP(CShareDLLTestDlg, CDialog)
	//{{AFX_MSG_MAP(CShareDLLTestDlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON2, OnButton2)
	ON_BN_CLICKED(IDC_BUTTON1, OnButton1)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CShareDLLTestDlg message handlers

BOOL CShareDLLTestDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CShareDLLTestDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CShareDLLTestDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CShareDLLTestDlg::OnButton2() 
{
	UpdateData(true);
	WriteSharedComm(1,m_Edit2.GetBuffer(m_Edit2.GetLength()+1),m_Edit2.GetLength());
	
}

void CShareDLLTestDlg::OnButton1() 
{
	char *msg=new char [1024];
	int i;

	memset(msg,0,1024);
	i=ReadSharedComm(1,msg);

	m_Edit1=msg;
	UpdateData(false);

}
