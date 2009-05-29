// CommChart.h : main header file for the COMMCHART application
//

#if !defined(AFX_COMMCHART_H__9050A6D4_3059_4B0C_ABB6_483AFC54B782__INCLUDED_)
#define AFX_COMMCHART_H__9050A6D4_3059_4B0C_ABB6_483AFC54B782__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CCommChartApp:
// See CommChart.cpp for the implementation of this class
//

#define IDC_CHART1 2001

class CCommChartApp : public CWinApp
{
public:
	CCommChartApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCommChartApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CCommChartApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_COMMCHART_H__9050A6D4_3059_4B0C_ABB6_483AFC54B782__INCLUDED_)
