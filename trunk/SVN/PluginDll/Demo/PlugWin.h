#pragma once


// CPlugWin �Ի���

class CPlugWin : public CDialog
{
	DECLARE_DYNAMIC(CPlugWin)
	
public:
	CPlugWin(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CPlugWin();
	
	BOOL Create(CWnd*   pParentWnd);


// �Ի�������
	enum { IDD = IDD_DIALOG1 };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedOk();
	afx_msg void OnBnClickedButton1();
};
