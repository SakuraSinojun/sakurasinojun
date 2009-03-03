#pragma once


// CPlugWin 对话框

class CPlugWin : public CDialog
{
	DECLARE_DYNAMIC(CPlugWin)
	
public:
	CPlugWin(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CPlugWin();
	
	BOOL Create(CWnd*   pParentWnd);


// 对话框数据
	enum { IDD = IDD_DIALOG1 };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedOk();
	afx_msg void OnBnClickedButton1();
};
