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
END_MESSAGE_MAP()

void CNumEdit::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags)
{
	// TODO: �ڴ������Ϣ�����������/�����Ĭ��ֵ

	wchar_t * temp=new wchar_t[1024];

	::wsprintf(temp,_T("����:%d"),nChar);

	AfxMessageBox(temp);

	delete temp;

	CEdit::OnKeyDown(nChar, nRepCnt, nFlags);
}
