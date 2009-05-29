#include "StdAfx.h"
#include "IniFile.h"


CIniFile::CIniFile(CString FileName)
{
	m_strFileName = FileName;
}

CIniFile::~CIniFile()
{
}

CString CIniFile::ReadString(CString Section, CString Ident, CString Default)
{
	
	int nSize = 0, nLen = nSize-2;
	char *lpszReturnBuffer = 0;
	while(nLen==nSize-2)
	{
		nSize+=MAX_BUFFER_SIZE;
		if(lpszReturnBuffer) delete lpszReturnBuffer;
		lpszReturnBuffer = new char[nSize];
		nLen = GetPrivateProfileString(Section,Ident,Default,lpszReturnBuffer,//�������nSize-2
			nSize,m_strFileName);	//���ʾ���������Ȳ��㣬����MAX_BUFFER_SIZE
	}
	CString res=CString(lpszReturnBuffer);
	delete lpszReturnBuffer;
	return res;
}

void CIniFile::WriteString(CString Section, CString Ident, CString Value)
{
	if(WritePrivateProfileString(Section,Ident,Value,m_strFileName)==0)
		throw CIniFileException();
}



int CIniFile::ReadInteger(CString Section, CString Ident, int Default)
{
	CString strInt = ReadString(Section,Ident,CString(_T("")));
	if (strInt.IsEmpty())
	{
		return Default;
	}
	else
	{
		int l=strInt.GetLength ();
		char * temp_ansi=strInt.GetBuffer (l+1);
		l=atoi(temp_ansi);
		return l;
	}
}

void CIniFile::WriteInteger(CString Section, CString Ident, int Value)
{
	char buffer[50];
	::wsprintf (buffer,_T("%d"),Value);
	WriteString(Section,Ident,CString(buffer));
}

/*

void CIniFile::ReadSection(CString Section, CStringArray &Strings)
{
	Strings.RemoveAll();//����ַ�������
	int nSize = 0, nLen = nSize-2;
	char *lpszReturnBuffer = 0;
	while(nLen==nSize-2)
	{
		nSize+=MAX_BUFFER_SIZE;
		if(lpszReturnBuffer) delete lpszReturnBuffer;
		lpszReturnBuffer = new char[nSize];
		nLen = GetPrivateProfileString(Section,NULL,NULL,lpszReturnBuffer,//�������nSize-2
			nSize,m_strFileName);	//���ʾ���������Ȳ��㣬����MAX_BUFFER_SIZE
	}
	char *pName = new char[MAX_PATH];
	char *pStart, *pEnd;
	pStart = lpszReturnBuffer;
	pEnd =0;
	while(pStart!=pEnd)
	{
		pEnd = strchr(pStart,0);
		nLen = pEnd-pStart;
		if(nLen==0) break;
		strncpy(pName,pStart,nLen);
		pName[nLen] = 0;
		Strings.Add(pName);
		pStart = pEnd+1;
	}	
	delete lpszReturnBuffer;
	delete pName;
}

void CIniFile::ReadSections(CStringArray &Strings)
{
	Strings.RemoveAll();//����ַ�������
	int nSize = 0, nLen = nSize-2;
	char *lpszReturnBuffer = 0;
	while(nLen==nSize-2)
	{
		nSize+=MAX_BUFFER_SIZE;
		if(lpszReturnBuffer) delete lpszReturnBuffer;
		lpszReturnBuffer = new char[nSize];
		nLen = GetPrivateProfileSectionNames(lpszReturnBuffer,nSize,//�������nSize-2���ʾ
			m_strFileName);	//���������Ȳ��㣬����MAX_BUFFER_SIZE
	}
	char *pName = new char[MAX_PATH];
	char *pStart, *pEnd;
	pStart = lpszReturnBuffer;
	pEnd =0;
	while(pStart!=pEnd)
	{
		pEnd = strchr(pStart,0);
		nLen = pEnd-pStart;
		if(nLen==0) break;
		strncpy(pName,pStart,nLen);
		pName[nLen] = 0;
		Strings.Add(pName);
		pStart = pEnd+1;
	}
	delete lpszReturnBuffer;
	delete pName;
}

void CIniFile::EraseSection(CString Section)
{
	if(WritePrivateProfileString(Section,NULL,NULL,m_strFileName)==0)
		throw CIniFileException();
}

*/