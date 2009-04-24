// MFCProjectDoc.cpp : CMFCProjectDoc 类的实现
//

#include "stdafx.h"
#include "MFCProject.h"

#include "MFCProjectDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CMFCProjectDoc

IMPLEMENT_DYNCREATE(CMFCProjectDoc, CDocument)

BEGIN_MESSAGE_MAP(CMFCProjectDoc, CDocument)
END_MESSAGE_MAP()


// CMFCProjectDoc 构造/析构

CMFCProjectDoc::CMFCProjectDoc()
{
	// TODO: 在此添加一次性构造代码

}

CMFCProjectDoc::~CMFCProjectDoc()
{
}

BOOL CMFCProjectDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: 在此添加重新初始化代码
	// (SDI 文档将重用该文档)

	return TRUE;
}




// CMFCProjectDoc 序列化

void CMFCProjectDoc::Serialize(CArchive& ar)
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


// CMFCProjectDoc 诊断

#ifdef _DEBUG
void CMFCProjectDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CMFCProjectDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG


// CMFCProjectDoc 命令
