// CommChartDlg.h : header file
//
//{{AFX_INCLUDES()
#include "mscomm.h"
//}}AFX_INCLUDES

#if !defined(AFX_COMMCHARTDLG_H__8E53EE7E_EE91_47E5_B0D2_57593C5BDB04__INCLUDED_)
#define AFX_COMMCHARTDLG_H__8E53EE7E_EE91_47E5_B0D2_57593C5BDB04__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CCommChartDlg dialog



#include "Chart.h"
#include "SetupDlg.h"

#include "channel.h"


class CCommChartDlg : public CDialog
{
// Construction
public:
	void ListCommPort();
	CCommChartDlg(CWnd* pParent = NULL);	// standard constructor


	CChannel * m_channel;

	
	LRESULT	OnVVMessage(WPARAM wParam,LPARAM lParam);


// Dialog Data
	//{{AFX_DATA(CCommChartDlg)
	enum { IDD = IDD_COMMCHART_DIALOG };
	CButton	m_Button2;
	CButton	m_button1;
	CComboBox	m_Combo4;
	CComboBox	m_Combo5;
	CComboBox	m_Combo3;
	CComboBox	m_Combo2;
	CComboBox	m_Combo1;
	CMSComm	m_Comm1;
	CChart * m_chart;
	_ConnectionPtr	m_pConnection;
	_RecordsetPtr	m_pRecordset;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCommChartDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CCommChartDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnOnCommMscomm1();
	afx_msg void OnButton2();
	afx_msg void OnButton3();
	afx_msg void OnWindowPosChanged(WINDOWPOS FAR* lpwndpos);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	virtual void OnOK();
	afx_msg void OnGetMinMaxInfo(MINMAXINFO FAR* lpMMI);
	virtual void OnCancel();
	afx_msg void OnTimer(UINT nIDEvent);
	
	
	DECLARE_EVENTSINK_MAP()
	
		
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_COMMCHARTDLG_H__8E53EE7E_EE91_47E5_B0D2_57593C5BDB04__INCLUDED_)
