// ExamDoc.h : CExamDoc ��Ľӿ�
//


#pragma once


class CExamDoc : public CDocument
{
protected: // �������л�����
	CExamDoc();
	DECLARE_DYNCREATE(CExamDoc)

// ����
public:

// ����
public:

// ��д
public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);

// ʵ��
public:
	virtual ~CExamDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// ���ɵ���Ϣӳ�亯��
protected:
	DECLARE_MESSAGE_MAP()
};


