// MFCProjectDoc.h : CMFCProjectDoc ��Ľӿ�
//


#pragma once


class CMFCProjectDoc : public CDocument
{
protected: // �������л�����
	CMFCProjectDoc();
	DECLARE_DYNCREATE(CMFCProjectDoc)

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
	virtual ~CMFCProjectDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// ���ɵ���Ϣӳ�亯��
protected:
	DECLARE_MESSAGE_MAP()
};


