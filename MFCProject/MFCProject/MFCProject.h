// MFCProject.h : MFCProject Ӧ�ó������ͷ�ļ�
//
#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"       // ������


// CMFCProjectApp:
// �йش����ʵ�֣������ MFCProject.cpp
//

class CMFCProjectApp : public CWinApp
{
public:
	CMFCProjectApp();


// ��д
public:
	virtual BOOL InitInstance();

// ʵ��
	afx_msg void OnAppAbout();
	DECLARE_MESSAGE_MAP()
};

extern CMFCProjectApp theApp;