// camera.cpp : Defines the entry point for the application.
//
// FlatComboMain.cpp : Defines the entry point for the application.
//

#include "stdafx.h"
#include <stdio.h>
#include <vfw.h>
#pragma comment(lib,"vfw32.lib")

HWND ghWndCap ;
HWND hBtn1,hBtn2,hBtn3;
CAPDRIVERCAPS gCapDriverCaps ; 
CAPSTATUS gCapStatus ; 
char szCaptureFile[] = "Capture.avi";

HINSTANCE m_hInstance;



LRESULT CALLBACK WndProc(HWND,UINT,WPARAM,LPARAM);


LRESULT CALLBACK StatusCallbackProc(HWND hWnd,int nID,LPSTR lpStatusText)
{
	if(!ghWndCap)return FALSE;

	capGetStatus(ghWndCap,&gCapStatus,sizeof(CAPSTATUS));

	SetWindowPos(ghWndCap,NULL,0,0,gCapStatus.uiImageWidth,gCapStatus.uiImageHeight,SWP_NOZORDER|SWP_NOMOVE);

	return (LRESULT)TRUE;

}


LRESULT CALLBACK ErrorCallbackProc(HWND hWnd,int nErrID,LPSTR lpErrorText)
{
	char gachBuffer[20];
	if(!ghWndCap)return FALSE;
	if(nErrID==0)return TRUE;
	wsprintf(gachBuffer,"Error# %d",nErrID);
	MessageBox(hWnd, lpErrorText, gachBuffer,MB_OK | MB_ICONEXCLAMATION); 
	return (LRESULT) TRUE;

} 

LRESULT CALLBACK FrameCallbackProc(HWND hWnd,LPVIDEOHDR lpVHdr)
{
	return (LRESULT)true;
} 


int WINAPI WinMain(HINSTANCE hInstance,HINSTANCE hPrevInstance,PSTR szCmdLine,int iCmdShow)
{
	static TCHAR szAppName[]=TEXT("MainCameraClass");
	HWND hwnd;
	MSG msg;
	
	m_hInstance=hInstance;

	WNDCLASS wndclass;
	wndclass.style=CS_HREDRAW|CS_VREDRAW;
	wndclass.lpfnWndProc=WndProc;
	wndclass.cbClsExtra=0;
	wndclass.cbWndExtra=0;
	wndclass.hInstance=hInstance;
	wndclass.hIcon=LoadIcon(NULL,IDI_APPLICATION);
	wndclass.hCursor=LoadCursor(NULL,IDC_ARROW);
	wndclass.hbrBackground=(HBRUSH)GetStockObject(WHITE_BRUSH);
	wndclass.lpszMenuName=NULL;
	wndclass.lpszClassName=szAppName;

	if(!RegisterClass(&wndclass))
	{
		MessageBox(NULL,TEXT("This program requires WindowsNT!"),szAppName,MB_ICONERROR);
		return 0;
	}

	hwnd=CreateWindow(szAppName,
			TEXT("Cemera Test"),
			WS_OVERLAPPEDWINDOW,
			CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,
			NULL,
			NULL,
			hInstance,
			NULL);
	
	
	ShowWindow(hwnd,iCmdShow);
	UpdateWindow(hwnd);

	while(GetMessage(&msg,NULL,0,0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}
	return msg.wParam;
}


LRESULT CALLBACK WndProc(HWND hwnd,UINT uMsg,WPARAM wParam,LPARAM lParam)
{

	switch(uMsg)
	{
		case WM_CREATE:
		{
			ghWndCap=capCreateCaptureWindow((LPSTR)"Capture   Window",
					WS_CHILD|WS_VISIBLE,
					0,0,800,600,
					(HWND)hwnd,
					(int)0); 

			
			hBtn1 = CreateWindowEx(0,
								"Button",  
								 "capDlgVideoSource",
								 WS_CHILD | WS_VISIBLE  | BS_PUSHBUTTON | WS_TABSTOP | WS_EX_LTRREADING | BS_TEXT, 
								 640, 100, 300, 30,
								 hwnd,
								 (HMENU)1001, 
								 m_hInstance,
								 NULL);

			hBtn2 = CreateWindow("Button",  
								 "capDlgVideoFormat",
								 WS_CHILD | WS_VISIBLE  , 
								 640, 200, 300, 30,
								 hwnd,
								 (HMENU)1002, 
								 m_hInstance,
								 NULL);
			
			hBtn3 = CreateWindow("Button",  
								 "nothing",
								 WS_CHILD | WS_VISIBLE  , 
								 640, 300, 300, 30,
								 hwnd,
								 (HMENU)1003, 
								 m_hInstance,
								 NULL);

			capSetCallbackOnError(ghWndCap,(FARPROC)ErrorCallbackProc); 
			capSetCallbackOnStatus(ghWndCap,(FARPROC)StatusCallbackProc);
			capSetCallbackOnFrame(ghWndCap,(FARPROC)FrameCallbackProc);
			
			capDriverConnect(ghWndCap,0);   
			
			capDriverGetCaps(ghWndCap,&gCapDriverCaps,sizeof(CAPDRIVERCAPS));
			
			capPreviewRate(ghWndCap, 60); 
			
			capPreview(ghWndCap, TRUE); 


			if(gCapDriverCaps.fHasOverlay) 
				capOverlay(ghWndCap,TRUE);
		}
		return 0;
		
		case WM_COMMAND:
		{
			try{
				switch(LOWORD(wParam))
				{
					case 1001:
					{
						if(gCapDriverCaps.fHasDlgVideoSource)
							capDlgVideoSource(ghWndCap); 
						break;
					}
					case 1002:
					{
						if(gCapDriverCaps.fHasDlgVideoFormat)
							capDlgVideoFormat(ghWndCap);
						break;
					}
					case 1003:
					{ 
						//if(gCapDriverCaps.fHasDlgVideoDisplay)
							//capDlgVideoDisplay(ghWndCap); 
						/*
						capFileSetCaptureFile( ghWndCap, szCaptureFile); 

						capFileAlloc(ghWndCap, (1024L * 1024L * 5)); 
						capCaptureSequence(ghWndCap); 
						capGrabFrame(ghWndCap); 
						*/

						break;
					}
				}
			}catch(...){
				
			}
		}
		return 0;

		case WM_DESTROY:
		{
			capSetCallbackOnStatus(ghWndCap,NULL);
			capSetCallbackOnError(ghWndCap,NULL); 
			capSetCallbackOnFrame(ghWndCap,NULL);
			capCaptureAbort(ghWndCap);
			capDriverDisconnect(ghWndCap);
			PostQuitMessage(0);
		}
		return 0;
	}
	
	return DefWindowProc(hwnd,uMsg,wParam,lParam);
}