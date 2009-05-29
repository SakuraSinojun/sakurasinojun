// DlgReadData.cpp : implementation file
//

#include "stdafx.h"
#include "CommChart.h"
#include "DlgReadData.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDlgReadData dialog


CDlgReadData::CDlgReadData(CWnd* pParent /*=NULL*/)
	: CDialog(CDlgReadData::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDlgReadData)
	m_Edit1Text = 0;
	//}}AFX_DATA_INIT
}


void CDlgReadData::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDlgReadData)
	DDX_Text(pDX, IDC_EDIT1, m_Edit1Text);
	DDV_MinMaxInt(pDX, m_Edit1Text, 0, 1000);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CDlgReadData, CDialog)
	//{{AFX_MSG_MAP(CDlgReadData)
	ON_EN_CHANGE(IDC_EDIT1, OnChangeEdit1)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDlgReadData message handlers

BOOL CDlgReadData::OnInitDialog ()
{
	this->m_Edit1Text =0;
	this->UpdateData (FALSE);
	return TRUE;
}
void CDlgReadData::OnOK() 
{
	// TODO: Add extra validation here
	this->UpdateData (TRUE);
	this->result =this->m_Edit1Text ;
	CDialog::OnOK();
}

void CDlgReadData::OnChangeEdit1() 
{
	// TODO: If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialog::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.
	
	// TODO: Add your control notification handler code here
	
	this->UpdateData (TRUE);
	this->result =this->m_Edit1Text ;

}
