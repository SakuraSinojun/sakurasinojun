// MFCProjectView.h : CMFCProjectView 类的接口
//


#pragma once


class CMFCProjectView : public CView
{
protected: // 仅从序列化创建
	CMFCProjectView();
	DECLARE_DYNCREATE(CMFCProjectView)

// 属性
public:
	CMFCProjectDoc* GetDocument() const;

// 操作
public:

// 重写
public:
	virtual void OnDraw(CDC* pDC);  // 重写以绘制该视图
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);

// 实现
public:
	virtual ~CMFCProjectView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// 生成的消息映射函数
protected:
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnShowmodaldialog();
	afx_msg void OnShownonmodaldialog();
};

#ifndef _DEBUG  // MFCProjectView.cpp 中的调试版本
inline CMFCProjectDoc* CMFCProjectView::GetDocument() const
   { return reinterpret_cast<CMFCProjectDoc*>(m_pDocument); }
#endif

