// ExamView.cpp : CExamView ���ʵ��
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

// CExamView ����/����

CExamView::CExamView()
:m_ExamStatus(STATUS_ZERO)
{
	// TODO: �ڴ˴���ӹ������

}

CExamView::~CExamView()
{
}

BOOL CExamView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: �ڴ˴�ͨ���޸�
	//  CREATESTRUCT cs ���޸Ĵ��������ʽ

	return CView::PreCreateWindow(cs);
}

// CExamView ����

void CExamView::OnDraw(CDC* pDC)
{
	CExamDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;
	// TODO: �ڴ˴�Ϊ����������ӻ��ƴ���
	
	if(this->m_ExamStatus ==STATUS_EXAMING)
	{
		pDC->TextOutW (100,100,_T("TEST"),4);
	}
		
}


// CExamView ���

#ifdef _DEBUG
void CExamView::AssertValid() const
{
	CView::AssertValid();
}

void CExamView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CExamDoc* CExamView::GetDocument() const // �ǵ��԰汾��������
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

	m_ButtonStart->Create(_T("��ʼ����"),WS_VISIBLE | BS_PUSHBUTTON,rcStart,this,IDC_BUTTONSTARTEXAM);
	m_ButtonSetup->Create(_T("��������"),WS_VISIBLE | BS_PUSHBUTTON,rcSetup,this,IDC_BUTTONSETUPEXAM);
	


}

// CExamView ��Ϣ�������

void CExamView::OnSize(UINT nType, int cx, int cy)
{
	CView::OnSize(nType, cx, cy);

	// TODO: �ڴ˴������Ϣ����������


}

void CExamView::OnWindowPosChanged(WINDOWPOS* lpwndpos)
{
	CView::OnWindowPosChanged(lpwndpos);

	// TODO: �ڴ˴������Ϣ����������
	
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
//	// TODO: �ڴ������Ϣ�����������/�����Ĭ��ֵ
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
