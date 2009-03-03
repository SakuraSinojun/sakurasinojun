// QQHookBotDlg.h : ͷ�ļ�
//

#pragma once
#include "afxwin.h"
#include "afxcmn.h"
#include "WinBot.h"
#include "PlugIn.h"

#define MAXWINLIST 128
#define MAXWINLISTI 129



// CQQHookBotDlg �Ի���
class CQQHookBotDlg : public CDialog
{
// ����
public:
	CQQHookBotDlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
	enum { IDD = IDD_QQHOOKBOT_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��


// ʵ��
protected:
	HICON m_hIcon;

	// ���ɵ���Ϣӳ�亯��
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	CListBox m_ListBox1;
	afx_msg void OnBnClickedButton1();
	afx_msg void OnLbnSelchangeList1();

public:
	CWinBot WinList[MAXWINLISTI];
	int FindFirstEmptyWinList();
	int IsInWinList(HWND hWnd);

	afx_msg void OnBnClickedButton2();
	afx_msg void OnBnClickedOk();
	afx_msg void OnBnClickedButton3();
//	afx_msg void OnEnVscrollRichedit21();
	afx_msg void OnEnChangeRichedit21();
	CSliderCtrl m_Slider;
	afx_msg void OnTimer(UINT_PTR nIDEvent);
	CButton btnStart;
	CButton btnStop;
	afx_msg void OnBnClickedButton5();
	void FindPlugin();
	CListBox m_ListBox2;
	afx_msg void OnLbnSelchangeList2();


	static CPlugIn * m_cPlug;
	CString m_PlugPath;

};
