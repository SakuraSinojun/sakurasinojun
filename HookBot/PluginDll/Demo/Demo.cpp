// Demo.cpp : 定义 DLL 的初始化例程。
//

#include "stdafx.h"
#include "Demo.h"
#include "PlugWin.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

//
//TODO: 如果此 DLL 相对于 MFC DLL 是动态链接的，
//		则从此 DLL 导出的任何调入
//		MFC 的函数必须将 AFX_MANAGE_STATE 宏添加到
//		该函数的最前面。
//
//		例如:
//
//		extern "C" BOOL PASCAL EXPORT ExportedFunction()
//		{
//			AFX_MANAGE_STATE(AfxGetStaticModuleState());
//			// 此处为普通函数体
//		}
//
//		此宏先于任何 MFC 调用
//		出现在每个函数中十分重要。这意味着
//		它必须作为函数中的第一个语句
//		出现，甚至先于所有对象变量声明，
//		这是因为它们的构造函数可能生成 MFC
//		DLL 调用。
//
//		有关其他详细信息，
//		请参阅 MFC 技术说明 33 和 58。
//

// CDemoApp


BEGIN_MESSAGE_MAP(CDemoApp, CWinApp)
END_MESSAGE_MAP()


// CDemoApp 构造

CDemoApp::CDemoApp()
{
	// TODO: 在此处添加构造代码，
	// 将所有重要的初始化放置在 InitInstance 中
}


// 唯一的一个 CDemoApp 对象

CDemoApp theApp;


// CDemoApp 初始化

BOOL CDemoApp::InitInstance()
{

	
	
	CWinApp::InitInstance();

	return TRUE;
}




PFNCALLBACKW m_pfnCallBack;

//char * m_Message;
wchar_t * m_MessageW;
wchar_t * m_SenderW;


CPlugWin * m_PlugWin=new CPlugWin();
wchar_t * bash=(wchar_t *) _T("HookBot测试插件<Repeater>启动.");






int WINAPI GetPlugInVersion()
{
	return VERSION_UNICODE;
}

//这个函数用以设定回调信息。
void WINAPI SetCallBackFun(PFNCALLBACK pfnCallBack)
{
}

void WINAPI SetCallBackFunW(PFNCALLBACKW pfnCallBack)
{
	m_pfnCallBack=pfnCallBack;
}



//返回插件描述
char * WINAPI GetInfo()
{
	return (char *)NULL;
}

wchar_t * WINAPI GetInfoW()
{
	return (wchar_t *)_T("测试用插件。");
}

//Bash界面。左下角常显小窗。简单设置可以放在这里。
void WINAPI CreateBash(HWND hParent,RECT rect)
{

	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	CWnd *pp=CWnd::FromHandle (hParent);
	m_PlugWin->Create(pp);
	m_PlugWin->ShowWindow (SW_SHOW);

	//m_PlugWin->SetParent (pp);

	//m_PlugWin->SetWindowPos(pp,rect.left ,rect.top ,0 ,0 ,SWP_NOSIZE);
	
	//::SetWindowPos(m_PlugWin->GetSafeHwnd(),hParent,rect.left ,rect.top ,0,0,SWP_NOSIZE);
	
	//m_PlugWin->SetParent ((CWnd *)hParent);
	//::SetParent (m_PlugWin->GetSafeHwnd() ,hParent);
	//m_PlugWin->ShowWindow (SW_SHOW);

}
void WINAPI DestroyBash()
{
	m_PlugWin->ShowWindow (SW_HIDE);
}

//最后一条消息，用于处理
void WINAPI SetMessage(char * data )
{
}

void WINAPI SetMessageW(wchar_t * data)
{
	
	CString tmp=CString(data);
	int l=tmp.GetLength ();
	tmp.Empty ();
	m_MessageW=data;
	/*
	m_MessageW=new wchar_t[l+1];
	memset(m_MessageW,0,(l+1)*sizeof(wchar_t));
	memcpy(m_MessageW,data,l*sizeof(wchar_t));
	*/

}

//发送者
void WINAPI SetSender(char * data)
{
}
void WINAPI SetSenderW(wchar_t * data)
{
	
	CString tmp=CString(data);
	int l=tmp.GetLength ();
	tmp.Empty();
	m_SenderW=data;

	/*
	m_SenderW=new wchar_t[l+1];
	memset(m_SenderW,0,(l+1)*sizeof(wchar_t));
	memcpy(m_SenderW,data,l*sizeof(wchar_t));
	*/

}


//主处理过程

void WINAPI run(HWND hInputWin,HWND hSendButton)
{
	
	m_pfnCallBack(hInputWin,hSendButton,m_MessageW);
	
	/*
	delete m_MessageW;
	delete m_SenderW;
	*/
}


void WINAPI runonce(HWND hInputWin,HWND hSendButton)
{


	m_pfnCallBack(hInputWin,hSendButton,bash);

}