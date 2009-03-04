// ExamView.h : CExamView ��Ľӿ�
//

#pragma once


#include "NumEdit.h"
#include "Question.h"



#define IDC_BUTTONSTARTEXAM 201
#define IDC_BUTTONSETUPEXAM 202
#define IDC_EDITQCOUNT 203
#define IDC_EDITNAME 204
#define IDC_EDITID 205
#define IDC_CHECKA 206
#define IDC_CHECKB 207
#define IDC_CHECKC 208
#define IDC_CHECKD 209
#define IDC_BUTTONNEXT 210
#define IDC_BUTTONPREV 211
#define IDC_BUTTONCALC 212
#define IDC_SCROLLBAR 213
#define IDC_EDITQUEST 214


class CExamView : public CView
{
protected: // �������л�����
	CExamView();
	DECLARE_DYNCREATE(CExamView)

// ����
public:
	CExamDoc* GetDocument() const;

// ����
public:

// ��д
public:
	virtual void OnDraw(CDC* pDC);  // ��д�Ի��Ƹ���ͼ
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	void CExamView::OnInitialUpdate ();

protected:

// ʵ��
public:
	virtual ~CExamView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// ���ɵ���Ϣӳ�亯��
protected:
	DECLARE_MESSAGE_MAP()

public:
	CButton * m_ButtonStart;
	CButton * m_ButtonSetup;
	CButton * m_CheckA;
	CButton * m_CheckB;
	CButton * m_CheckC;
	CButton * m_CheckD;
	CButton * m_ButtonNext;
	CButton * m_ButtonPrev;
	CButton * m_ButtonCalc;

	CNumEdit * m_EditQCount;
	CEdit * m_EditName;
	CEdit * m_EditID;
	CEdit * m_EditQuest;
	
	CScrollBar * m_ScrollBar;

	int m_iQuestionCount;
	int m_iChoosenCount;

	wchar_t * m_szQCont;
	int m_txtPosY;
	int m_iQuestIndex;


	enum STATUS {STATUS_ZERO,STATUS_PREEXAM,STATUS_SETUP,STATUS_STARTINGEXAM,STATUS_EXAMING};
	STATUS m_ExamStatus;

	void StartExam();
	void SetupExam();
	void StartingExam();
	void NextQuestion();
	void PrevQuestion();
	int  GetQuestionList();
	void CalcResult();

	void OnCheck();

	HFONT ShowFont(HDC pDC, LPCWSTR fontstyle, int fontheight,int fontweight);

	static LRESULT wndSizeProc(HWND,UINT,WPARAM,LPARAM);
	
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnWindowPosChanged(WINDOWPOS* lpwndpos);
//	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
//	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
};

#ifndef _DEBUG  // ExamView.cpp �еĵ��԰汾
inline CExamDoc* CExamView::GetDocument() const
   { return reinterpret_cast<CExamDoc*>(m_pDocument); }
#endif

