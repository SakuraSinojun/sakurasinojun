#pragma once

#define MAX_BUFFER_SIZE 2048;

class CIniFileException
{
public:
	CIniFileException() {};
	~CIniFileException() {};
};

class CIniFile  
{
public:
	CIniFile(CString FileName);
	virtual ~CIniFile();
	
	CString ReadString(CString Section, CString Ident, CString Default);
	void WriteString(CString Section, CString Ident, CString Value);
	int ReadInteger(CString Section, CString Ident, int Default);
	void WriteInteger(CString Section, CString Ident, int Value);

	/*
private:
	bool SectionExists(CString Section);
	
	void ReadSection(CString Section, CStringArray &Strings);
	void ReadSections(CStringArray &Strings);
	void ReadSectionValues(CString Section, CStringArray &Strings);
	void EraseSection(CString Section);
*/

protected:
	CString m_strFileName;
};
