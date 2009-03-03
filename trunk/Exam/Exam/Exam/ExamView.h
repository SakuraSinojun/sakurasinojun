// ExamView.h : CExamView ��Ľӿ�
//

#pragma once


#include "NumEdit.h"




#define IDC_BUTTONSTARTEXAM 201
#define IDC_BUTTONSETUPEXAM 202
#define IDC_EDITQCOUNT 203
#define IDC_EDITNAME 204
#define IDC_EDITID 205




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

	CNumEdit * m_EditQCount;
	CEdit * m_EditName;
	CEdit * m_EditID;


	int m_iQuestionCount;

	enum STATUS {STATUS_ZERO,STATUS_PREEXAM,STATUS_SETUP,STATUS_STARTINGEXAM,STATUS_EXAMING};
	STATUS m_ExamStatus;

	void StartExam();
	void SetupExam();

	
	static LRESULT wndSizeProc(HWND,UINT,WPARAM,LPARAM);
	
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnWindowPosChanged(WINDOWPOS* lpwndpos);
//	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
};

#ifndef _DEBUG  // ExamView.cpp �еĵ��԰汾
inline CExamDoc* CExamView::GetDocument() const
   { return reinterpret_cast<CExamDoc*>(m_pDocument); }
#endif

