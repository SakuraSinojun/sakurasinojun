// DialogList.cpp : 实现文件
//

#include "stdafx.h"
#include "QQHookBot.h"
#include "DialogList.h"





// CDialogList 对话框

IMPLEMENT_DYNAMIC(CDialogList, CDialog)

CDialogList::CDialogList(CWnd* pParent /*=NULL*/)
	: CDialog(CDialogList::IDD, pParent)
{
	//m_ListBox2=(CListBox *)this->GetDlgItem(IDC_LIST2);

}

CDialogList::~CDialogList()
{
}

void CDialogList::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_LIST2, m_ListBox2);
}


BEGIN_MESSAGE_MAP(CDialogList, CDialog)
	ON_BN_CLICKED(IDC_BUTTON1, &CDialogList::OnBnClickedButton1)
END_MESSAGE_MAP()


// CDialogList 消息处理程序

void CDialogList::OnBnClickedButton1()
{
	// TODO: 在此添加控件通知处理程序代码


	//tmpWinBot.SetMainWin ((HWND)NULL);

	
	//::EnumWindows(EnumWindowsProc,(LPARAM)NULL);


}
