// MapFileWatcher.h : PROJECT_NAME Ӧ�ó������ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������


// CMapFileWatcherApp:
// �йش����ʵ�֣������ MapFileWatcher.cpp
//

class CMapFileWatcherApp : public CWinApp
{
public:
	CMapFileWatcherApp();

// ��д
	public:
	virtual BOOL InitInstance();

// ʵ��

	DECLARE_MESSAGE_MAP()
};

extern CMapFileWatcherApp theApp;