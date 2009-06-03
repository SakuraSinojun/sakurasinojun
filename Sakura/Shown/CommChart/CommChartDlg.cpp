// CommChartDlg.cpp : implementation file
//

#include "stdafx.h"
#include "CommChart.h"
#include "CommChartDlg.h"
#include "DlgReadData.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About



class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCommChartDlg dialog

CCommChartDlg::CCommChartDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCommChartDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCommChartDlg)
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CCommChartDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCommChartDlg)
	DDX_Control(pDX, IDC_BUTTON3, m_Button2);
	DDX_Control(pDX, IDC_BUTTON2, m_button1);
	DDX_Control(pDX, IDC_COMBO4, m_Combo4);
	DDX_Control(pDX, IDC_COMBO5, m_Combo5);
	DDX_Control(pDX, IDC_COMBO3, m_Combo3);
	DDX_Control(pDX, IDC_COMBO2, m_Combo2);
	DDX_Control(pDX, IDC_COMBO1, m_Combo1);
	DDX_Control(pDX, IDC_MSCOMM1, m_Comm1);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CCommChartDlg, CDialog)
	//{{AFX_MSG_MAP(CCommChartDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON2, OnButton2)
	ON_BN_CLICKED(IDC_BUTTON3, OnButton3)
	ON_WM_WINDOWPOSCHANGED()
	ON_MESSAGE(WM_VVMESSAGE,OnVVMessage)
	ON_WM_SIZE()
	ON_WM_GETMINMAXINFO()
	ON_WM_TIMER()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCommChartDlg message handlers

BOOL CCommChartDlg::OnInitDialog()
{
	CDialog::OnInitDialog();
	// Add "About..." menu item to system menu.
	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);
	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}
	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	// TODO: Add extra initialization here

	//控件初始化
	m_Combo1.ResetContent ();
	ListCommPort();
	m_Combo1.SetCurSel (0);

	m_Combo2.SelectString (0,"9600");
	m_Combo3.SelectString (0,"N (缺省 Default)");
	m_Combo4.SelectString (0,"8");
	m_Combo5.SelectString (-1,"1");

	//图表类
	m_chart=new CChart();

	//图表放置位置，以IDC_STATIC1决定。
	CRect rect;
	CStatic *p=(CStatic *)this->GetDlgItem (IDC_STATIC1);
	p->GetClientRect (rect);
	//创建图表窗口。
	m_chart->Create("CKazukiChart","",WS_VISIBLE,rect,p,IDC_CHART1);

	this->ShowWindow (SW_MAXIMIZE);

	//::RegisterHotKey (this->GetSafeHwnd (),1001,1,VK_RETURN);

	/*
	
	m_pConnection.CreateInstance(__uuidof(Connection));


	try                 
	{
		// 打开Access库data.mdb
		m_pConnection->Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=data.mdb","","",adModeUnknown);
	}
	catch(_com_error e)
	{
		AfxMessageBox("数据库连接失败，确认数据库data.mdb是否在当前路径下!");
		return FALSE;
	}      


	m_pRecordset.CreateInstance(__uuidof(Recordset));

	try
	{
		m_pRecordset->Open("SELECT * FROM data",                // 查询DemoTable表中所有字段
							m_pConnection.GetInterfacePtr(),	 // 获取库接库的IDispatch指针
							adOpenDynamic,
							adLockOptimistic,
							adCmdText);
	}
	catch(_com_error *e)
	{
		AfxMessageBox(e->ErrorMessage());
	}      

	*/

	m_channel=new CChannel();
	m_channel->SetCallBackHwnd(this->GetSafeHwnd ());
	m_channel->run();




	return TRUE;  // return TRUE  unless you set the focus to a control
}


void CCommChartDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CCommChartDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CCommChartDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

//映射MSCOMM控件的消息

BEGIN_EVENTSINK_MAP(CCommChartDlg, CDialog)
    //{{AFX_EVENTSINK_MAP(CCommChartDlg)
	ON_EVENT(CCommChartDlg, IDC_MSCOMM1, 1 /* OnComm */, OnOnCommMscomm1, VTS_NONE)
	//}}AFX_EVENTSINK_MAP
END_EVENTSINK_MAP()

void CCommChartDlg::OnOnCommMscomm1() 
{
	// TODO: Add your control notification handler code here


	VARIANT variant_inp; 
	COleSafeArray safearray_inp; 
	LONG len,k; 
	BYTE rxdata[2048]; 
	char temp[100];


	switch(this->m_Comm1 .GetCommEvent ())
	{
	case 2:
		//收到数据
		
		variant_inp=this->m_Comm1.GetInput(); 
		safearray_inp=variant_inp; 
		len=safearray_inp.GetOneDimSize();
		for(k=0;k<len;k++) 
		{ 
			safearray_inp.GetElement(&k,rxdata+k); 
			char bt=*(char*)(rxdata+k); 
			//bt就是以字节表示的数据
			//调用CChart类成员函数进行绘图。
			this->m_chart->AddData (bt);
			
			
			
			/*
			
			//将bt写入某ACCESS数据库中。
			memset(temp,0,100);
			wsprintf(temp,"%d",bt);

			try{
				// 写入各字段值
				m_pRecordset->AddNew();
				m_pRecordset->PutCollect("data", _variant_t(temp));
				m_pRecordset->Update();	
				//::MessageBeep (-1);
				//AfxMessageBox("插入成功!");
			}catch(_com_error *e){
				AfxMessageBox(e->ErrorMessage());
			}      
			*/
		
		} 

		break;
	default:
		break;
	}

}

void CCommChartDlg::ListCommPort()
{
	//读取映射到注册表的当前存在端口。
	//位于HKLM\HARDWARE\DEVICEMAP\SERIALCOMM下

	HKEY	hKey;   
	LONG	ret;   
	OSVERSIONINFO	osvi;   
	BOOL	bOsVersionInfoEx;   
	char	keyinfo[100],comm_name[200],ValueName[200];   
	int		i;   
	DWORD	sType,Reserved,cbData,cbValueName;   


	ZeroMemory(&osvi,sizeof(OSVERSIONINFO));   
	osvi.dwOSVersionInfoSize=sizeof(OSVERSIONINFO);   

	memset(keyinfo,0,100);   
	strcpy(keyinfo,"HARDWARE\\DEVICEMAP\\SERIALCOMM");   
	i=0;   
	sType=REG_SZ;
	Reserved=0; 
	bOsVersionInfoEx=GetVersionEx(&osvi);   
	ret=RegOpenKeyEx(HKEY_LOCAL_MACHINE,keyinfo,0,KEY_ALL_ACCESS,&hKey);   
	if(ret==ERROR_SUCCESS)
	{     
		if(osvi.dwPlatformId==VER_PLATFORM_WIN32_WINDOWS)     
		{   
			for(i=1;i<=128;i++)   
			{           
				sprintf(comm_name,"COM%d",i);   
				m_Combo1.AddString(comm_name);   
			}   
		}else if(osvi.dwPlatformId == VER_PLATFORM_WIN32_NT)   
		{   
			do {   
				cbData=200;cbValueName=200;   
				memset(comm_name,0,200);     
				memset(ValueName,0,200);   
				ret=RegEnumValue(hKey,i,ValueName,&cbValueName,NULL,&sType,(LPBYTE)comm_name,&cbData);   
				if(ret==ERROR_SUCCESS)   
				{   
					m_Combo1.AddString(comm_name);   
					i++;   
				}   
			}while (ret==ERROR_SUCCESS);   
		}   
	}   
	RegCloseKey(hKey);
}

void CCommChartDlg::OnButton2() 
{
	// TODO: Add your control notification handler code here
	
	if(m_Comm1.GetPortOpen ())
	{
		//串口已打开时。
		//关闭串口。
		m_Comm1.SetPortOpen (FALSE);

		m_Combo1.EnableWindow (TRUE);
		m_Combo2.EnableWindow (TRUE);
		m_Combo3.EnableWindow (TRUE);
		m_Combo4.EnableWindow (TRUE);
		m_Combo5.EnableWindow (TRUE);

		this->m_button1.SetWindowText ("打开串口");
		m_Button2.EnableWindow (TRUE);
	}else{
		
		//打开串口
		CString tmp;
		CString res;
		int port;
		m_Combo1.GetWindowText (tmp);
		tmp=tmp.Right (tmp.GetLength ()-3);
		port=atoi(tmp.GetBuffer (tmp.GetLength ()+1));		//串口号
		
		m_Comm1.SetCommPort (port);

		m_Combo2.GetWindowText(tmp);
		res=tmp;
		m_Combo3.GetWindowText (tmp);
		res=res+"," + tmp.Left(1);
		m_Combo4.GetWindowText (tmp);
		res=res+","+ tmp;
		m_Combo5.GetWindowText (tmp);
		res=res+"," +tmp;
		//9600,n,8,1

		//AfxMessageBox(res);
		
		m_Comm1.SetSettings (res);							//串口参数
		m_Comm1.SetInBufferSize (1024);						//缓冲区
		m_Comm1.SetInBufferCount(0);					
		m_Comm1.SetInputMode (1);							//binary数据方式
		m_Comm1.SetInputLen (0);		
		m_Comm1.SetRThreshold (1);							//响应长茺
		
		m_Comm1.SetPortOpen (TRUE);

		this->m_button1 .SetWindowText ("关闭串口");
		m_Combo1.EnableWindow (FALSE);
		m_Combo2.EnableWindow (FALSE);
		m_Combo3.EnableWindow (FALSE);
		m_Combo4.EnableWindow (FALSE);
		m_Combo5.EnableWindow (FALSE);
		m_Button2.EnableWindow (FALSE);

	}


}

void CCommChartDlg::OnButton3() 
{
	// TODO: Add your control notification handler code here
	/*
	CSize size;
	CSetupDlg dlg;
	size=this->m_chart->GetCanvasSize ();
	dlg.SetCanvasSize (size);
	dlg.m_SplidWidth =m_chart->m_sWidth ;
	if(dlg.DoModal()==IDOK)
	{
		size=dlg.GetCanvasSize ();
		m_chart->SetCanvasSize (size);
		m_chart->SetSquareWIdth (dlg.m_SplidWidth );
	}else{

	}
	*/

	/*

	CDlgReadData dlg;

	if(dlg.DoModal ()==IDOK)
	{
		if(!m_pRecordset->BOF)
		{
			m_pRecordset->MoveFirst();
		}else{
			AfxMessageBox("表内数据为空");
			return;
		}
		
		if(dlg.result ==0)
		{
			_variant_t var;
			CString str;
			char data;
			try
			{
				while(!m_pRecordset->adoEOF)
				{
					var = m_pRecordset->GetCollect("data");
					if(var.vt != VT_NULL)
						str = (LPCSTR)_bstr_t(var);
					
					data=atoi(str.GetBuffer (str.GetLength ()+1));
					this->m_chart->AddData (data);
					m_pRecordset->MoveNext();
				}
			}catch(_com_error *e){
				AfxMessageBox(e->ErrorMessage());
			} 

		}else{
			m_Combo1.EnableWindow (FALSE);
			m_Combo2.EnableWindow (FALSE);
			m_Combo3.EnableWindow (FALSE);
			m_Combo4.EnableWindow (FALSE);
			m_Combo5.EnableWindow (FALSE);
			m_button1.EnableWindow (FALSE);
			m_Button2.EnableWindow (FALSE);
			this->SetTimer (1,dlg.result ,NULL);	
		}
	}else{

	}

	*/

}

void CCommChartDlg::OnWindowPosChanged(WINDOWPOS FAR* lpwndpos) 
{
	CDialog::OnWindowPosChanged(lpwndpos);
	
	// TODO: Add your message handler code here

	
}

void CCommChartDlg::OnSize(UINT nType, int cx, int cy) 
{
	CDialog::OnSize(nType, cx, cy);
	
	// TODO: Add your message handler code here
	
	//这个函数调整控件位置.

	CRect rect;
	CRect rc;
	CStatic *p=(CStatic *)this->GetDlgItem(IDC_STATIC1);


	this->GetClientRect (rect);
	rc.left =120;
	rc.top =10;
	rc.right =rect.right -10;
	rc.bottom =rect.bottom -10;
	
	p->MoveWindow (rc);
	p->GetClientRect (rc);
	this->m_chart->MoveWindow (rc);



}

void CCommChartDlg::OnOK() 
{
	// TODO: Add extra validation here
	
//	CDialog::OnOK();
}

void CCommChartDlg::OnGetMinMaxInfo(MINMAXINFO FAR* lpMMI) 
{
	// TODO: Add your message handler code here and/or call default

	//决定窗口最小尺寸。

	lpMMI->ptMinTrackSize .x=640;
	lpMMI->ptMinTrackSize .y=480;
	CDialog::OnGetMinMaxInfo(lpMMI);
}

void CCommChartDlg::OnCancel() 
{
	/*
	// TODO: Add extra cleanup here
	m_pRecordset->Close();
	m_pRecordset = NULL;  

	if(m_pConnection->State)
        m_pConnection->Close();
	m_pConnection= NULL; 
	*/

	CDialog::OnCancel();
}

void CCommChartDlg::OnTimer(UINT nIDEvent) 
{
	// TODO: Add your message handler code here and/or call default
	
	CDialog::OnTimer(nIDEvent);
	
	/*
	if(nIDEvent==1)
	{	
		_variant_t var;
		CString str;
		char data;
		try
		{
			if(!m_pRecordset->adoEOF)
			{
				var = m_pRecordset->GetCollect("data");
				if(var.vt != VT_NULL)
					str = (LPCSTR)_bstr_t(var);
				
				data=atoi(str.GetBuffer (str.GetLength ()+1));
				this->m_chart->AddData (data);
				m_pRecordset->MoveNext();
			}else{
				this->KillTimer (1);
				m_Combo1.EnableWindow (TRUE);
				m_Combo2.EnableWindow (TRUE);
				m_Combo3.EnableWindow (TRUE);
				m_Combo4.EnableWindow (TRUE);
				m_Combo5.EnableWindow (TRUE);
				m_button1.EnableWindow (TRUE);
				m_Button2.EnableWindow (TRUE);
			}
		}catch(_com_error *e){
			AfxMessageBox(e->ErrorMessage());
		}     
	}else{
	}

	*/
}


LRESULT	CCommChartDlg::OnVVMessage(WPARAM wParam,LPARAM lParam)
{
	//char * temp=(char *)lParam;

	CHANNELDATA	data;
	
	memcpy(&data,(void *)lParam,1024);
	int i;
	char chr;


	if(data.length !=0)
	{
		for(i=0;i<data.length ;i++)
		{
			chr=*(data.data +i);
			this->m_chart->AddData(chr);
		}
	}

	return 0;
}
