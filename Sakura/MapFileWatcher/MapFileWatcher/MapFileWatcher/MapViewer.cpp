// MapViewer.cpp : 实现文件
//

#include "stdafx.h"
#include "MapFileWatcher.h"
#include "MapViewer.h"


// CMapViewer

IMPLEMENT_DYNAMIC(CMapViewer, CWnd)



HWND	m_hwnd;
CString	m_filename;

HANDLE CMapViewer::m_hWatcher;


typedef struct tagTHREADSTRUCT
{
	HWND	m_hwnd;
	HANDLE	MapHandle;
}THREADSTRUCT;

#pragma pack(push)
#pragma pack(1)
struct CHANNELDATA
{
	long	length;
	char	data[1020];
};
#pragma pack(pop)

CMapViewer::CMapViewer()
{
	CMapViewer::m_hWatcher=NULL;

	this->m_PaintCont =NULL;

}

CMapViewer::~CMapViewer()
{
	this->StopWatcher();
}


BEGIN_MESSAGE_MAP(CMapViewer, CWnd)
	ON_WM_PAINT()
	ON_MESSAGE(WM_VVMESSAGE,OnVVMessage)
END_MESSAGE_MAP()



// CMapViewer 消息处理程序



void CMapViewer::SetFileName(wchar_t * szFileName)
{

	m_filename =CString(szFileName);

}



void CMapViewer::StartWatcher(void)
{

	HANDLE	MapHandle;
	THREADSTRUCT ts;

	ts.m_hwnd =this->m_hWnd;

	SECURITY_ATTRIBUTES Security;


	Security.bInheritHandle =0;
	Security.lpSecurityDescriptor=NULL;
	Security.nLength =sizeof(SECURITY_ATTRIBUTES);

	if((MapHandle=::OpenFileMapping(FILE_MAP_ALL_ACCESS, PAGE_READWRITE,(LPCWSTR)m_filename.GetBuffer(m_filename.GetLength ()+1)))==0)
	{
		MapHandle=::CreateFileMapping ((HANDLE)0xFFFFFFFF, &Security, PAGE_READWRITE, 0, 1024, (LPCWSTR)m_filename.GetBuffer(m_filename.GetLength ()+1));
	}

	MapHandle=MapViewOfFile(MapHandle, FILE_MAP_READ, 0, 0, 0);

	ts.MapHandle =MapHandle;

	this->m_hWatcher =::CreateThread (NULL,0,CMapViewer::TWatcher,(LPVOID)&ts,0,NULL);

	Sleep(100);



}

void CMapViewer::StopWatcher(void)
{
	ASSERT(m_hWatcher);
	::TerminateThread (m_hWatcher,0);
	m_hWatcher=NULL;
}

DWORD WINAPI CMapViewer::TWatcher(LPVOID lpParameter)
{
	char temp_ansi[1025];
	
	char data_old[1025];

	CHANNELDATA	data;

	THREADSTRUCT ts;

	memcpy(&ts,lpParameter,sizeof(THREADSTRUCT));

	//HANDLE mh=(HANDLE)lpParameter;

	memset(data_old,0,1025);

	while(true)
	{
		memset(temp_ansi,0,1025);
		memcpy(temp_ansi,ts.MapHandle ,1024);
		memcpy(&data,temp_ansi,1024);

		if(data.length !=0)
		{
			if(memcmp(data.data ,data_old,1020)!=0)
			{
				::SendMessage (ts.m_hwnd,WM_VVMESSAGE,0,(LPARAM)temp_ansi);
				memcpy(data_old,data.data,1020);
			}
		}
		Sleep(10);
	}

	return 0;
}

void CMapViewer::SetPaintCont(char * cont)
{
	wchar_t temp[10];
	int chr;
	CString res;

	int i;
	
	for(i=0;i<1024;i++)
	{
		//chr=(int)*(cont+i);
		
		chr=0;

		memset(&chr,0,4);
		memcpy(&chr,cont+i,1);

		::wsprintf (temp,_T("%02X "),chr);
		res=res+CString(temp);
	}

	i=res.GetLength ()+1;

	if(this->m_PaintCont ==NULL)
	{
	}else{
		delete this->m_PaintCont ;
	}

	this->m_PaintCont=new wchar_t[i];

	memset(this->m_PaintCont ,0,i*2);
	memcpy(this->m_PaintCont,res.GetBuffer (res.GetLength()+1),2*i);

	this->Invalidate (true);


}

void CMapViewer::OnPaint()
{
	CPaintDC dc(this); // device context for painting
	// TODO: 在此处添加消息处理程序代码
	// 不为绘图消息调用 CWnd::OnPaint()
	
	CRect rect;

	this->GetClientRect (rect);
	
	dc.Rectangle (rect);

	dc.DrawText (this->m_PaintCont ,100,rect,DT_LEFT | DT_TOP |DT_VCENTER | DT_WORDBREAK);
	
	//dc.TextOutW (0,0,this->m_PaintCont ,4095);


	/*
	l=::WideCharToMultiByte (CP_ACP,0,this->m_PaintCont ,-1,NULL,0,0,0);
	temp=new char[l+1];
	memset(temp,0,l+1);
	::WideCharToMultiByte (CP_ACP,0,this->m_PaintCont,-1,temp,l,0,0);


	::DrawTextA(dc.GetSafeHdc() ,(LPCSTR)temp,l,rect,DT_LEFT | DT_TOP |DT_VCENTER | DT_WORDBREAK);

	//dc.DrawTextA(temp,l+1,rect,DT_LEFT | DT_TOP |DT_VCENTER | DT_WORDBREAK);
	*/

}

LRESULT CMapViewer::OnVVMessage(WPARAM wParam, LPARAM lParam)
{

	char * temp=(char *)lParam;
	this->SetPaintCont(temp);

	return LRESULT();
}
