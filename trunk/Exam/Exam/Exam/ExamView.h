// ExamView.h : CExamView 类的接口
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
protected: // 仅从序列化创建
	CExamView();
	DECLARE_DYNCREATE(CExamView)

// 属性
public:
	CExamDoc* GetDocument() const;

// 操作
public:

// 重写
public:
	virtual void OnDraw(CDC* pDC);  // 重写以绘制该视图
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	void CExamView::OnInitialUpdate ();

protected:

// 实现
public:
	virtual ~CExamView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// 生成的消息映射函数
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

#ifndef _DEBUG  // ExamView.cpp 中的调试版本
inline CExamDoc* CExamView::GetDocument() const
   { return reinterpret_cast<CExamDoc*>(m_pDocument); }
#endif

