// Channel.cpp: implementation of the CChannel class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "CommChart.h"
#include "Channel.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////





CChannel::CChannel()
{
	
	CString schn;
	CString rchn;
	SECURITY_ATTRIBUTES Security;
	
	m_hWndCallBack=NULL;	
	
	
	char* tmpPath=new char[MAX_PATH+5];
	memset(tmpPath,0,MAX_PATH+5);
	::GetCurrentDirectory (MAX_PATH,tmpPath);
	
	lstrcat(tmpPath,"\\channel.config");
	CIniFile * pIniFile=new CIniFile(tmpPath);
	
	schn=pIniFile->ReadString ("CHANNEL","SendChannel","0");
	rchn=pIniFile->ReadString ("CHANNEL","RecvChannel","0");

	CString path=CString("{A2EE168A-E017-478d-9630-721F32B557B0}S") + schn;

	

	Security.bInheritHandle =0;
	Security.lpSecurityDescriptor=NULL;
	Security.nLength =sizeof(SECURITY_ATTRIBUTES);

	if((SFileHandle=::OpenFileMapping(FILE_MAP_ALL_ACCESS, PAGE_READWRITE,(LPCSTR)path.GetBuffer(path.GetLength ()+1)))==0)
	{
		SFileHandle=::CreateFileMapping ((HANDLE)0xFFFFFFFF, &Security, PAGE_READWRITE, 0, 1024, (LPCSTR)path.GetBuffer(path.GetLength ()+1));
	}

	SFileHandle=MapViewOfFile(SFileHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);

	
	path=CString("{A2EE168A-E017-478d-9630-721F32B557B0}R") + rchn;

	if((RFileHandle=::OpenFileMapping(FILE_MAP_ALL_ACCESS, PAGE_READWRITE,(LPCSTR)path.GetBuffer(path.GetLength ()+1)))==0)
	{
		RFileHandle=::CreateFileMapping ((HANDLE)0xFFFFFFFF, &Security, PAGE_READWRITE, 0, 1024, (LPCSTR)path.GetBuffer(path.GetLength ()+1));
	}

	RFileHandle=MapViewOfFile(RFileHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);

	

}

CChannel::~CChannel()
{

}

void CChannel::SetCallBackHwnd(HWND hWnd)
{
	m_hWndCallBack=hWnd;

}

void CChannel::run()
{
	ASSERT(this->m_hWndCallBack);
	
	this->m_hWatcher=::CreateThread (NULL,0,CChannel::TWatcher,(LPVOID)this,0,NULL);
	
	Sleep(100);

}


DWORD WINAPI CChannel::TWatcher(LPVOID lpParameter)
{
	char temp_ansi[1025];
//	char data_old[1025];

	CHANNELDATA	data;
	CChannel * channel=(CChannel *)lpParameter;

//	memset(data_old,0,1025);

	while(true)
	{
		memset(temp_ansi,0,1025);
		memcpy(temp_ansi,channel->RFileHandle,1024);
		memcpy(&data,temp_ansi,1024);

		if(data.length !=0)
		{
			//if(memcmp(data.data,data_old,1020)!=0)
			{
				::SendMessage (channel->m_hWndCallBack,WM_VVMESSAGE,0,(LPARAM)temp_ansi);
				//memcpy(data_old,data.data ,1020);
				
				memset(channel->RFileHandle,0,1024);

			}
		}
		Sleep(1);
	}


}

