// MFCProjectView.cpp : CMFCProjectView ���ʵ��
//

#include "stdafx.h"
#include "MFCProject.h"
#include "FirstDialog.h"

#include "MFCProjectDoc.h"
#include "MFCProjectView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CMFCProjectView

IMPLEMENT_DYNCREATE(CMFCProjectView, CView)

BEGIN_MESSAGE_MAP(CMFCProjectView, CView)
	// ��׼��ӡ����
	ON_COMMAND(ID_FILE_PRINT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, &CView::OnFilePrintPreview)
	ON_COMMAND(ID_SHOWMODALDIALOG, &CMFCProjectView::OnShowmodaldialog)
	ON_COMMAND(ID_SHOWNONMODALDIALOG, &CMFCProjectView::OnShownonmodaldialog)
END_MESSAGE_MAP()

// CMFCProjectView ����/����

CMFCProjectView::CMFCProjectView()
{
	// TODO: �ڴ˴���ӹ������

}

CMFCProjectView::~CMFCProjectView()
{
}

BOOL CMFCProjectView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: �ڴ˴�ͨ���޸�
	//  CREATESTRUCT cs ���޸Ĵ��������ʽ

	return CView::PreCreateWindow(cs);
}

// CMFCProjectView ����

void CMFCProjectView::OnDraw(CDC* /*pDC*/)
{
	CMFCProjectDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	// TODO: �ڴ˴�Ϊ����������ӻ��ƴ���
}


// CMFCProjectView ��ӡ

BOOL CMFCProjectView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// Ĭ��׼��
	return DoPreparePrinting(pInfo);
}

void CMFCProjectView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: ��Ӷ���Ĵ�ӡǰ���еĳ�ʼ������
}

void CMFCProjectView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: ��Ӵ�ӡ����е��������
}


// CMFCProjectView ���

#ifdef _DEBUG
void CMFCProjectView::AssertValid() const
{
	CView::AssertValid();
}

void CMFCProjectView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CMFCProjectDoc* CMFCProjectView::GetDocument() const // �ǵ��԰汾��������
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CMFCProjectDoc)));
	return (CMFCProjectDoc*)m_pDocument;
}
#endif //_DEBUG


// CMFCProjectView ��Ϣ�������

void CMFCProjectView::OnShowmodaldialog()
{
	// TODO: 
	CFirstDialog dlg;
	int nResult=dlg.DoModal();
	if(IDOK==nResult)
	{
		AfxMessageBox(L"OK");
	}
	else 
	{
		AfxMessageBox(L"Cancel");
	}

}

void CMFCProjectView::OnShownonmodaldialog()
{
	// TODO: �ڴ���������������
}
