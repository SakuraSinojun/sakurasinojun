#pragma once
#include "afxwin.h"


// CDialogList �Ի���

class CDialogList : public CDialog
{
	DECLARE_DYNAMIC(CDialogList)

public:
	CDialogList(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CDialogList();

// �Ի�������
	enum { IDD = IDD_DIALOG1 };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButton1();
	CListBox m_ListBox2;
};
