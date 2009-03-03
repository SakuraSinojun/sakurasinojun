// ExamDoc.cpp : CExamDoc 类的实现
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


// CExamDoc 构造/析构

CExamDoc::CExamDoc()
{
	// TODO: 在此添加一次性构造代码

}

CExamDoc::~CExamDoc()
{
}

BOOL CExamDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: 在此添加重新初始化代码
	// (SDI 文档将重用该文档)

	return TRUE;
}




// CExamDoc 序列化

void CExamDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
		// TODO: 在此添加存储代码
	}
	else
	{
		// TODO: 在此添加加载代码
	}
}


// CExamDoc 诊断

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


// CExamDoc 命令
