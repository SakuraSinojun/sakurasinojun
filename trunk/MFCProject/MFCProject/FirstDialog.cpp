// FirstDialog.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "MFCProject.h"
#include "FirstDialog.h"


// CFirstDialog �Ի���

IMPLEMENT_DYNAMIC(CFirstDialog, CDialog)

CFirstDialog::CFirstDialog(CWnd* pParent /*=NULL*/)
	: CDialog(CFirstDialog::IDD, pParent)
{

}

CFirstDialog::~CFirstDialog()
{
}

void CFirstDialog::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CFirstDialog, CDialog)
END_MESSAGE_MAP()


// CFirstDialog ��Ϣ�������
