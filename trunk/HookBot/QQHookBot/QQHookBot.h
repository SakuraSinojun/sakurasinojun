// QQHookBot.h : PROJECT_NAME Ӧ�ó������ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������


// CQQHookBotApp:
// �йش����ʵ�֣������ QQHookBot.cpp
//

class CQQHookBotApp : public CWinApp
{
public:
	CQQHookBotApp();

// ��д
	public:
	virtual BOOL InitInstance();

// ʵ��

	DECLARE_MESSAGE_MAP()
	afx_msg void OnBnClickedButton1();
};

extern CQQHookBotApp theApp;


 