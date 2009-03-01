// ShareDLL.cpp : Defines the entry point for the DLL application.
//

#include "stdafx.h"
#include "ShareDLL.h"
#include "windows.h"

#pragma data_seg(".share")
	int INIT=0;
#pragma data_seg()
#pragma comment(linker,"/Section:.share,rws")

__declspec(allocate(".share")) char COM[256][1024];


BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
    switch (ul_reason_for_call)
	{
		case DLL_PROCESS_ATTACH:
			if(0==INIT)
			{
				//::MessageBox(NULL,"第一次运行.","FIRST",MB_OK | MB_ICONINFORMATION);
				memset(COM,0,256*1024);
				INIT=1;
			}
			break;
		case DLL_THREAD_ATTACH:
		case DLL_THREAD_DETACH:
		case DLL_PROCESS_DETACH:
			break;
    }
    return TRUE;
}


/*

// This is an example of an exported variable
SHAREDLL_API int nShareDLL=0;

// This is an example of an exported function.
SHAREDLL_API int fnShareDLL(void)
{
	return 42;
}

// This is the constructor of a class that has been exported.
// see ShareDLL.h for the class definition
CShareDLL::CShareDLL()
{ 
	return; 
}

*/

int _stdcall WriteSharedComm(int CommPort,char * data,int len)
{
	int i;

	//::MessageBox(NULL,data,"FIRST",MB_OK | MB_ICONINFORMATION);
	
	for(i=0;i<len;i++)
	{
		COM[CommPort][i]=*(data+i);
	}
	for(int j=len;j<1024;j++)
	{
		COM[CommPort][j]='\0';
	}
	return len;
}


int _stdcall ReadSharedComm(int CommPort,char * data)
{

	int i;
	int j ;
	for(i=1023;i>=0;i--)
	{
		if(COM[CommPort][i]!=0)break;
	}

	if(i==-1)return 0;

	for(j=0;j<=i;j++)
	{
		*(data+j)=COM[CommPort][j];
	}
	*(data+j)='\0';
	return j;
}
