// ExamView.h : CExamView 类的接口
//


#pragma once


#define IDC_BUTTONSTARTEXAM 201
#define IDC_BUTTONSETUPEXAM 202


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

	enum STATUS {STATUS_ZERO,STATUS_PREEXAM,STATUS_STARTINGEXAM,STATUS_EXAMING};
	STATUS m_ExamStatus;

	void StartExam();
	void SetupExam();

	
	static LRESULT wndSizeProc(HWND,UINT,WPARAM,LPARAM);
	
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnWindowPosChanged(WINDOWPOS* lpwndpos);
//	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
};

#ifndef _DEBUG  // ExamView.cpp 中的调试版本
inline CExamDoc* CExamView::GetDocument() const
   { return reinterpret_cast<CExamDoc*>(m_pDocument); }
#endif

