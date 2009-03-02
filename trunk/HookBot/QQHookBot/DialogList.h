#pragma once
#include "afxwin.h"


// CDialogList 对话框

class CDialogList : public CDialog
{
	DECLARE_DYNAMIC(CDialogList)

public:
	CDialogList(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CDialogList();

// 对话框数据
	enum { IDD = IDD_DIALOG1 };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButton1();
	CListBox m_ListBox2;
};
