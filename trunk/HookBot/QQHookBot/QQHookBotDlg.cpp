// QQHookBotDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "QQHookBot.h"
#include "QQHookBotDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif




#define �������ظ�ѡ����
#define DEBUG_���·��




CListBox * List1;

HWND hMainList[10240];

int hMainListIndex;
HWND m_nSelected;

CEdit * m_Edit1;
/*
CEdit * m_Edit2;
CEdit * m_Edit3;
CEdit * m_Edit4;
CEdit * m_Edit5;
*/

CWinBot tmpWinBot;

CRichEditCtrl *m_cRich;


CPlugIn * CQQHookBotDlg::m_cPlug =NULL;

/*
typedef LRESULT (WINAPI * CBSTREAMIN)(DWORD dwCookie,LPBYTE pbBuff,LONG cb,LONG * pcb);
HINSTANCE hIns=::LoadLibrary (_T("RichEditCallBack.dll"));
CBSTREAMIN pfnCBStreamIn = (CBSTREAMIN)GetProcAddress(hIns, ("CBStreamIn"));

*/



/******************************************************************************
/
/
/				�������൱��Ļص�����
/
/
/*****************************************************************************/

static DWORD CALLBACK CBStreamIn(DWORD dwCookie,LPBYTE pbBuff,LONG cb,LONG * pcb)
{

	CFile*   pFile   =   (CFile*)   dwCookie;      
    *pcb   =   pFile->Read(pbBuff,   cb);   
	
    return   0;   
}




long _stdcall rdCallBack(wchar_t * data)
{

    CFile   cFile(TEXT("swap.rtf"),   CFile::modeRead); 

    EDITSTREAM   es;   
    es.dwCookie   =   (DWORD)   &cFile;   
    es.pfnCallback   =   CBStreamIn;     
    m_cRich->StreamIn(SF_RTF,   es);   

	m_cRich->LineScroll (m_cRich->GetLineCount ()-1,0);

	//::SendMessage(m_cRich->GetSafeHwnd (),WM_LBUTTONDOWN,0,0);
	//::SendMessage (m_cRich->GetSafeHwnd (),WM_LBUTTONUP,0,0);
	
	return 0;
}



BOOL CALLBACK EnumWindowsProc(HWND hwnd,LPARAM lParam)
{

	int l;
	int i;
	wchar_t temp[10240];
	char * temp_ansi;
	CString caption;
	HWND hWnd;

	l=::GetWindowTextLength (hwnd);
	::GetWindowText (hwnd,(LPTSTR)temp,l+1);
	
	caption=CString(temp);
	
	//"(( �� (�߼�)?Ⱥ)|(^��( .*)|(����.*Ⱥ�� .*) (��̸)|(����)��)|( - QQ������)$)|(^�������� �� )"
   
	if (caption.IsEmpty() )return true;

	if (caption.Find(_T("�� Ⱥ")) >=0  || 
		caption.Find(_T("�� �߼�Ⱥ"))>=0 || 
		(/*caption.Find(_T("����"))>=0 && caption.Find(_T("Ⱥ��"))>=0 && */(caption.Find (_T("������"))>=0 || caption.Find(_T("��̸��"))>=0 ))  ||
		caption.Find (_T("- QQ������"))>=0 ||
		caption.Find (_T("��������"))>=0 ||
		caption.Find (_T("��������"))>=0)
    {
		memset(temp,0,10240);
		::wsprintf(temp,_T("%d          %s"),hwnd,caption.GetBuffer (caption.GetLength ()+1));
		List1->AddString((LPCTSTR)temp);
		hMainList[hMainListIndex]=hwnd;
		hMainListIndex++;
		
		for(i=0;i<List1->GetCount();i++)
		{
			memset(temp,0,10240);
			List1->GetText (i,temp);
			caption=CString(temp);
			l=caption.Find (TEXT("          "));
			caption=caption.Left(l);
			caption.Trim();
			l=caption.GetLength ();
			temp_ansi=new char[l+1];
			::WideCharToMultiByte (CP_ACP,0,caption.GetBuffer (l+1),-1,temp_ansi,l,0,false);
			hWnd=(HWND)atoi(temp_ansi);
			delete temp_ansi;

			if(tmpWinBot.GetMainWin ()==hWnd)
			{
				List1->SetCurSel (i);
				break;
			}
		}
	}

		

	return true;
}

BOOL CALLBACK ChildWindowProcess(HWND hwnd, LPARAM lParam)
{
	int l;
	wchar_t temp[1024];
	CString caption;
	CString clsName;
	HWND hParent;

	memset(temp,0,1024);

	l=::GetWindowTextLength(hwnd);
	::GetWindowText (hwnd,(LPWSTR)temp,l+2);
	caption=CString(temp);
	::GetClassName(hwnd,(LPWSTR)temp,sizeof(temp));
	clsName=CString(temp);
	hParent=::GetParent(hwnd);
	
	//classname == "RichEdit20A" && API.GetParent(hwnd) == windowhandle

	memset(temp,0,1024);
	::wsprintf (temp,_T("%d"),hwnd);

	if(_T("����(S)")==caption)
	{
		tmpWinBot.SetSendButton (hwnd);
		//m_Edit3->SetWindowText (temp);
	}else if(_T("RichEdit20A")==clsName && hParent==(HWND)lParam){
		tmpWinBot.SetMsgWin (hwnd);
		//m_Edit4->SetWindowText (temp);

		tmpWinBot.SetInfoCallBack (rdCallBack);
		tmpWinBot.StartListen ();

	}else if(_T("RichEdit20A")==clsName && hParent!=(HWND)lParam){
		tmpWinBot.SetInputWin (hwnd);
		//m_Edit5->SetWindowText (temp);
	}else{
	}

	return true;
}





/******************************************************************************
/
/
/				�ص���������
/
/
/*****************************************************************************/

// CQQHookBotDlg �Ի���


CQQHookBotDlg::CQQHookBotDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CQQHookBotDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CQQHookBotDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_LIST1, m_ListBox1);

	DDX_Control(pDX, IDC_BUTTON2, btnStart);
	DDX_Control(pDX, IDC_BUTTON5, btnStop);
	DDX_Control(pDX, IDC_LIST2, m_ListBox2);
}

BEGIN_MESSAGE_MAP(CQQHookBotDlg, CDialog)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDC_BUTTON1, &CQQHookBotDlg::OnBnClickedButton1)
	ON_LBN_SELCHANGE(IDC_LIST1, &CQQHookBotDlg::OnLbnSelchangeList1)
	ON_BN_CLICKED(IDC_BUTTON2, &CQQHookBotDlg::OnBnClickedButton2)
	ON_BN_CLICKED(IDOK, &CQQHookBotDlg::OnBnClickedOk)
	ON_BN_CLICKED(IDC_BUTTON3, &CQQHookBotDlg::OnBnClickedButton3)
//	ON_EN_VSCROLL(IDC_RICHEDIT21, &CQQHookBotDlg::OnEnVscrollRichedit21)
ON_EN_CHANGE(IDC_RICHEDIT21, &CQQHookBotDlg::OnEnChangeRichedit21)
ON_WM_TIMER()
ON_BN_CLICKED(IDC_BUTTON5, &CQQHookBotDlg::OnBnClickedButton5)
ON_LBN_SELCHANGE(IDC_LIST2, &CQQHookBotDlg::OnLbnSelchangeList2)
END_MESSAGE_MAP()


// CQQHookBotDlg ��Ϣ�������

BOOL CQQHookBotDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// ���ô˶Ի����ͼ�ꡣ��Ӧ�ó��������ڲ��ǶԻ���ʱ����ܽ��Զ�
	//  ִ�д˲���
	SetIcon(m_hIcon, TRUE);			// ���ô�ͼ��
	SetIcon(m_hIcon, FALSE);		// ����Сͼ��

	// TODO: �ڴ���Ӷ���ĳ�ʼ������


	FindPlugin();

	CWnd *pWnd=(CWnd *) this->GetDlgItem (IDC_EDIT2);
	CWinBot::SetBash (pWnd->GetSafeHwnd () );
	pWnd->SetWindowTextW (_T("\r\n\r\n\r\n\r\n�������б���ѡ��һ�����."));

	m_PlugPath=CString(_T(""));

	m_Edit1=(CEdit *)this->GetDlgItem (IDC_EDIT1);

	m_cRich=(CRichEditCtrl *)this->GetDlgItem(IDC_RICHEDIT21);

	this->SetTimer (1,1000,NULL);

	OnBnClickedButton1();

	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
}

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void CQQHookBotDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // ���ڻ��Ƶ��豸������

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// ʹͼ���ڹ����������о���
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// ����ͼ��
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

//���û��϶���С������ʱϵͳ���ô˺���ȡ�ù��
//��ʾ��
HCURSOR CQQHookBotDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}


void CQQHookBotDlg::OnBnClickedButton1()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������

	
	List1=&m_ListBox1;

	List1->ResetContent ();
	hMainListIndex=0;

	::EnumWindows(EnumWindowsProc,(LPARAM)NULL);

}

void CQQHookBotDlg::OnLbnSelchangeList1()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������


	int i=List1->GetCurSel();
	
	HWND hWnd;
	
	wchar_t temp[1024];
	char * temp_ansi;

	int l;

	CString tmp;

	if(LB_ERR==i) return;
	

	List1->GetText (i,tmp);

	i=tmp.Find (_T("          "));
	if(-1==i)return;

	tmp=tmp.Left(i);
	tmp.Trim();

	l=::WideCharToMultiByte (CP_ACP,0,tmp.GetBuffer(tmp.GetLength ()+1),-1,NULL,0,0,false);
	temp_ansi=new char[l+1];

	::WideCharToMultiByte (CP_ACP,0,(tmp.GetBuffer(tmp.GetLength ()+1)),-1,temp_ansi,l,0,false);
	hWnd=(HWND)atoi(temp_ansi);

	
	memset(temp,0,1024);
	::wsprintf (temp,_T("%d"),hWnd);
	

	tmpWinBot.SetMainWin (hWnd);

	tmpWinBot.SetListenMain (hWnd);

	i=this->IsInWinList (hWnd);
	if(i>=0)
	{
		btnStart.EnableWindow (!WinList[i].IsThreadBusy ());
		btnStop.EnableWindow (WinList[i].IsThreadBusy ());
		#ifndef �������ظ�ѡ����
		m_ListBox2.EnableWindow (!WinList[i].IsThreadBusy ());
		#endif
	}else{
		btnStart.EnableWindow (true);
		btnStop.EnableWindow(false);
		#ifndef �������ظ�ѡ����
		m_ListBox2.EnableWindow (true);
		#endif
	}

	::EnumChildWindows (hWnd,ChildWindowProcess,(LPARAM)hWnd);
	

}


int CQQHookBotDlg::FindFirstEmptyWinList ()
{

	int i;
	for(i=0;i<=MAXWINLIST;i++)
	{
		if(WinList[i].GetMainWin() ==(HWND)NULL)
		{
			return i;
		}
	}
	return -1;
}

int CQQHookBotDlg::IsInWinList(HWND hWnd)
{
	int i;
	for(i=0;i<=MAXWINLIST;i++)
	{
		if(WinList[i].GetMainWin() ==hWnd)
		{
			return i;
		}
	}
	return -1;
}

void CQQHookBotDlg::OnBnClickedButton2()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������

	int j;
	int k;

	if(m_PlugPath==CString(_T("")))
	{
		AfxMessageBox(_T("��ѡ��һ�������"),MB_ICONINFORMATION,0);
		return ;
	}

	j=IsInWinList(tmpWinBot.GetMainWin ());
	if(j>=0)
	{
	}else{
		k=this->FindFirstEmptyWinList ();
		WinList[k].SetMainWin (tmpWinBot.GetMainWin ());
		WinList[k].SetInputWin (tmpWinBot.GetInputWin ());
		WinList[k].SetMsgWin (tmpWinBot.GetMsgWin ());
		WinList[k].SetSendButton (tmpWinBot.GetSendButton ());
		WinList[k].SetInfoCallBack (rdCallBack);
		WinList[k].SetPlugInLibrary (m_PlugPath.GetBuffer (m_PlugPath.GetLength()+1));
		j=k;
	}

	WinList[j].run();
		
	btnStart.EnableWindow (false);
	btnStop.EnableWindow (true);

	#ifndef �������ظ�ѡ����
	m_ListBox2.EnableWindow (false);
	#endif

}

void CQQHookBotDlg::OnBnClickedOk()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	//OnOK();


}

void CQQHookBotDlg::OnBnClickedButton3()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������

	
	HWND hInputWin=tmpWinBot.GetInputWin ();
	wchar_t * res;


	int l=m_Edit1->GetWindowTextLength();
	res=new wchar_t[l+2];
	memset(res,0,l+2);

	m_Edit1->GetWindowText(res,l+1);

	if(0==l)return ;

	::SendMessage(hInputWin,EM_SETSEL,0,-1);
	::SendMessage (hInputWin,EM_REPLACESEL,1,(LPARAM)res);

	::Sleep(100);
	::SendMessage (tmpWinBot.GetSendButton (),WM_LBUTTONDOWN,0,0);
	::SendMessage (tmpWinBot.GetSendButton (),WM_LBUTTONUP,0,0);

	m_Edit1->SetWindowTextW (_T(""));

	delete res;


}

//void CQQHookBotDlg::OnEnVscrollRichedit21()
//{
//	// TODO: �ڴ���ӿؼ�֪ͨ����������
//	
//}

void CQQHookBotDlg::OnEnChangeRichedit21()
{
	// TODO:  ����ÿؼ��� RICHEDIT �ؼ�������������
	// ���͸�֪ͨ��������д CDialog::OnInitDialog()
	// ���������� CRichEditCtrl().SetEventMask()��
	// ͬʱ�� ENM_CHANGE ��־�������㵽�����С�

	// TODO:  �ڴ���ӿؼ�֪ͨ����������


	m_cRich->LineScroll (m_cRich->GetLineCount ()-1,0);


}

void CQQHookBotDlg::OnTimer(UINT_PTR nIDEvent)
{
	// TODO: �ڴ������Ϣ�����������/�����Ĭ��ֵ
	
	

	int i = List1->GetCurSel(); 
	

	
	//m_nSelected=tmpWinBot.GetMainWin ();

	OnBnClickedButton1();

	CDialog::OnTimer(nIDEvent);
}

void CQQHookBotDlg::OnBnClickedButton5()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������

	int j;
	int k;


	j=IsInWinList(tmpWinBot.GetMainWin ());
	
	if(j>=0)
	{
	}else{
		k=this->FindFirstEmptyWinList ();
		WinList[k].SetMainWin (tmpWinBot.GetMainWin ());
		WinList[k].SetInputWin (tmpWinBot.GetInputWin ());
		WinList[k].SetMsgWin (tmpWinBot.GetMsgWin ());
		WinList[k].SetSendButton (tmpWinBot.GetSendButton ());
		WinList[k].SetInfoCallBack (rdCallBack);
		//WinList[k].SetPlugInLibrary (m_PlugPath.GetBuffer (m_PlugPath.GetLength()+1));
		j=k;
	}

	WinList[j].stop();
	btnStart.EnableWindow (true);
	btnStop.EnableWindow (false);
	#ifndef �������ظ�ѡ����
	m_ListBox2.EnableWindow (true);
	#endif
}










void CQQHookBotDlg::FindPlugin ()
{
	try{
		wchar_t * fname=new wchar_t[1024];
		WIN32_FIND_DATA fd;
		int l;


		HANDLE hSearch;
		wchar_t * filePathName=(wchar_t *)_T("Plugin\\*.dll");
		wchar_t * tmpPath=new wchar_t[256];

		char * temp_ansi;

		memset(fname,0, 1024 * sizeof(wchar_t));
		ZeroMemory(&fd, sizeof(WIN32_FIND_DATA));

		ZeroMemory(tmpPath, 256 * sizeof(wchar_t) );
	    
		
		bool bSearchFinished = false;
	    

		hSearch = FindFirstFile(filePathName, &fd);
		//Is directory

		l=::WideCharToMultiByte (CP_ACP,0,fd.cFileName ,-1,NULL,0,0,false);
		temp_ansi=new char[l+2];
		::WideCharToMultiByte (CP_ACP,0,fd.cFileName ,-1,temp_ansi,l,0,false);

		if( (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) && strcmp(temp_ansi, ".") && strcmp(temp_ansi, "..") )       
		{
			/*
			strcpy(tmpPath, rootDir);
			strcat(tmpPath, fd.cFileName);
			FindFileInDir(tmpPath, strRet);
			*/
		}else if(strcmp(temp_ansi, ".") && strcmp(temp_ansi, ".."))
		{
			::wsprintf(fname,_T("%-50.50s"), fd.cFileName);
			m_ListBox2.AddString (fname);
		}
		
		delete temp_ansi;

		while( !bSearchFinished )
		{
		   if( FindNextFile(hSearch, &fd) )
		   {
		   		l=::WideCharToMultiByte (CP_ACP,0,fd.cFileName ,-1,NULL,0,0,false);
				temp_ansi=new char[l+2];
				::WideCharToMultiByte (CP_ACP,0,fd.cFileName ,-1,temp_ansi,l,0,false);

				if( (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) && strcmp(temp_ansi, ".") && strcmp(temp_ansi, "..") ) 
				{
				   /*
					strcpy(tmpPath, rootDir);
					strcat(tmpPath, fd.cFileName);
					FindFileInDir(tmpPath, strRet);
					*/
				}else if( strcmp(temp_ansi, ".") && strcmp(temp_ansi, "..") )
				{
				   ::wsprintf(fname,_T("%-50.50s"), fd.cFileName);
					m_ListBox2.AddString (fname);
				}
				delete temp_ansi;
		   }else{
			   if( GetLastError() == ERROR_NO_MORE_FILES )          //Normal Finished
			   {
				  bSearchFinished = true;
			   }else{
				  bSearchFinished = true;     //Terminate Search
			   }
		   }  
		}
		FindClose(hSearch);
	}catch(...){
	}
}
void CQQHookBotDlg::OnLbnSelchangeList2()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������

	
	int i=this->m_ListBox2.GetCurSel();
	if(LB_ERR==i)return;

	CString temp;
	this->m_ListBox2.GetText (i,temp);
	
	temp.Trim();

#undef DEBUG_���·��
#ifdef DEBUG_���·��
	CString path=CString(_T("..\\Debug\\")) +temp;
#else
	CString path=CString(_T("Plugin\\"))+temp;
#endif

	m_PlugPath=path;

	if((CPlugIn *)NULL!=m_cPlug)
	{
		delete m_cPlug;
	}
	this->m_cPlug =new CPlugIn(path.GetBuffer (path.GetLength() +1));

	CWnd *p=(CWnd *)this->GetDlgItem (IDC_EDIT2);

	RECT rect;
	::GetWindowRect (p->GetSafeHwnd (),&rect);
	m_cPlug->CreateBash (p->GetSafeHwnd (),rect);

	#ifdef �������ظ�ѡ����
	m_ListBox2.EnableWindow (false);
	#endif	


}
