#pragma once


// CFirstDialog �Ի���

class CFirstDialog : public CDialog
{
	DECLARE_DYNAMIC(CFirstDialog)

public:
	CFirstDialog(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CFirstDialog();

// �Ի�������
	enum { IDD = IDD_FIRSTDIALOG };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
};
