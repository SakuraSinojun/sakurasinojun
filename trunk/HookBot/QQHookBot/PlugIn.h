#pragma once
#define VERSION_UNICODE 0
#define VERSION_ANSI 1


typedef void (WINAPI *PFNCALLBACK)(HWND,HWND,char *);
typedef void (WINAPI *PFNCALLBACKW)(HWND,HWND,wchar_t *);


typedef int (WINAPI * GETPLUGINVERSION)();
typedef void (WINAPI * SETCALLBACKFUN)(PFNCALLBACK);
typedef void (WINAPI * SETCALLBACKFUNW)(PFNCALLBACKW);
typedef char * (WINAPI * GETINFO)();
typedef wchar_t * (WINAPI * GETINFOW)();
typedef void (WINAPI * CREATEBASH)(HWND,RECT);
typedef void (WINAPI * DESTROYBASH)();
typedef void (WINAPI * SETMESSAGE)(char *);
typedef void (WINAPI * SETMESSAGEW)(wchar_t *);
typedef void (WINAPI * SETSENDER)(char *);
typedef void (WINAPI * SETSENDERW)(wchar_t *);
typedef void (WINAPI * RUN)(HWND,HWND);
typedef void (WINAPI * RUNONCE)(HWND,HWND);

class CPlugIn
{
public:
	CPlugIn(void);
	CPlugIn(wchar_t *);

	virtual ~CPlugIn(void);

public:
	int GetPlugInVersion();
	void SetCallBackFun(void *);
	//void SetCallBackFunW(PFNCALLBACKW);
	LRESULT GetInfo();
	//wchar_t * GetInfoW();
	void CreateBash(HWND,RECT);
	void DestroyBash();
	void SetMessage(void *);
	//void SetMessageW(wchar_t *);
	void SetSender(void *);
	//void SetSenderW(wchar_t *);
	void run(HWND hInputWin,HWND hSendButton);
	void runonce(HWND hInputWin,HWND hSendButton);

private:

	HINSTANCE m_hInst;
	int m_Ver;
private:
	
	GETPLUGINVERSION pfnGetPlugInVersion;
	SETCALLBACKFUN pfnSetCallBackFun;
	SETCALLBACKFUNW pfnSetCallBackFunW;
	GETINFO pfnGetInfo;
	GETINFOW pfnGetInfoW;
	CREATEBASH pfnCreateBash;
	DESTROYBASH pfnDestroyBash;
	SETMESSAGE pfnSetMessage;
	SETMESSAGEW pfnSetMessageW;
	SETSENDER pfnSetSender;
	SETSENDERW pfnSetSenderW;
	RUN pfnRun;
	RUNONCE pfnRunOnce;

};


