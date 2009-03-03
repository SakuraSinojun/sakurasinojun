// ExamView.cpp : CExamView 类的实现
//

#include "stdafx.h"
#include "Exam.h"

#include "ExamDoc.h"
#include "ExamView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif



// CExamView

IMPLEMENT_DYNCREATE(CExamView, CView)

BEGIN_MESSAGE_MAP(CExamView, CView)
	ON_WM_SIZE()
	ON_WM_WINDOWPOSCHANGED()
	ON_COMMAND(IDC_BUTTONSTARTEXAM,StartExam)
	ON_COMMAND(IDC_BUTTONSETUPEXAM,SetupExam)
//	ON_WM_LBUTTONUP()
END_MESSAGE_MAP()

// CExamView 构造/析构

CExamView::CExamView()
:m_ExamStatus(STATUS_ZERO)
{
	// TODO: 在此处添加构造代码

}

CExamView::~CExamView()
{
}

BOOL CExamView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: 在此处通过修改
	//  CREATESTRUCT cs 来修改窗口类或样式

	return CView::PreCreateWindow(cs);
}

// CExamView 绘制

void CExamView::OnDraw(CDC* pDC)
{
	CExamDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;
	// TODO: 在此处为本机数据添加绘制代码
	
	if(this->m_ExamStatus ==STATUS_EXAMING)
	{
		pDC->TextOutW (100,100,_T("TEST"),4);
	}
		
}


// CExamView 诊断

#ifdef _DEBUG
void CExamView::AssertValid() const
{
	CView::AssertValid();
}

void CExamView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CExamDoc* CExamView::GetDocument() const // 非调试版本是内联的
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CExamDoc)));
	return (CExamDoc*)m_pDocument;
}
#endif //_DEBUG


void CExamView::OnInitialUpdate ()
{
	CView::OnInitialUpdate ();

	m_ExamStatus=STATUS_PREEXAM;



	CRect rcClient;
	CRect rcSetup;
	CRect rcStart;


	this->GetClientRect (rcClient);

	rcSetup.left =rcClient.Width() /2-250;
	rcSetup.right =rcSetup.left +200;
	rcSetup.top =rcClient.Height() /2-50;
	rcSetup.bottom =rcSetup.top +100;

	rcStart.left =rcClient.Width() /2+50;
	rcStart.right =rcStart.left +200;
	rcStart.top =rcClient.Height() /2-50;
	rcStart.bottom =rcStart.top +100;

	m_ButtonStart=new CButton;
	m_ButtonSetup=new CButton;

	m_ButtonStart->Create(_T("开始考试"),WS_VISIBLE | BS_PUSHBUTTON,rcStart,this,IDC_BUTTONSTARTEXAM);
	m_ButtonSetup->Create(_T("试题设置"),WS_VISIBLE | BS_PUSHBUTTON,rcSetup,this,IDC_BUTTONSETUPEXAM);
	


}

// CExamView 消息处理程序

void CExamView::OnSize(UINT nType, int cx, int cy)
{
	CView::OnSize(nType, cx, cy);

	// TODO: 在此处添加消息处理程序代码


}

void CExamView::OnWindowPosChanged(WINDOWPOS* lpwndpos)
{
	CView::OnWindowPosChanged(lpwndpos);

	// TODO: 在此处添加消息处理程序代码
	
	CRect rcClient;
	CRect rcSetup;
	CRect rcStart;

	this->GetClientRect (rcClient);


	rcSetup.left =rcClient.Width() /2-250;
	rcSetup.right =rcSetup.left +200;
	rcSetup.top =rcClient.Height() /2-50;
	rcSetup.bottom =rcSetup.top +100;

	rcStart.left =rcClient.Width() /2+50;
	rcStart.right =rcStart.left +200;
	rcStart.top =rcClient.Height() /2-50;
	rcStart.bottom =rcStart.top +100;


	if(m_ExamStatus==STATUS_PREEXAM)
	{
		m_ButtonStart->MoveWindow (rcStart.left ,rcStart.top ,rcStart.Width (),rcStart.Height (),true);
		m_ButtonSetup->MoveWindow (rcSetup.left ,rcSetup.top ,rcSetup.Width (),rcSetup.Height (),true);
	}
	
}

//void CExamView::OnLButtonUp(UINT nFlags, CPoint point)
//{
//	// TODO: 在此添加消息处理程序代码和/或调用默认值
//
//	CView::OnLButtonUp(nFlags, point);
//}



void CExamView::StartExam ()
{
	AfxMessageBox(_T("Test"));
}
void CExamView::SetupExam ()
{
	AfxMessageBox(_T("SETUP"));
}
