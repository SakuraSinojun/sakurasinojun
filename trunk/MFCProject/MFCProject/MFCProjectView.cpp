// MFCProjectView.cpp : CMFCProjectView 类的实现
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
	// 标准打印命令
	ON_COMMAND(ID_FILE_PRINT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, &CView::OnFilePrintPreview)
	ON_COMMAND(ID_SHOWMODALDIALOG, &CMFCProjectView::OnShowmodaldialog)
	ON_COMMAND(ID_SHOWNONMODALDIALOG, &CMFCProjectView::OnShownonmodaldialog)
END_MESSAGE_MAP()

// CMFCProjectView 构造/析构

CMFCProjectView::CMFCProjectView()
{
	// TODO: 在此处添加构造代码

}

CMFCProjectView::~CMFCProjectView()
{
}

BOOL CMFCProjectView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: 在此处通过修改
	//  CREATESTRUCT cs 来修改窗口类或样式

	return CView::PreCreateWindow(cs);
}

// CMFCProjectView 绘制

void CMFCProjectView::OnDraw(CDC* /*pDC*/)
{
	CMFCProjectDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	// TODO: 在此处为本机数据添加绘制代码
}


// CMFCProjectView 打印

BOOL CMFCProjectView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// 默认准备
	return DoPreparePrinting(pInfo);
}

void CMFCProjectView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: 添加额外的打印前进行的初始化过程
}

void CMFCProjectView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: 添加打印后进行的清理过程
}


// CMFCProjectView 诊断

#ifdef _DEBUG
void CMFCProjectView::AssertValid() const
{
	CView::AssertValid();
}

void CMFCProjectView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CMFCProjectDoc* CMFCProjectView::GetDocument() const // 非调试版本是内联的
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CMFCProjectDoc)));
	return (CMFCProjectDoc*)m_pDocument;
}
#endif //_DEBUG


// CMFCProjectView 消息处理程序

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
	// TODO: 在此添加命令处理程序代码
}
