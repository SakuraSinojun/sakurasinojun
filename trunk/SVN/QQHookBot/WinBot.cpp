#include "StdAfx.h"
#include "WinBot.h"
#include "QQMsg.h"
#include "PlugIn.h"

typedef LRESULT (WINAPI * READRICHEDIT)(HWND hWnd,WPARAM mode);
HINSTANCE hInst=::LoadLibrary (_T("ReadRichEdit.dll"));
READRICHEDIT pfnReadRich = (READRICHEDIT)GetProcAddress(hInst, ("ReadRichEdit"));


long (__stdcall * m_lpFun)(wchar_t *);


HWND m_hWndListen;
HWND m_hWndListenMain;
HWND m_hDash;

HANDLE m_hMutex=::CreateMutex (NULL,true,_T("READRTF"));
HANDLE CWinBot::m_hMutex_PCB =::CreateMutex (NULL,true,_T("PLUGCALLBACK"));



void CALLBACK CWinBot::PlugCallBack (HWND hInputWin,HWND hSendButton,wchar_t *data)
{


	::WaitForSingleObject (m_hMutex_PCB,INFINITE);
	
	CString tmp=CString(data);
	int l=tmp.GetLength ();
	wchar_t * res=new wchar_t[l+1];
	memset(res,0,(l+1)*sizeof(wchar_t));
	memcpy(res,data,l*sizeof(wchar_t));

	::SendMessage(hInputWin,EM_SETSEL,0,-1);
	::SendMessage (hInputWin,EM_REPLACESEL,1,(LPARAM)res);
	::SendMessage (hSendButton,WM_LBUTTONDOWN,0,0);
	::SendMessage (hSendButton,WM_LBUTTONUP,0,0);

	::ReleaseMutex (m_hMutex_PCB);
}



#define CWinBot类实现隐藏
#ifdef  CWinBot类实现隐藏


CWinBot::CWinBot()
{
	this->m_MainWin =(HWND)NULL;
	this->m_hSendButton =(HWND)NULL;
	this->m_hInputWin =(HWND)NULL;
	//this->m_lpFun =NULL;
	this->m_IsBusy =false;
	this->m_THandle =(HANDLE)NULL;
	::ReleaseMutex (m_hMutex);
	::ReleaseMutex(m_hMutex_PCB);

}

CWinBot::~CWinBot()
{
	try{
		if(this->m_THandle )
		{
			::TerminateThread (m_THandle,0);
			::TerminateThread (this->m_ListenHandle ,0);
			::CloseHandle(m_THandle);
			::CloseHandle(m_THandle);
		}
	}catch(...){
	}
}

CWinBot::CWinBot(HWND MainWin,HWND hSendButton,HWND hInputWin,HWND hMsgWin)
{
	this->m_MainWin =MainWin;
	this->m_hSendButton =hSendButton;
	this->m_hInputWin =hInputWin;
	this->m_hMsgWin =hMsgWin;
	//this->m_lpFun =NULL;
	this->m_IsBusy =false;
	this->m_THandle =(HANDLE)NULL;
	::ReleaseMutex (m_hMutex);
	::ReleaseMutex(m_hMutex_PCB);
}

void CWinBot::SetMainWin (HWND MainWin)
{
	this->m_MainWin =MainWin;
}
void CWinBot::SetSendButton (HWND hSendButton)
{
	this->m_hSendButton =hSendButton;
}
void CWinBot::SetInputWin (HWND hInputWin)
{
	this->m_hInputWin =hInputWin;
}
void CWinBot::SetMsgWin (HWND hMsgWin)
{
	this->m_hMsgWin =hMsgWin;
}
HWND CWinBot::GetMainWin()
{
	return m_MainWin;
}

HWND CWinBot::GetInputWin ()
{
	return m_hInputWin;
}
HWND CWinBot::GetMsgWin ()
{
	return m_hMsgWin;
}
HWND CWinBot::GetSendButton ()
{
	return m_hSendButton;
}

void CWinBot::SetListenMain (HWND hWnd)
{
	m_hWndListenMain=hWnd;
}
void CWinBot::SetInfoCallBack(long (__stdcall *lpFun)(wchar_t *))
{
	m_lpFun =lpFun;
}


bool CWinBot::IsThreadBusy ()
{
	return this->m_IsBusy ;
}

void CWinBot::SetPlugInLibrary (wchar_t * data)
{
	CString tmp=CString(data);
	int l=tmp.GetLength ();
	this->m_PlugLibrary =new wchar_t[l+1];
	memset(m_PlugLibrary,0,(l+1)*sizeof(wchar_t));
	memcpy(m_PlugLibrary,data,l*sizeof(wchar_t));
}

wchar_t * CWinBot::GetPlugName ()
{
	return this->m_PlugLibrary ;
}

void CWinBot::SetBash (HWND hWnd)
{

	m_hDash=hWnd;
}

void CWinBot::run()
{
	if(this->IsThreadBusy()) return;
	if(this->GetMainWin()==NULL)return ;

	
	this->m_IsBusy =true;

	/*
	wchar_t temp[1024];
	memset(temp,0,sizeof(temp));
	
	::wsprintf(temp,_T("%ld  %ld"),this,hand);
	
	this->m_THandle =::CreateThread ((LPSECURITY_ATTRIBUTES)NULL,(DWORD)0,this->StartDiceBot,(LPVOID)temp,(DWORD)0,(LPDWORD)0);
	::WaitForSingleObject (m_THandle,100);
	*/

	HANDLE hand=::CreateThread((LPSECURITY_ATTRIBUTES)NULL,(DWORD)0,StartRound,(LPVOID)this,(DWORD)0,(LPDWORD)0);

	::WaitForSingleObject (hand,100);

	::CloseHandle (hand);
}

void CWinBot::stop()
{
	this->m_IsBusy =false;
	if(m_THandle)
	{
		::TerminateThread (m_THandle,0);
		m_THandle=NULL;
	}
}

#endif

DWORD WINAPI CWinBot::StartRound(LPVOID lpParam)
{
	//::CloseHandle(hand);

	CWinBot * pThis=(CWinBot *)lpParam;
	/*
	wchar_t temp[1024];
	memset(temp,0,sizeof(temp));
	::wsprintf(temp,_T("%ld  %ld  %ld  %ld  %ld  %ld"),pThis,pThis->m_MainWin,pThis->m_hSendButton,pThis->m_hInputWin,pThis->m_hMsgWin,pThis->m_lpFun);
	*/
	pThis->m_THandle =::CreateThread ((LPSECURITY_ATTRIBUTES)NULL,(DWORD)0,StartDiceBot,(LPVOID)lpParam,(DWORD)0,(LPDWORD)0);
	::WaitForSingleObject (pThis->m_THandle,-1);
	pThis->stop();

	return 0;
}



DWORD WINAPI CWinBot::StartDiceBot(LPVOID lpParam)
{
	CString cmd=CString((wchar_t *)lpParam);
	CString tmp;


	//AfxMessageBox(cmd);

//	int i;
	HWND hWinMain;
	HWND hSendButton;
	HWND hInputWin;
	HWND hMsgWin;
	CWinBot * clsMain;


	//wchar_t * temp;

//	char * temp_ansi;
	wchar_t *res;

	int l;
//	EDITSTREAM es;

	CQQMsg * Msg;


	CString LastMsg;


	LastMsg=_T("");

	CWinBot * pThis=(CWinBot *)lpParam;
	CPlugIn * pPlug=new CPlugIn(pThis->GetPlugName());
	
	
	pPlug->SetCallBackFun (PlugCallBack);

//	bool FLAG;


	
	//long (__stdcall * lpFun)(wchar_t *);
	
	
	try{

		clsMain=pThis;
		hWinMain=pThis->m_MainWin;
		hSendButton=pThis->GetSendButton ();
		hInputWin=pThis->GetInputWin ();
		hMsgWin=pThis->GetMsgWin ();

		if((CWinBot *)NULL==clsMain)return 0;


		while(true)
		{

			/*
			::WaitForSingleObject (m_hMutex,INFINITE);		
			temp_ansi=(char *)pfnReadRich(hMsgWin,SF_TEXT);
			l=strlen(temp_ansi);
			res=new wchar_t[l+1];
			//mbstowcs(res,temp_ansi,l);
			//上面这个函数不能顺利进行MBs2WCs的转化。。用下面这个API：
			::MultiByteToWideChar(CP_ACP,0,temp_ansi,-1,res,l+1);
			::ReleaseMutex (m_hMutex);
			*/

			l=::SendMessageW(hMsgWin,WM_GETTEXTLENGTH,0,0);

			res=new wchar_t[l*2+2];
			memset(res,0,l*2+2);

			::SendMessageW(hMsgWin,WM_GETTEXT,l*2,(LPARAM)res);

			Msg=new CQQMsg(res);

			delete res;

			//res=Msg->GetLastMessage ();
			res=Msg->GetSender ();
			pPlug->SetSender (res);
			res=Msg->GetMessage();
			pPlug->SetMessage (res);

			if(LastMsg==CString(res))
				continue;
			LastMsg=CString(res);
			pPlug->run(hInputWin,hSendButton);
			Sleep(100);
		}

	}catch(...)
	{
		clsMain->stop ();
		return 0;
	}

	return 0;
}




void CWinBot::StartListen ()
{
	try{
		if(m_ListenHandle)
		{
			::TerminateThread (this->m_ListenHandle,0 );
			::WaitForSingleObject (this->m_ListenHandle,-1);
		}
		m_hWndListen=this->m_hMsgWin ;
		this->m_ListenHandle =::CreateThread ((LPSECURITY_ATTRIBUTES)NULL,0,StartListenRound,(LPVOID)NULL,0,0);
	}catch(...){
	}
}

DWORD WINAPI CWinBot::StartListenRound (LPVOID lpParam)
{
	char *temp_ansi;
	wchar_t *res;
	int l;

	CString OldMsg;
	CString CurMsg;
	
	OldMsg=_T("");
	CurMsg=_T("");


	while(m_lpFun)
	{
		try{

			::WaitForSingleObject (m_hMutex,INFINITE);
 			temp_ansi=(char *)pfnReadRich(m_hWndListen,SF_RTF);
			l=strlen(temp_ansi);
			res=new wchar_t[l+2];
			memset(res,0,l+2);
			::MultiByteToWideChar(CP_ACP,0,temp_ansi,-1,res,l*2+2);
			CurMsg=CString(res);
			::ReleaseMutex(m_hMutex);

			if(CurMsg!=OldMsg)
			{
				//AfxMessageBox(res);

				CFile icFile(TEXT("swap.rtf"),CFile::modeCreate );
				icFile.Close();
				CFile cFile(TEXT("swap.rtf"),CFile::modeWrite );
				cFile.Write (temp_ansi,strlen(temp_ansi));
				cFile.Flush ();
				cFile.Close ();

				m_lpFun(res);
				OldMsg=CurMsg;
			}
			delete res;
			::Sleep(1000);
		}catch(...){
		}
	}
	return 0;
}
void CWinBot::StopListen ()
{
	try{
		::TerminateThread (m_ListenHandle,0);
		CloseHandle(m_ListenHandle);
		m_ListenHandle=NULL;
	}catch(...){
		this->m_ListenHandle =NULL;
	}
}
