// PlugWin.cpp : 实现文件
//

#include "stdafx.h"
#include "Demo.h"
#include "PlugWin.h"


// CPlugWin 对话框

IMPLEMENT_DYNAMIC(CPlugWin, CDialog)

CPlugWin::CPlugWin(CWnd* pParent /*=NULL*/)
	: CDialog(CPlugWin::IDD, pParent)
{

}

CPlugWin::~CPlugWin()
{
}

BOOL CPlugWin::Create(CWnd *pParentWnd)
{
	m_lpszTemplateName=NULL;   
    
	HMODULE hModule=::GetModuleHandle (_T("Demo.dll")); 
	
	HRSRC hResource  =::FindResource(hModule,   MAKEINTRESOURCE(IDD),   RT_DIALOG); 

	m_hDialogTemplate = LoadResource(hModule,   hResource);   
    
	return   CDialog::Create(IDD, pParentWnd);   

}


void CPlugWin::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CPlugWin, CDialog)
	ON_BN_CLICKED(IDOK, &CPlugWin::OnBnClickedOk)
	ON_BN_CLICKED(IDC_BUTTON1, &CPlugWin::OnBnClickedButton1)
END_MESSAGE_MAP()


// CPlugWin 消息处理程序

void CPlugWin::OnBnClickedOk()
{
	// TODO: 在此添加控件通知处理程序代码
	AfxMessageBox(_T("OK"));
	OnOK();
}

void CPlugWin::OnBnClickedButton1()
{
		AfxMessageBox(_T("OK"));
	// TODO: 在此添加控件通知处理程序代码
}
