// DialogList.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "QQHookBot.h"
#include "DialogList.h"





// CDialogList �Ի���

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


// CDialogList ��Ϣ�������

void CDialogList::OnBnClickedButton1()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������


	//tmpWinBot.SetMainWin ((HWND)NULL);

	
	//::EnumWindows(EnumWindowsProc,(LPARAM)NULL);


}
