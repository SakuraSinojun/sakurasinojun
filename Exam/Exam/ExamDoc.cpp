// ExamDoc.cpp : CExamDoc ���ʵ��
//

#include "stdafx.h"
#include "Exam.h"

#include "ExamDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CExamDoc

IMPLEMENT_DYNCREATE(CExamDoc, CDocument)

BEGIN_MESSAGE_MAP(CExamDoc, CDocument)
END_MESSAGE_MAP()


// CExamDoc ����/����

CExamDoc::CExamDoc()
{
	// TODO: �ڴ����һ���Թ������

}

CExamDoc::~CExamDoc()
{
}

BOOL CExamDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: �ڴ�������³�ʼ������
	// (SDI �ĵ������ø��ĵ�)

	return TRUE;
}




// CExamDoc ���л�

void CExamDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
		// TODO: �ڴ���Ӵ洢����
	}
	else
	{
		// TODO: �ڴ���Ӽ��ش���
	}
}


// CExamDoc ���

#ifdef _DEBUG
void CExamDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CExamDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG


// CExamDoc ����
