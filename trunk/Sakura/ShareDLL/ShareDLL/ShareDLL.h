
// The following ifdef block is the standard way of creating macros which make exporting 
// from a DLL simpler. All files within this DLL are compiled with the SHAREDLL_EXPORTS
// symbol defined on the command line. this symbol should not be defined on any project
// that uses this DLL. This way any other project whose source files include this file see 
// SHAREDLL_API functions as being imported from a DLL, wheras this DLL sees symbols
// defined with this macro as being exported.
#ifdef SHAREDLL_EXPORTS
#define SHAREDLL_API __declspec(dllexport)
#else
#define SHAREDLL_API __declspec(dllimport)
#endif




// This class is exported from the ShareDLL.dll
/*
class SHAREDLL_API CShareDLL {
public:
	CShareDLL(void);
	// TODO: add your methods here.
};

extern SHAREDLL_API int nShareDLL;


SHAREDLL_API int fnShareDLL(void);
*/


SHAREDLL_API int _stdcall WriteSharedComm(int CommPort,char * data,int len);
SHAREDLL_API int _stdcall ReadSharedComm(int CommPort,char * data);

