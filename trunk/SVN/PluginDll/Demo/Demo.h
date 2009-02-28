// Demo.h : Demo DLL 的主头文件
//

#pragma once

#ifndef __AFXWIN_H__
	#error "在包含此文件之前包含“stdafx.h”以生成 PCH 文件"
#endif

#include "resource.h"		// 主符号


// CDemoApp
// 有关此类实现的信息，请参阅 Demo.cpp
//



class CDemoApp : public CWinApp
{
public:
	CDemoApp();

// 重写
public:
	virtual BOOL InitInstance();

	DECLARE_MESSAGE_MAP()
};




//这个函数用以返回DLL版本:Unicode或Ansi
#define VERSION_UNICODE 0
#define VERSION_ANSI 1

int WINAPI GetPlugInVersion();

//这个函数用以设定回调信息。
typedef void (WINAPI *PFNCALLBACK)(HWND,HWND,char *);
typedef void (WINAPI *PFNCALLBACKW)(HWND,HWND,wchar_t *);



void WINAPI SetCallBackFun(PFNCALLBACK);
void WINAPI SetCallBackFunW(PFNCALLBACKW);


//返回插件描述
char * WINAPI GetInfo();
wchar_t * WINAPI GetInfoW();

//Bash界面。左下角常显小窗。简单设置可以放在这里。
void WINAPI CreateBash(HWND,RECT);
void WINAPI DestroyBash();

//最后一条消息，用于处理
void WINAPI SetMessage(char *);
void WINAPI SetMessageW(wchar_t *);

//发送者

void WINAPI SetSender(char *);
void WINAPI SetSenderW(wchar_t *);


//主处理过程

void WINAPI run(HWND,HWND);



