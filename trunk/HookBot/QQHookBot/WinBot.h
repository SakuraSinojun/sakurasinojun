#pragma once

class CWinBot
{
public:
	CWinBot();
	CWinBot(HWND MainWin,HWND hSendButton,HWND hInputWin,HWND hMsgWin);

	virtual ~CWinBot();

	void SetMainWin(HWND MainWin);
	void SetSendButton(HWND hSendButton);
	void SetInputWin(HWND hInputWin);
	void SetMsgWin(HWND hMsgWin);
	void SetInfoCallBack(long (__stdcall * lpFun)(wchar_t *));
	void SetPlugInLibrary(wchar_t *);
	wchar_t * GetPlugName();
	
	static void SetBash(HWND);

	void run();
	void stop();

	HWND GetMainWin();
	HWND GetSendButton();
	HWND GetInputWin();
	HWND GetMsgWin();
  	bool IsThreadBusy();

	void StartListen();
	void SetListenMain(HWND hWnd);
	void StopListen();



	static void CALLBACK PlugCallBack(HWND hMsgWin,HWND hSendButton,wchar_t *data);
	static HANDLE m_hMutex_PCB;


private:
	HWND m_MainWin;
	HWND m_hSendButton;
	HWND m_hInputWin;
	HWND m_hMsgWin;
	HANDLE m_THandle;
	bool m_IsBusy;
	
	wchar_t * m_PlugLibrary;

	HANDLE m_ListenHandle;


	

	
	//long (__stdcall * m_lpFun)(wchar_t *);

	static DWORD WINAPI StartDiceBot(LPVOID lpParam);
	static DWORD WINAPI StartRound(LPVOID lpParam);

	static DWORD WINAPI StartListenRound(LPVOID lpParam);



};




