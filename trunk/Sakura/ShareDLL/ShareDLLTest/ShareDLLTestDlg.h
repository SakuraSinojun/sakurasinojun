// ShareDLLTestDlg.h : header file
//

#if !defined(AFX_SHAREDLLTESTDLG_H__00CB0E0A_C6F5_487B_B21E_1AE2C433B1B0__INCLUDED_)
#define AFX_SHAREDLLTESTDLG_H__00CB0E0A_C6F5_487B_B21E_1AE2C433B1B0__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CShareDLLTestDlg dialog

class CShareDLLTestDlg : public CDialog
{
// Construction
public:
	CShareDLLTestDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CShareDLLTestDlg)
	enum { IDD = IDD_SHAREDLLTEST_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CShareDLLTestDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CShareDLLTestDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnButton2();
	afx_msg void OnButton1();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

public:
	CString m_Edit1;
	CString m_Edit2;

};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SHAREDLLTESTDLG_H__00CB0E0A_C6F5_487B_B21E_1AE2C433B1B0__INCLUDED_)
