// FirstDialog.cpp : 实现文件
//

#include "stdafx.h"
#include "MFCProject.h"
#include "FirstDialog.h"


// CFirstDialog 对话框

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


// CFirstDialog 消息处理程序
