#include "StdAfx.h"
#include "PlugIn.h"

CPlugIn::CPlugIn(void)
{
}

CPlugIn::~CPlugIn(void)
{
	::FreeLibrary (m_hInst);
}

CPlugIn::CPlugIn(wchar_t * PlugFile) 
{
	m_hInst=::LoadLibrary (PlugFile);
	pfnGetPlugInVersion=(GETPLUGINVERSION)::GetProcAddress (this->m_hInst ,"GetPlugInVersion");
	pfnSetCallBackFun=(SETCALLBACKFUN)::GetProcAddress (m_hInst,"SetCallBackFun");
	pfnSetCallBackFunW=(SETCALLBACKFUNW)::GetProcAddress (m_hInst,"SetCallBackFunW");
	pfnGetInfo=(GETINFO)::GetProcAddress (m_hInst,"GetInfo");
	pfnGetInfoW=(GETINFOW)::GetProcAddress (m_hInst,"GetInfoW");
	pfnCreateBash=(CREATEBASH)::GetProcAddress (m_hInst,"CreateBash");
	pfnDestroyBash=(DESTROYBASH)::GetProcAddress (m_hInst,"DestroyBash");
	pfnSetMessage=(SETMESSAGE)::GetProcAddress (m_hInst,"SetMessage");
	pfnSetMessageW=(SETMESSAGEW)::GetProcAddress(m_hInst,"SetMessageW");
	pfnSetSender=(SETSENDER)::GetProcAddress (m_hInst,"SetSender");
	pfnSetSenderW=(SETSENDERW)::GetProcAddress (m_hInst,"SetSenderW");
	pfnRun=(RUN)::GetProcAddress (m_hInst,"run");	
	pfnRunOnce=(RUNONCE)::GetProcAddress (m_hInst,"runonce");
	this->m_Ver =pfnGetPlugInVersion();
}



int CPlugIn::GetPlugInVersion()
{
	return this->m_Ver ;
}

void CPlugIn::SetCallBackFun(void * pfn)
{
	if(VERSION_UNICODE==m_Ver)
	{
		pfnSetCallBackFunW((PFNCALLBACKW)pfn);
	}else{
		pfnSetCallBackFun((PFNCALLBACK)pfn);
	}
}

LRESULT CPlugIn::GetInfo()
{
	char * temp_ansi;
	wchar_t * temp;
	if(VERSION_UNICODE!=m_Ver)
	{
		temp_ansi=pfnGetInfo();
		return (LRESULT)temp_ansi;
	}else{
		temp=this->pfnGetInfoW ();
		return (LRESULT)temp;
	}
}

void CPlugIn::CreateBash(HWND hwnd,RECT rect)
{
	this->pfnCreateBash (hwnd,rect);
}
void CPlugIn::DestroyBash()
{
	this->pfnDestroyBash ();
}
void CPlugIn::SetMessage(void * msg)
{
	if(VERSION_ANSI==m_Ver)
	{
		this->pfnSetMessage ((char *)msg);
	}else{
		this->pfnSetMessageW ((wchar_t *)msg);
	}
}
void CPlugIn::SetSender(void * Sender)
{
	if(VERSION_ANSI==m_Ver)
	{
		this->pfnSetSender ((char *)Sender);
	}else{
		this->pfnSetSenderW((wchar_t *)Sender);
	}
}
void CPlugIn::run(HWND hInputWin,HWND hSendButton)
{
	this->pfnRun (hInputWin,hSendButton);
}

	

void CPlugIn::runonce (HWND hInputWin,HWND hSendButton)
{
	this->pfnRunOnce (hInputWin,hSendButton);
}