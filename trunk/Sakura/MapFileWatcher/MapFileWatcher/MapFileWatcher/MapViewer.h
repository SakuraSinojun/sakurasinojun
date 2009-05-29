#pragma once


// CMapViewer

#define WM_VVMESSAGE WM_USER+0x101


class CMapViewer : public CWnd
{
	DECLARE_DYNAMIC(CMapViewer)

public:
	CMapViewer();
	virtual ~CMapViewer();

	static HANDLE m_hWatcher;


protected:
	DECLARE_MESSAGE_MAP()
public:
	void SetFileName(wchar_t * szFileName);
	void StartWatcher(void);
	void StopWatcher(void);
	static DWORD WINAPI TWatcher(LPVOID lpParameter);
	void SetPaintCont(char * cont);


private:
	
	wchar_t * m_PaintCont;


public:
	afx_msg void OnPaint();
	LRESULT OnVVMessage(WPARAM wParam, LPARAM lParam);
};


