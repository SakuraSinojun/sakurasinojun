// MapFileWatcherDlg.h : ͷ�ļ�
//

#pragma once



#include "MapViewer.h"


// CMapFileWatcherDlg �Ի���
class CMapFileWatcherDlg : public CDialog
{
// ����
public:
	CMapFileWatcherDlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
	enum { IDD = IDD_MAPFILEWATCHER_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��

	
	CMapViewer * m_MViewer[5];
	
	CButton *m_button;


// ʵ��
protected:
	HICON m_hIcon;

	// ���ɵ���Ϣӳ�亯��
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedOk();
	afx_msg void OnBnClickedCancel();
};
