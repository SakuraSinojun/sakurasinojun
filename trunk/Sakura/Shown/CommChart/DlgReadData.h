#if !defined(AFX_DLGREADDATA_H__069D8D3D_FC79_453F_9EBE_68DF301F8657__INCLUDED_)
#define AFX_DLGREADDATA_H__069D8D3D_FC79_453F_9EBE_68DF301F8657__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DlgReadData.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDlgReadData dialog

class CDlgReadData : public CDialog
{
// Construction
public:
	CDlgReadData(CWnd* pParent = NULL);   // standard constructor

	int result;


private:

	BOOL OnInitDialog ();


// Dialog Data
	//{{AFX_DATA(CDlgReadData)
	enum { IDD = IDD_DLGREADDATA };
	int		m_Edit1Text;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDlgReadData)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CDlgReadData)
	virtual void OnOK();
	afx_msg void OnChangeEdit1();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DLGREADDATA_H__069D8D3D_FC79_453F_9EBE_68DF301F8657__INCLUDED_)
