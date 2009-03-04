#include "StdAfx.h"
#include "NumEdit.h"

CNumEdit::CNumEdit(void)
{
}

CNumEdit::~CNumEdit(void)
{
}
BEGIN_MESSAGE_MAP(CNumEdit, CEdit)
	ON_WM_KEYDOWN()
	ON_WM_CHAR()
END_MESSAGE_MAP()

void CNumEdit::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags)
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值
	

	/*

	
	if((nChar>=48 && nChar<=57) || (nChar >=96 && nChar <=105) || nChar==8 || nChar==37 ||nChar==39)
	{
	}else{
		return;
	}
*/
	
	CEdit::OnKeyDown(nChar, nRepCnt, nFlags);
	
}

void CNumEdit::OnChar(UINT nChar, UINT nRepCnt, UINT nFlags)
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值
	// TODO: 在此添加消息处理程序代码和/或调用默认值
	


	if((nChar>=48 && nChar<=57) || nChar==8)
	{
	}else{
		return;
	}

	CEdit::OnChar(nChar, nRepCnt, nFlags);
}
