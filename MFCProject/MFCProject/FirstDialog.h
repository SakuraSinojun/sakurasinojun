#pragma once


// CFirstDialog 对话框

class CFirstDialog : public CDialog
{
	DECLARE_DYNAMIC(CFirstDialog)

public:
	CFirstDialog(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CFirstDialog();

// 对话框数据
	enum { IDD = IDD_FIRSTDIALOG };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	DECLARE_MESSAGE_MAP()
};
