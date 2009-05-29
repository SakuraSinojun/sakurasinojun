#if !defined(AFX_SETUPDLG_H__D2BC79FE_8578_4E44_8586_BE3B82847766__INCLUDED_)
#define AFX_SETUPDLG_H__D2BC79FE_8578_4E44_8586_BE3B82847766__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SetupDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSetupDlg dialog

class CSetupDlg : public CDialog
{
// Construction
public:
	CSize GetCanvasSize();
	void SetCanvasSize(CSize);
	CSetupDlg(CWnd* pParent = NULL);   // standard constructor

	CSize m_size;
	int m_SplidWidth;

// Dialog Data
	//{{AFX_DATA(CSetupDlg)
	enum { IDD = IDD_SETUP };
	int		m_EditWidthText;
	int		m_EditHeightText;
	int		m_EditSplitText;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSetupDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSetupDlg)
	virtual void OnOK();
	virtual void OnCancel();
	afx_msg void OnRadio2();
	afx_msg void OnRadio3();
	afx_msg BOOL OnInitDialog ();
	afx_msg void OnChangeEdit4();
	afx_msg void OnChangeEdit2();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SETUPDLG_H__D2BC79FE_8578_4E44_8586_BE3B82847766__INCLUDED_)
