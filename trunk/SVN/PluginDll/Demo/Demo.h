// Demo.h : Demo DLL ����ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������


// CDemoApp
// �йش���ʵ�ֵ���Ϣ������� Demo.cpp
//



class CDemoApp : public CWinApp
{
public:
	CDemoApp();

// ��д
public:
	virtual BOOL InitInstance();

	DECLARE_MESSAGE_MAP()
};




//����������Է���DLL�汾:Unicode��Ansi
#define VERSION_UNICODE 0
#define VERSION_ANSI 1

int WINAPI GetPlugInVersion();

//������������趨�ص���Ϣ��
typedef void (WINAPI *PFNCALLBACK)(HWND,HWND,char *);
typedef void (WINAPI *PFNCALLBACKW)(HWND,HWND,wchar_t *);



void WINAPI SetCallBackFun(PFNCALLBACK);
void WINAPI SetCallBackFunW(PFNCALLBACKW);


//���ز������
char * WINAPI GetInfo();
wchar_t * WINAPI GetInfoW();

//Bash���档���½ǳ���С���������ÿ��Է������
void WINAPI CreateBash(HWND,RECT);
void WINAPI DestroyBash();

//���һ����Ϣ�����ڴ���
void WINAPI SetMessage(char *);
void WINAPI SetMessageW(wchar_t *);

//������

void WINAPI SetSender(char *);
void WINAPI SetSenderW(wchar_t *);


//���������

void WINAPI run(HWND,HWND);



