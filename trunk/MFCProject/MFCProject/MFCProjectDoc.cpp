// MFCProjectDoc.cpp : CMFCProjectDoc ���ʵ��
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


// CMFCProjectDoc ����/����

CMFCProjectDoc::CMFCProjectDoc()
{
	// TODO: �ڴ����һ���Թ������

}

CMFCProjectDoc::~CMFCProjectDoc()
{
}

BOOL CMFCProjectDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: �ڴ�������³�ʼ������
	// (SDI �ĵ������ø��ĵ�)

	return TRUE;
}




// CMFCProjectDoc ���л�

void CMFCProjectDoc::Serialize(CArchive& ar)
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


// CMFCProjectDoc ���

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


// CMFCProjectDoc ����
