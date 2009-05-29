// SetupDlg.cpp : implementation file
//

#include "stdafx.h"
#include "CommChart.h"
#include "SetupDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSetupDlg dialog


CSetupDlg::CSetupDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSetupDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSetupDlg)
	m_EditWidthText = 0;
	m_EditHeightText = 0;
	m_EditSplitText = 0;
	//}}AFX_DATA_INIT
}


void CSetupDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSetupDlg)
	DDX_Text(pDX, IDC_EDIT2, m_EditWidthText);
	DDV_MinMaxInt(pDX, m_EditWidthText, 10, 120);
	DDX_Text(pDX, IDC_EDIT3, m_EditHeightText);
	DDV_MinMaxInt(pDX, m_EditHeightText, 255, 65535);
	DDX_Text(pDX, IDC_EDIT4, m_EditSplitText);
	DDV_MinMaxInt(pDX, m_EditSplitText, 1, 10);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSetupDlg, CDialog)
	//{{AFX_MSG_MAP(CSetupDlg)
	ON_BN_CLICKED(IDC_RADIO2, OnRadio2)
	ON_BN_CLICKED(IDC_RADIO3, OnRadio3)
	ON_EN_CHANGE(IDC_EDIT4, OnChangeEdit4)
	ON_EN_CHANGE(IDC_EDIT2, OnChangeEdit2)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSetupDlg message handlers

void CSetupDlg::OnOK() 
{
	// TODO: Add extra validation here

	this->UpdateData (TRUE);
	this->m_size.cx=this->m_EditWidthText;
	this->m_size.cy=this->m_EditHeightText;
	this->m_SplidWidth=this->m_EditSplitText ;
	CDialog::OnOK();
}

void CSetupDlg::OnCancel() 
{
	// TODO: Add extra cleanup here
	
	CDialog::OnCancel();
}


void CSetupDlg::SetCanvasSize(CSize size)
{

	this->m_size =size;

}

void CSetupDlg::OnRadio2() 
{
	// TODO: Add your control notification handler code here
	
	this->m_EditHeightText =255;
	this->UpdateData (FALSE);

}

void CSetupDlg::OnRadio3() 
{
	// TODO: Add your control notification handler code here
	this->m_EditHeightText =0xFFFF;
	this->UpdateData (FALSE);
}

BOOL CSetupDlg::OnInitDialog ()
{
	this->m_EditWidthText =this->m_size.cx;
	this->m_EditHeightText =this->m_size.cy;
	this->m_EditSplitText =this->m_SplidWidth ;

	this->UpdateData (FALSE);

	if(m_size.cy==255)
	{
		this->CheckRadioButton(IDC_RADIO2,IDC_RADIO3,IDC_RADIO2);
	}else{
		this->CheckRadioButton(IDC_RADIO2,IDC_RADIO3,IDC_RADIO3);
	}
	return TRUE;
}

CSize CSetupDlg::GetCanvasSize()
{
	
	return this->m_size ;
}

void CSetupDlg::OnChangeEdit4() 
{
	// TODO: If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialog::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.
	
	// TODO: Add your control notification handler code here
	this->UpdateData (true);
	this->m_SplidWidth=this->m_EditSplitText ;
}

void CSetupDlg::OnChangeEdit2() 
{
	// TODO: If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialog::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.
	
	// TODO: Add your control notification handler code here
	//this->UpdateData (true);

	

}
