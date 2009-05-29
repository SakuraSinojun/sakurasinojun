// Channel.h: interface for the CChannel class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_CHANNEL_H__4B30C648_CDA3_40F9_BD29_A06634E4C5B7__INCLUDED_)
#define AFX_CHANNEL_H__4B30C648_CDA3_40F9_BD29_A06634E4C5B7__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000


#include "IniFile.h"

#define WM_VVMESSAGE	WM_USER+0x101


#pragma pack(push)
#pragma pack(1)
struct CHANNELDATA
{
	long	length;
	char	data[1020];
};
#pragma pack(pop)



class CChannel  
{
public:
	void run();
	void SetCallBackHwnd(HWND hWnd);
	CChannel();
	virtual ~CChannel();

	static DWORD WINAPI TWatcher(LPVOID lpParameter);

	HANDLE	RFileHandle;
	HANDLE	SFileHandle;
	HANDLE	m_hWatcher;

	HWND	m_hWndCallBack;


};

#endif // !defined(AFX_CHANNEL_H__4B30C648_CDA3_40F9_BD29_A06634E4C5B7__INCLUDED_)
