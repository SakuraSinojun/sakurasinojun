// Demo.cpp : ���� DLL �ĳ�ʼ�����̡�
//

#include "stdafx.h"
#include "Demo.h"
#include "PlugWin.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

//
//TODO: ����� DLL ����� MFC DLL �Ƕ�̬���ӵģ�
//		��Ӵ� DLL �������κε���
//		MFC �ĺ������뽫 AFX_MANAGE_STATE ����ӵ�
//		�ú�������ǰ�档
//
//		����:
//
//		extern "C" BOOL PASCAL EXPORT ExportedFunction()
//		{
//			AFX_MANAGE_STATE(AfxGetStaticModuleState());
//			// �˴�Ϊ��ͨ������
//		}
//
//		�˺������κ� MFC ����
//		������ÿ��������ʮ����Ҫ������ζ��
//		��������Ϊ�����еĵ�һ�����
//		���֣������������ж������������
//		������Ϊ���ǵĹ��캯���������� MFC
//		DLL ���á�
//
//		�й�������ϸ��Ϣ��
//		����� MFC ����˵�� 33 �� 58��
//

// CDemoApp


BEGIN_MESSAGE_MAP(CDemoApp, CWinApp)
END_MESSAGE_MAP()


// CDemoApp ����

CDemoApp::CDemoApp()
{
	// TODO: �ڴ˴���ӹ�����룬
	// ��������Ҫ�ĳ�ʼ�������� InitInstance ��
}


// Ψһ��һ�� CDemoApp ����

CDemoApp theApp;


// CDemoApp ��ʼ��

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
wchar_t * bash=(wchar_t *) _T("HookBot���Բ��<Repeater>����.");






int WINAPI GetPlugInVersion()
{
	return VERSION_UNICODE;
}

//������������趨�ص���Ϣ��
void WINAPI SetCallBackFun(PFNCALLBACK pfnCallBack)
{
}

void WINAPI SetCallBackFunW(PFNCALLBACKW pfnCallBack)
{
	m_pfnCallBack=pfnCallBack;
}



//���ز������
char * WINAPI GetInfo()
{
	return (char *)NULL;
}

wchar_t * WINAPI GetInfoW()
{
	return (wchar_t *)_T("�����ò����");
}

//Bash���档���½ǳ���С���������ÿ��Է������
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

//���һ����Ϣ�����ڴ���
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

//������
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


//���������

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