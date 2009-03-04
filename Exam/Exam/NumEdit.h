#pragma once
#include "afxwin.h"

class CNumEdit :
	public CEdit
{
public:
	CNumEdit(void);
	~CNumEdit(void);
	DECLARE_MESSAGE_MAP()
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
};
